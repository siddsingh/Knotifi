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

// Store for label text of the currently selected task navigation option
@property (strong, nonatomic) NSString *currentTaskNavOption;

// Table for list of tasks
@property (weak, nonatomic) IBOutlet UITableView *tasksListTable;

// Flag to indicate if the task being created is of type Now or Later
@property (nonatomic, assign) BOOL taskTypeIsNow;

// Handle the swipe to left action on the task input text view
- (IBAction)handleTaskInputSwipe:(UISwipeGestureRecognizer *)sender;

// On performing the Add Task action, insert task into the data store and display it in the task list table.
- (IBAction)addTask:(id)sender;

// Text field to input task summary description
@property (weak, nonatomic) IBOutlet UITextField *taskSummaryDescField;

@end
