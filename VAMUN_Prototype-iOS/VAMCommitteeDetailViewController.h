//
//  VAMCommitteeDetailViewController.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 9/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VAMCommitteeDetailViewController : UIViewController

@property (nonatomic, strong) NSString *committeeName;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *chairName;
@property (nonatomic, strong) NSString *topics;
@property (nonatomic, strong) NSString *rooms;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *chairPicture;
@property (nonatomic, weak) IBOutlet UILabel *chairLabel;
@property (nonatomic, weak) IBOutlet UILabel *topicLabel;
@property (nonatomic, weak) IBOutlet UIButton *room1;
@property (nonatomic, weak) IBOutlet UIButton *room2;
@property (nonatomic, weak) IBOutlet UIButton *room3;


@end
