//
//  VAMCommitteeDetailViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 9/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMCommitteeDetailViewController.h"
#import "VAMMapViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
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
    
    //Chair Image
    
    UIActivityIndicatorView *loadIndicator = [[UIActivityIndicatorView alloc] init];
    loadIndicator.opaque = YES;
    loadIndicator.color = [UIColor blackColor];
    [loadIndicator setHidesWhenStopped:YES];
    loadIndicator.center = CGPointMake((_chairPicture.bounds.size.width - loadIndicator.bounds.size.width) / 2, (_chairPicture.bounds.size.height - loadIndicator.bounds.size.width) / 2);
    [_chairPicture addSubview: loadIndicator];
    [loadIndicator startAnimating];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_imageURL]];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _chairPicture.image = responseObject;
        [loadIndicator stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [loadIndicator stopAnimating];
    }];
    [requestOperation start];
    
    //Chair Name
    _chairLabel.text = [@"Chair: " stringByAppendingString:_chairName];
    
    //Topics
    _topicLabel.text = _topics;
    
    //Rooms --> Set Labels
    [_room1 setTitle:_room1info forState:UIControlStateNormal];
    [_room2 setTitle:_room2info forState:UIControlStateNormal];
    [_room3 setTitle:_room3info forState:UIControlStateNormal];
    
    [_scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, _room3.frame.origin.y + _room3.frame.size.height)];
    
    //Nav Bar Config
    
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
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)launchMap:(id)sender
{
    UIButton *roomButton = (UIButton *)sender;
    
    id<UITableViewDelegate> leftViewController = (id<UITableViewDelegate>)self.wta_zoomNavigationController.leftViewController;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:2 inSection:0];
    [leftViewController tableView:nil didSelectRowAtIndexPath:ip];

    UINavigationController *nvc = (UINavigationController *)self.wta_zoomNavigationController.contentViewController;
    VAMMapViewController *mvc = (VAMMapViewController *)[nvc.viewControllers objectAtIndex:0];
    [mvc spotlightMarkerWithTitleContainedIn:roomButton.titleLabel.text];
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
