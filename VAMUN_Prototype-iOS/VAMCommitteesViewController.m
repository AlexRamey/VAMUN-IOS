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
        
        _chairNames = @[@"Emilia Gore",
                        @"Phillip Grudier",
                        @"Michael Treves",
                        @"Mariatu Hamid Mansaray",
                        @"Christopher Winschel",
                        @"Neil Desai",
                        @"Dante Disimplico",
                        @"Victoria Tran",
                        @"Cindy Song",
                        @"Michael Drash", //10
                        @"Greyson Spencer",
                        @"Stephen Washington",
                        @"Joshua Barkow",
                        @"Joe Cahoon",
                        @"Pranav Jain",
                        @"Michael Ly",
                        @"Zach Hosseinipour",
                        @"Katherine Krudys",
                        @"Pooja Gandhi",
                        @"Shae Weathersbee", //20
                        @"Kyle Angelotti",
                        @"Emma Myers",
                        @"Gary Depalo",
                        @"Kate Kingsbury"]; //24
        
        _topicStrings = @[@"Topic 1: Biotechnologies in Developing Countries\n\nTopic 2: Sustainable Rural Transformation",
                          @"Topic 1: Future of the Millenium Development Goals\n\nTopic 2: Best Practices and Furthering Development",
                          @"Topic 1: Cameroon\n\nTopic 2: Rwanda-Burundi",
                          @"Topic 1: Respond to the ethnic unrest in South Sudan\n\nTopic 2: LGBTQ Rights in Uganda",
                          @"Topic 1: The International Political and Economic standing of Taiwan\n\nTopic 2: Migrant Worker Rights",
                          @"Topic 1: Political Structure\n\nTopic 2: Constitution",
                          @"Topic 1: The EU’s Future Energy Policy\nTopic 2: The Admission of New EU Members",
                          @"Topic 1: Rwanda’s Economic Development\n\nTopic 2: Legal Resolutions and Reconciliation",
                          @"Topic 1: Proper Presentation of Artists’ Work\n\nTopic 2: Eliminating Entrance Fees\nTopic 3: Museum Censorship of Art During the Vietnam War",
                          @"Topic 1: Disappearing Languages\n\nTopic 2: Cultural Artifacts Trafficking", //10
                          @"",
                          @"Topic 1: Biological Warfare in the 21st Century\n\nTopic 2: Disease Outbreak Mitigation in a Globalized Community\n\nTopic 3: Disease Prevention in a Globalized Community",
                          @"",
                          @"",
                          @"",
                          @"Topic 1: Issues of Human Rights in U.S.-Sino Relations\n\nTopic 2: U.S.-Sino Military-Security Relations",
                          @"",
                          @"",
                          @"",
                          @"", //20
                          @"",
                          @"",
                          @"",
                          @""]; //24
        
        _roomLocationStrings = @[
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"], //10
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"], //20
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"],
                                    @[@"Room 1", @"Room 2", @"Room 3"], //24
                                 ];
        
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
    cell.backgroundColor = [UIColor whiteColor];
    
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
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [attrString length])];
    sectionHeader.attributedText = attrString;
    return sectionHeader;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"CommitteeMasterToDetail" sender:self];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier caseInsensitiveCompare:@"CommitteeMasterToDetail"] == NSOrderedSame)
    {
        NSString *committeeTitle = [_sectionRows objectForKey:_sections[selectedIndexPath.section]][selectedIndexPath.row];
        
        int committeeIndex = 0;
        for (int i = 0; i < selectedIndexPath.section; i++)
        {
            committeeIndex += [[_sectionRows objectForKey:_sections[i]] count];
        }
        committeeIndex += selectedIndexPath.row;
        
        VAMCommitteeDetailViewController *vc = (VAMCommitteeDetailViewController *)[segue destinationViewController];
        vc.imageURL = _chairImageURLs[committeeIndex];
        vc.chairName = _chairNames[committeeIndex];
        vc.topics = _topicStrings[committeeIndex];
        vc.committeeName = committeeTitle;
        
        vc.room1info = [[_roomLocationStrings objectAtIndex:committeeIndex] objectAtIndex:0];
        vc.room2info = [[_roomLocationStrings objectAtIndex:committeeIndex] objectAtIndex:1];
        vc.room3info = [[_roomLocationStrings objectAtIndex:committeeIndex] objectAtIndex:2];
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
