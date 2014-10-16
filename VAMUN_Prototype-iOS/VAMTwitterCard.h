//
//  VAMTwitterCard.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/11/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewCallback;

@interface VAMTwitterCard : UIView
{
    NSString *imageURL;
}


-(id)initWithUserTitle:(NSString *)userTitle screenName:(NSString *)screenName time:(NSString *)time tweet:(NSString *)tweet thumbnailURL:(NSString *)thumbnailURL offset:(CGFloat)offset callback:(id <HomeViewCallback>)hv;

-(void)loadProfileThumbnailImage;

@property (nonatomic, strong) IBOutlet UIImageView *profileThumbnail;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *tweetLabel;

@end

@protocol HomeViewCallback <NSObject>

-(void)twitterCardCreatedWithHeight:(CGFloat)height;

@end
