//
//  VAMCommitteeDetailViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 9/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMCommitteeDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+Theme.h"

@interface VAMCommitteeDetailViewController ()

@end

@implementation VAMCommitteeDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        //custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_chairPicture setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:nil];
    
    UILabel *tlabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0, 230, 40)];
    tlabel.text= _committeeName;
    tlabel.textColor=[UIColor UVAOrange];
    tlabel.font = [UIFont fontWithName:@"HelveticaNeue" size: 20.0];
    tlabel.backgroundColor =[UIColor clearColor];
    tlabel.numberOfLines = 0;
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *filler = [[UIView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, 40)];;
    [filler addSubview:tlabel];
    self.navigationItem.titleView = filler;
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
