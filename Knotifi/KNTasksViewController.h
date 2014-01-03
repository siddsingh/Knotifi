//
//  KNTasksViewController.h
//  Knotifi
//
//  Class that manages the view showing task list and navigation options.
//
//  Created by Sidd on 1/2/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNTasksViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// Table for task navigation options
@property (weak, nonatomic) IBOutlet UITableView *tasksNavTable;

// Table for list of tasks
@property (weak, nonatomic) IBOutlet UITableView *tasksListTable;

@end
