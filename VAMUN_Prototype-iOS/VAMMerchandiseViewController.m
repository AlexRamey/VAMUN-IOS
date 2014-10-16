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
        merchandiseInfo = @[@"Sunglasses - $5", @"Cups - $5"];
        merchandiseImageNames = @[@"vamun_merch_sunglasses", @"vamun_merch_cup"];
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
    for (int i = 0; i < [merchandiseInfo count]; i++)
    {
        [_scrollView addSubview:[[VAMMerchandiseCard alloc] initWithImage:[UIImage imageNamed:merchandiseImageNames[i]] info:merchandiseInfo[i] offset:yOffset callback:self]];
    }
    for (int i = 0; i < [merchandiseInfo count]; i++)
    {
        [_scrollView addSubview:[[VAMMerchandiseCard alloc] initWithImage:[UIImage imageNamed:merchandiseImageNames[i]] info:merchandiseInfo[i] offset:yOffset callback:self]];
    }
    
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
