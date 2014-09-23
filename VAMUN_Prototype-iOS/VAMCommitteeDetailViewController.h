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
@property (nonatomic, weak) IBOutlet UIImageView *chairPicture;
@property (nonatomic, strong) NSString *imageURL;

@end
