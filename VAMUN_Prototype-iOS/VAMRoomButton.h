//
//  VAMRoomButton.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/15/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VAMRoomButton : UIButton

@property (strong,nonatomic) CAGradientLayer *backgroundLayer, *highlightBackgroundLayer;
@property (strong,nonatomic) CALayer *innerGlow;

@end
