//
//  VAMFoodViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMFoodViewController.h"
#import "UIColor+Theme.h"

@interface VAMFoodViewController ()

@end

@implementation VAMFoodViewController

static NSString * const FOOD_CELL = @"FOOD_CELL";

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        //custom initialization
        _sections = @[@"On Grounds",@"On the Corner"];
        _prototypeRows = @[@"O-Hill", @"Qdoba", @"Little John's"];
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
    return [_prototypeRows count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sections[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:FOOD_CELL];
    cell.backgroundColor = [UIColor UVAWhite];
    
    UILabel *titleLabel = nil;
    UILabel *descriptionLabel = nil;
    for (UIView *view in cell.contentView.subviews)
    {
        if ([view class] == [UILabel class])
        {
            titleLabel = (UILabel *)view;
        }
        else
        {
            //scroll view
            for (UIView *v in view.subviews)
            {
                if ([v class] == [UILabel class])
                {
                    descriptionLabel = (UILabel *)v;
                }
            }
        }
    }
    
    titleLabel.text = [_prototypeRows objectAtIndex:indexPath.row];
    descriptionLabel.text = @"Gotcha Son.";
    
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
        return 40.0;
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
