//
//  VAMHomeViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMHomeViewController.h"
#import "VAMTwitterClient.h"

@interface VAMHomeViewController ()

@end

@implementation VAMHomeViewController



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        //[self reloadTweets];
        
    }
    return self;
}

-(void)reloadTweets
{
    [[VAMTwitterClient sharedClient] fetchTweetsWithCompletion:^(NSArray *result, NSError *error) {
        if (result)
        {/*
            NSMutableArray *statuses = [[NSMutableArray alloc] init];
            for (NSDictionary *dictionary in result)
            {
                [statuses addObject:[dictionary objectForKey:@"text"]];
            }
            _tweets = statuses;
            [self reloadViews];
          */
        }
        else
        {
            NSLog(@"Fail");
        }
    }];
}

-(void)reloadViews
{
    NSString *stream = @"";
    for (NSString *str in _tweets)
    {
        stream = [[stream stringByAppendingString:str] stringByAppendingString:@"\n\n"];
    }
    _tweetStream.text = stream;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //[self reloadTweets];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
