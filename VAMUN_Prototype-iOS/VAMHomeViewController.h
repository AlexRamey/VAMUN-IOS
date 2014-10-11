//
//  VAMHomeViewController.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMContentViewController.h"
#import "VAMTwitterCard.h"

@interface VAMHomeViewController : VAMContentViewController <HomeViewCallback>
{
    CGFloat yOffset;
}

@property (nonatomic, strong) NSArray *twitterCards;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end
