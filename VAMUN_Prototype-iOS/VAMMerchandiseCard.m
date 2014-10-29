//
//  VAMMerchandiseCard.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/16/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMMerchandiseCard.h"

@implementation VAMMerchandiseCard

-(id)initWithImage:(UIImage *)image info:(NSString *)info offset:(CGFloat)offset callback:(id<MerchandiseCallback>)callback
{
    // Initialization code
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"VAMMerchandiseCard"
                                                         owner:self
                                                       options:nil];
    
    self = [nibContents objectAtIndex:0];
    
    self.frame = CGRectMake(0.0, offset, [UIScreen mainScreen].bounds.size.width, 150);
    
    [callback merchandiseCardCreatedWithHeight:150];
    
    _merchandisePicture.image = image;
    _merchandiseLabel.text = info;
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
