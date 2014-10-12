//
//  VAMAnnotationView.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/12/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMAnnotationView.h"

@implementation VAMAnnotationView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(id)initWithAnnotation:(id<MKAnnotation>)annotationParam reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotationParam reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setAnnotation:annotationParam];
        [self setCanShowCallout:YES];
        
        //Set the rightCalloutAccessoryView property to a Detail Disclosure Button
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [self setRightCalloutAccessoryView:infoButton];
        
        //set image based on reuseIdentifier, which is just encoding the primary category
        
        [self setImage:[UIImage imageNamed:@"vamunmarker"]];
    }
    
    return self;
}

@end
