//
//  VAMFoodViewController.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMContentViewController.h"

@interface VAMFoodViewController : VAMContentViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSIndexPath *selectedPath;

@property (nonatomic, strong) NSMutableArray *onGroundsRows;
@property (nonatomic, strong) NSMutableArray *theCornerRows;

@end