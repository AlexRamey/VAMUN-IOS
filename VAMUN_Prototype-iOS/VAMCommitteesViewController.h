//
//  VAMCommitteesViewController.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMContentViewController.h"

@interface VAMCommitteesViewController : VAMContentViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSIndexPath *selectedIndexPath;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSDictionary *sectionRows;

@property (nonatomic, strong) NSArray *chairImageURLs;

@end
