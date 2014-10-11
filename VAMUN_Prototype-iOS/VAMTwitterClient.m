//
//  VAMTwitterClient.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMTwitterClient.h"

@implementation VAMTwitterClient

static NSString * const TWITTER_CONSUMER_KEY = @"iqab1dW1TF7ch9hb8QaRI32K9";
static NSString * const TWITTER_CONSUMER_SECRET = @"JvYeFjmvdGh2TE8G8mSJEm2MYdKnj6RCDrneRyEWiCoG6hwA51";

+(VAMTwitterClient *)sharedClient
{
    static VAMTwitterClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/"]];
    });
    
    return sharedClient;
}

-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self)
    {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

-(void)fetchTweetsWithCompletion:(void (^)(NSArray *, NSError *))completion
{
    NSString *bearerTokenCredentials = [NSString stringWithFormat:@"%@:%@", TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET];
    
    NSData *bearerTokenCredentialsData = [bearerTokenCredentials dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64EncodedBearerTokenCredentials = [bearerTokenCredentialsData base64EncodedStringWithOptions:0];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.twitter.com/oauth2/token"]];
    [request setHTTPBody:[@"grant_type=client_credentials" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", base64EncodedBearerTokenCredentials];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    [[self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (responseObject && [responseObject objectForKey:@"access_token"])
        {
            NSString *bearerAccessToken = [responseObject objectForKey:@"access_token"];
            //NSMutableURLRequest *tweetsRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json?q=%23vamun+OR+%23vamun34+OR+%23vamunxxxiv"]];
            NSMutableURLRequest *tweetsRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json?q=%23uva&count=25"]];
            [tweetsRequest setValue:[NSString stringWithFormat:@"Bearer %@", bearerAccessToken] forHTTPHeaderField:@"Authorization"];
            request.HTTPMethod = @"GET";
            
            [[self dataTaskWithRequest:tweetsRequest completionHandler:^(NSURLResponse *response, id responseObject2, NSError *error2) {
                if (responseObject2)
                {
                    NSLog(@"RESPONSE OBJECT: %@", responseObject2);
                }
                if (responseObject2 && [responseObject2 objectForKey:@"statuses"])
                {
                    completion([responseObject2 objectForKey:@"statuses"], nil);
                }
                else
                {
                    if (!error2)
                    {
                        error2 = [[NSError alloc] init];
                    }
                    completion(nil, error2);
                }
            }] resume];
        }
        else
        {
            if (!error)
            {
                error = [[NSError alloc] init];
            }
            completion(nil, error);
        }
    }] resume];
    
}

@end
