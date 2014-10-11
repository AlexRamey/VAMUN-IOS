//
//  VAMTwitterCard.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/11/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMTwitterCard.h"
#import "AFNetworking.h"

@implementation VAMTwitterCard

-(id)initWithUserTitle:(NSString *)userTitle screenName:(NSString *)screenName time:(NSString *)time tweet:(NSString *)tweet thumbnailURL:(NSString *)thumbnailURL offset:(CGFloat)offset callback:(id<HomeViewCallback>)hv
{
    
    // Initialization code
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"VAMTwitterCard"
                                                         owner:self
                                                       options:nil];
    
    self = [nibContents objectAtIndex:0];
    
    NSMutableAttributedString *attrName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ \u00B7 @%@", userTitle, screenName]];
    [attrName addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange([[attrName string] rangeOfString:@"\u00B7"].location + 2, [screenName length] + 1)];
    
    
    self.nameLabel.attributedText = attrName;
    
    self.timeLabel.text = [[time substringToIndex:[time rangeOfString:@":"].location - 2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    imageURL = thumbnailURL;
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:tweet];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:2];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, [tweet length])];
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica Neue" size:14] range:NSMakeRange(0, [tweet length])];
    
    self.tweetLabel.attributedText = attrString;
    
    [self.tweetLabel sizeToFit];
    
    
    self.frame = CGRectMake(0,offset,[[UIScreen mainScreen] bounds].size.width, self.tweetLabel.frame.size.height + self.tweetLabel.frame.origin.y + 10);
    
    [hv twitterCardCreatedWithHeight:self.frame.size.height];
    
    [self loadProfileThumbnailImage];
    
    return self;
    
}

-(void)loadProfileThumbnailImage
{
    UIActivityIndicatorView *loadIndicator = [[UIActivityIndicatorView alloc] init];
    loadIndicator.opaque = YES;
    loadIndicator.color = [UIColor blackColor];
    [loadIndicator setHidesWhenStopped:YES];
    loadIndicator.center = CGPointMake((_profileThumbnail.bounds.size.width - loadIndicator.bounds.size.width) / 2, (_profileThumbnail.bounds.size.height - loadIndicator.bounds.size.width) / 2);
    [_profileThumbnail addSubview: loadIndicator];
    [loadIndicator startAnimating];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _profileThumbnail.image = responseObject;
        [loadIndicator stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [loadIndicator stopAnimating];
    }];
    [requestOperation start];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
