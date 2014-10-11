//
//  VAMLeftViewController.m
//  
//
//  Created by Alex Ramey on 8/22/14.
//
//

#import "VAMLeftViewController.h"
#import "UIColor+Theme.h"
#import "VAMContentViewController.h"
#import "VAMControllerStore.h"

@interface VAMLeftViewController ()
{
    int selectedIndex;
}

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) BOOL didSelectInitialViewController;

@end

@implementation VAMLeftViewController

static NSString * const VAMLeftViewControllerCell = @"VAMLeftViewControllerCell";

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        _dataSource = @[@"Home", @"Committees", @"Map", @"Food", @"Merchandise", @"Charity", @"VAMUN Web", @"Contact Info"];
        selectedIndex = -1;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:VAMLeftViewControllerCell];
    
    [[self tableView] setBackgroundColor:[UIColor clearColor]];
    [[self tableView] setScrollEnabled:NO];
    [[self tableView] setSeparatorColor:[UIColor clearColor]];
    [[self tableView] setRowHeight:50.0];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self didSelectInitialViewController])
    {
        [self setDidSelectInitialViewController:YES];
        [self tableView:[self tableView] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VAMLeftViewControllerCell forIndexPath:indexPath];
    
    if (cell)
    {
        cell.backgroundColor = [UIColor clearColor];
        [cell setSelectedBackgroundView:[UIView new]];
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_dataSource[indexPath.row]];
        [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"American Typewriter" size:20] range:NSMakeRange(0, [attrString length])];
        cell.textLabel.attributedText = attrString;
        
        cell.textLabel.textColor = [UIColor UVAWhite];
        [cell.textLabel setHighlightedTextColor:[UIColor UVAOrange]];
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (selectedIndex != indexPath.row)
    {
        VAMControllerStore *store = [VAMControllerStore sharedInstance];
        UINavigationController *navigationController = [store viewControllerForIndex:(int)indexPath.row];
        [[self wta_zoomNavigationController] setContentViewController:navigationController];
        selectedIndex = (int)indexPath.row;
    }
    
    [[self wta_zoomNavigationController] hideLeftViewController:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSUInteger rows = [_dataSource count];
    
    CGFloat contentHeight = rows * [[self tableView] rowHeight];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    if (screenHeight > contentHeight)
    {
        return (screenHeight - contentHeight) / 2.0 ;
    }
    else
    {
        return 0.0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = [self tableView:nil heightForHeaderInSection:0];
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, height)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    return view;
}

@end
