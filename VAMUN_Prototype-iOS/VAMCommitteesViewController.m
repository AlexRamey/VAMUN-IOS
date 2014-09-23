//
//  VAMCommitteesViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMCommitteesViewController.h"
#import "VAMCommitteeDetailViewController.h"
#import "UIColor+Theme.h"

@interface VAMCommitteesViewController ()

@end

@implementation VAMCommitteesViewController

static NSString * const COMMITTEE_CELL = @"COMMITTEE_CELL";

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _sections = @[@"General Assembly", @"Specialized", @"Crisis", @"Wilson Global Systems", @"Jefferson Committee on Diplomacy"];
        _sectionRows =
        @{
          _sections[0] : @[@"Food & Agriculture Organization", @"Millenium Development Goals of 2015", @"U.N. Trusteeship Council"],
          _sections[1] : @[@"African Union", @"Asia Cooperation Dialogue", @"Cabinet Mission to India, 1946", @"European Union", @"Rwanda Cabinet", @"Committee on the Treatment of Modern Arts in America", @"UNESCO"],
          _sections[2] : @[@"Chen Village", @"Global Health Summit", @"Operation Pillar of Defense", @"Roman Senate, 63 BC", @"Security Council of Russia: 2015", @"U.S. Embassy: Beijing", @"White House Ad Hoc Cabinet: Healthcare 2015"],
          _sections[3] : @[@"Los Urab\u1EBDnos", @"Nicaraguan National Assembly", @"Organization of American States", @"Panamanian National Assembly", @"Press Corps", @"United States Southern Command"],
          _sections[4] : @[@"Jefferson Committee on Diplomacy"]
          };
        
        
        _chairImageURLs = @[@"http://iroatuva.org/vamun/chairphotos/FAO.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/MDG.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/UNTC.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/AU.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/ACD.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/India.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/EU.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/Rwanda.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/Art.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/UNESCO.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/ChenChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/GHSChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/PillarChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/RomanChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/RussiaChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/EmbassyChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/WhitehouseChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/CriminalChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/NicChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/OASChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/PanamaChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/PressChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/USSCChair.JPG",
                            @"http://iroatuva.org/vamun/chairphotos/JCDChair.JPG"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:COMMITTEE_CELL];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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
    return [[_sectionRows objectForKey:_sections[section]] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sections[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:COMMITTEE_CELL];
    cell.backgroundColor = [UIColor UVAWhite];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[_sectionRows objectForKey:_sections[indexPath.section]][indexPath.row]];
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:14] range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [attrString length])];
    
    cell.textLabel.attributedText = attrString;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.numberOfLines = 0;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"CommitteeMasterToDetail" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier caseInsensitiveCompare:@"CommitteeMasterToDetail"] == NSOrderedSame)
    {
        NSString *committeeTitle = [_sectionRows objectForKey:_sections[selectedIndexPath.section]][selectedIndexPath.row];
        
        int urlIndex = 0;
        for (int i = 0; i < selectedIndexPath.section; i++)
        {
            urlIndex += [[_sectionRows objectForKey:_sections[i]] count];
        }
        urlIndex += selectedIndexPath.row;
        
        VAMCommitteeDetailViewController *vc = (VAMCommitteeDetailViewController *)[segue destinationViewController];
        vc.imageURL = _chairImageURLs[urlIndex];
        vc.committeeName = committeeTitle;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
