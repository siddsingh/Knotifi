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

// Array to store the task navigation options
@property (strong, nonatomic) NSMutableArray *taskNavOptions;

// Table for list of tasks
@property (weak, nonatomic) IBOutlet UITableView *tasksListTable;

// Button to set type of Task to Later.
@property (weak, nonatomic) IBOutlet UIButton *taskTypeButton;

// On clicking the Later button, toggle it's state i.e. if it was deselected, set it to selected
// and vice versa
- (IBAction)setToLater:(id)sender;

// On performing the Add Task action, insert task into the data store and display it in the task list table.
- (IBAction)addTask:(id)sender;

// Text field to input task summary description
@property (weak, nonatomic) IBOutlet UITextField *taskSummaryDescField;

@end
