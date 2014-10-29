//
//  VAMMerchandiseViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMMerchandiseViewController.h"

@interface VAMMerchandiseViewController ()

@end

@implementation VAMMerchandiseViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        //custom initialization
        yOffset = 0;
        
        merchandiseInfo = @[@"Short Sleeve T-Shirts - $9.99", @"Long Sleeve T-Shirts - $14.99", @"Sunglasses - $3.99", @"Metal Water Bottles - $9.99", @"Cups - $3.99"];
        merchandiseImageNames = @[@"vamun_merch_shortsleevetshirt", @"vamun_merch_longsleevetshirt", @"vamun_merch_sunglasses", @"vamun_merch_metalwaterbottle", @"vamun_merch_cup"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < [merchandiseInfo count]; i++)
    {
        [_scrollView addSubview:[[VAMMerchandiseCard alloc] initWithImage:[UIImage imageNamed:merchandiseImageNames[i]] info:merchandiseInfo[i] offset:yOffset callback:self]];
    }
    
    //Add deals card at the bottom
    
    VAMMerchandiseCard *dealCard = [[VAMMerchandiseCard alloc] initWithImage:nil info:nil offset:yOffset callback:self];
    
    for (UIView *view in dealCard.subviews)
    {
        [view removeFromSuperview];
    }
    
    UILabel *dealTitle = [[UILabel alloc] init];
    dealTitle.numberOfLines = 0;
    dealTitle.text = @"Combos";
    dealTitle.textAlignment = NSTextAlignmentCenter;
    dealTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    [dealTitle sizeToFit];
    dealTitle.frame = CGRectMake(10.0, 5, dealCard.frame.size.width - 20.0, dealTitle.frame.size.height);
    
    UILabel *deal1 = [[UILabel alloc] init];
    deal1.numberOfLines = 0;
    deal1.text = @"Long Sleeve T-Shirt + Sunglasses - $16.99";
    deal1.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    [deal1 sizeToFit];
    deal1.frame = CGRectMake(10.0, 5 + dealTitle.frame.size.height + 5, dealCard.frame.size.width - 20.0, deal1.frame.size.height);
    
    UILabel *deal2 = [[UILabel alloc] init];
    deal2.numberOfLines = 0;
    deal2.text = @"Short Sleeve T-Shirt + Sunglasses - $11.99";
    deal2.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    [deal2 sizeToFit];
    deal2.frame = CGRectMake(10.0, 5 + dealTitle.frame.size.height + 5 + deal1.frame.size.height + 5, dealCard.frame.size.width - 20.0, deal2.frame.size.height);
    
    UILabel *deal3 = [[UILabel alloc] init];
    deal3.numberOfLines = 0;
    deal3.text = @"Free Sunglasses Come with Purchase of a T-Shirt and Metal Water Bottle";
    deal3.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    [deal3 sizeToFit];
    deal3.frame = CGRectMake(10.0, 5 + dealTitle.frame.size.height + 5 + deal1.frame.size.height + 5 + deal2.frame.size.height + 5, dealCard.frame.size.width - 20.0, deal3.frame.size.height * 2);
    
    [dealCard addSubview:dealTitle];
    [dealCard addSubview:deal1];
    [dealCard addSubview:deal2];
    [dealCard addSubview:deal3];
    
    [_scrollView addSubview:dealCard];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MerchandiseCallback Protocol Methods

-(void)merchandiseCardCreatedWithHeight:(CGFloat)height
{
    yOffset += height + 10;
    [_scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, yOffset)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
