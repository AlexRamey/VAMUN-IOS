//
//  VAMHomeViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMHomeViewController.h"
#import "VAMTwitterClient.h"
#import "VAMTwitterCard.h"

@interface VAMHomeViewController ()

@end

@implementation VAMHomeViewController



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)reloadTweets
{
    [[VAMTwitterClient sharedClient] fetchTweetsWithCompletion:^(NSArray *result, NSError *error) {
        if (result)
        {
            NSMutableArray *cards = [[NSMutableArray alloc] init];
            yOffset = 0.0;
            
            for (NSDictionary *tweet in result)
            {
                
                NSString *time = [tweet objectForKey:@"created_at"];
                NSString *tweetText = [tweet objectForKey:@"text"];
                NSDictionary *user = [tweet objectForKey:@"user"];
                NSString *userTitle = [user objectForKey:@"name"];
                NSString *thumbnailImage = [user objectForKey:@"profile_image_url"];
                NSString *screenName = [user objectForKey:@"screen_name"];
                
                VAMTwitterCard *card = [[VAMTwitterCard alloc] initWithUserTitle:userTitle screenName:screenName time:time tweet:tweetText thumbnailURL:thumbnailImage offset:yOffset callback:self];
                [cards addObject:card];
            }
            
            _twitterCards = cards;
            [self reloadViews];
        }
        else
        {
            NSLog(@"Fail");
        }
    }];
}

-(void)reloadViews
{
    for (VAMTwitterCard *card in _twitterCards)
    {
        [_scrollView addSubview:card];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self reloadTweets];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reloadTweets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - HomeViewCallback Methods

-(void)twitterCardCreatedWithHeight:(CGFloat)height
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
