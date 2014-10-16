//
//  VAMMerchandiseCard.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/16/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MerchandiseCallback;

@interface VAMMerchandiseCard : UIView

@property (nonatomic, weak) IBOutlet UIImageView *merchandisePicture;
@property (nonatomic, weak) IBOutlet UILabel *merchandiseLabel;

-(id)initWithImage:(UIImage *)image info:(NSString *)info offset:(CGFloat)offset callback:(id<MerchandiseCallback>)callback;

@end

@protocol MerchandiseCallback <NSObject>

-(void)merchandiseCardCreatedWithHeight:(CGFloat)height;

@end