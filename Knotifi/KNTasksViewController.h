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
@class KNDataController;

@interface KNTasksViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// Data Controller to add/access tasks in the data store
@property (strong, nonatomic) KNDataController *taskDataController;

// Controller containing results of task queries to Core Data store
@property (strong, nonatomic) NSFetchedResultsController *tasksController;

// Table for task navigation options
@property (weak, nonatomic) IBOutlet UITableView *tasksNavTable;

// Table for list of tasks
@property (weak, nonatomic) IBOutlet UITableView *tasksListTable;

// Add task action
- (IBAction)addTask:(id)sender;

// Text field to input task summary description
@property (weak, nonatomic) IBOutlet UITextField *taskSummaryDescField;

@end
