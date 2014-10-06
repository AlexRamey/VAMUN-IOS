//
//  VAMTwitterClient.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface VAMTwitterClient : AFHTTPSessionManager

+(VAMTwitterClient *)sharedClient;

-(void)fetchTweetsWithCompletion:(void (^)(NSArray *result, NSError *error)) completion;

@end
