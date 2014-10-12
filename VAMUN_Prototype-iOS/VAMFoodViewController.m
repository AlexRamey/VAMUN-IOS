//
//  VAMFoodViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMFoodViewController.h"
#import "VAMFoodVenue.h"
#import "UIColor+Theme.h"

@interface VAMFoodViewController ()

@end

@implementation VAMFoodViewController

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static NSString * const FOOD_CELL = @"FOOD_CELL";

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        //custom initialization
        _sections = @[@"On Grounds",@"On the Corner"];
        _onGroundsRows = [[NSMutableArray alloc] init];
        _theCornerRows = [[NSMutableArray alloc] init];
        
        NSData *foodVenueJSONData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FoodVenue" ofType:@"json"]];
        NSError *error = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:foodVenueJSONData options:NSJSONReadingMutableContainers error:&error];
        NSArray *foodObjectDictionary = [jsonObject objectForKey:@"results"];
        
        for (NSDictionary *dictionary in foodObjectDictionary)
        {
            VAMFoodVenue *venue = [[VAMFoodVenue alloc] init];
            venue.title = [dictionary objectForKey:@"Title"];
            venue.address = [dictionary objectForKey:@"Address"];
            venue.hours = [dictionary objectForKey:@"Hours"];
            venue.phone = [dictionary objectForKey:@"Phone"];
            venue.venueDescription = [dictionary objectForKey:@"Description"];
            venue.isSponsor = [NSNumber numberWithBool:[[dictionary objectForKey:@"isSponsor"] boolValue]];
            venue.isOnGrounds = [NSNumber numberWithBool:[[dictionary objectForKey:@"onGrounds"] boolValue]];
            
            if ([venue.isOnGrounds boolValue] == YES)
            {
                [_onGroundsRows addObject:venue];
            }
            else
            {
                [_theCornerRows addObject:venue];
            }
        }
        
        [_onGroundsRows sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            VAMFoodVenue *venue1 = (VAMFoodVenue *)obj1;
            VAMFoodVenue *venue2 = (VAMFoodVenue *)obj2;
            
            if ([venue1.isSponsor boolValue] == YES && [venue2.isSponsor boolValue] == NO)
            {
                return NSOrderedAscending;
            }
            else if ([venue1.isSponsor boolValue] == NO && [venue1.isSponsor boolValue] == YES)
            {
                return NSOrderedDescending;
            }
            else
            {
                return [venue1.title caseInsensitiveCompare:venue2.title];
            }
        }];
        
        [_theCornerRows sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            VAMFoodVenue *venue1 = (VAMFoodVenue *)obj1;
            VAMFoodVenue *venue2 = (VAMFoodVenue *)obj2;
            
            if ([venue1.isSponsor boolValue] == YES && [venue2.isSponsor boolValue] == NO)
            {
                return NSOrderedAscending;
            }
            else if ([venue1.isSponsor boolValue] == NO && [venue1.isSponsor boolValue] == YES)
            {
                return NSOrderedDescending;
            }
            else
            {
                return [venue1.title caseInsensitiveCompare:venue2.title];
            }
        }];
         
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FOOD_CELL];
    [_tableView registerNib:[UINib nibWithNibName:@"VAMFoodCell" bundle:nil] forCellReuseIdentifier:FOOD_CELL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sections count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [_onGroundsRows count];
    }
    else
    {
        return [_theCornerRows count];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sections[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:FOOD_CELL];
    cell.backgroundColor = [UIColor whiteColor];
    
    VAMFoodVenue *venue = nil;
    
    if (indexPath.section == 0)
    {
        venue = [_onGroundsRows objectAtIndex:indexPath.row];
    }
    else
    {
        venue = [_theCornerRows objectAtIndex:indexPath.row];
    }
    
    UILabel *titleLabel = nil;
    UITextView *descriptionTextView = nil;
    for (UIView *view in cell.contentView.subviews)
    {
        if ([view class] == [UILabel class])
        {
            titleLabel = (UILabel *)view;
        }
        else
        {
            descriptionTextView = (UITextView *)view;
        }
    }
    
    titleLabel.text = venue.title;
    
    NSMutableString *detailInfo = [[NSMutableString alloc] init];
    
    if (venue.address && [venue.address caseInsensitiveCompare:@""] != NSOrderedSame)
    {
        [detailInfo appendString:venue.address];
        [detailInfo appendString:@"\n\n"];
    }
    
    if (venue.hours && [venue.hours caseInsensitiveCompare:@""] != NSOrderedSame)
    {
        [detailInfo appendString:venue.hours];
        [detailInfo appendString:@"\n\n"];
    }
    
    if (venue.phone && [venue.phone caseInsensitiveCompare:@""] != NSOrderedSame)
    {
        [detailInfo appendString:venue.phone];
        [detailInfo appendString:@"\n\n"];
    }
    
    if (venue.venueDescription && [venue.venueDescription caseInsensitiveCompare:@""] != NSOrderedSame)
    {
        [detailInfo appendString:venue.venueDescription];
    }
    
    descriptionTextView.text = detailInfo;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *sectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40.0)];
    sectionHeader.textAlignment = NSTextAlignmentCenter;
    sectionHeader.backgroundColor = [UIColor UVABlue];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_sections[section]];
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:16] range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor UVAWhite] range:NSMakeRange(0, [attrString length])];
    sectionHeader.attributedText = attrString;
    return sectionHeader;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedPath && indexPath.section == _selectedPath.section && indexPath.row == _selectedPath.row)
    {
        _selectedPath = nil; //selected again
    }
    else
    {
        _selectedPath = indexPath; //selected first time
    }
    
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    [_tableView beginUpdates];
    [_tableView endUpdates];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedPath && indexPath.section == _selectedPath.section && indexPath.row == _selectedPath.row)
    {
        return 250.0;
    }
    else
    {
        return 44.0;
    }
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
