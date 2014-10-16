//
//  VAMMerchandiseViewController.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMContentViewController.h"
#import "VAMMerchandiseCard.h"

@interface VAMMerchandiseViewController : VAMContentViewController <MerchandiseCallback>
{
    CGFloat yOffset;
    NSArray *merchandiseImageNames;
    NSArray *merchandiseInfo;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;



@end
