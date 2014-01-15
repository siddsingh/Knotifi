//
//  KNTasksViewController.m
//  Knotifi
//
//  Class that manages the view showing task list and navigation options.
//
//  Created by Sidd on 1/2/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import "KNTasksViewController.h"
#import "KNDataController.h"
#import "Task.h"

@interface KNTasksViewController ()

// Validate the summary description of the task entered
- (BOOL) taskSummaryDescValid:(UITextField *)textField;

// Send a notification that the list of tasks has changed (updated)
- (void)sendTasksChangeNotification;

@end

@implementation KNTasksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view.
    
    // Get a data controller that you will use later
    self.taskDataController = [[KNDataController alloc] init];
    
    // Initialize the task navigation options array
    self.taskNavOptions = [[NSMutableArray alloc] init];
    // Add the default navigation options for To Dos
    [self.taskNavOptions addObject:@"All"];
    [self.taskNavOptions addObject:@"Now"];
    [self.taskNavOptions addObject:@"Later"];
    
    // Register the tasks change listener
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(taskStoreChanged:)
                                                 name:@"TaskStoreUpdated" object:nil];
}

#pragma mark - Add Task UI

// Add a To Do text field should dismiss the keyboard on hitting return. Entered
// data should be added to the task datastore as the summary description.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.taskSummaryDescField) {
        
        // Check to see if entered summary description of the task is valid. If Yes
        if ([self taskSummaryDescValid:self.taskSummaryDescField]) {
            
            // Add task to the data store
            [self.taskDataController insertTaskWithType:@"Now" status:@"To Do" summaryDescription:self.taskSummaryDescField.text createdTimestamp:[NSDate date]];
            
            // Fire the list of tasks changed notification
            [self sendTasksChangeNotification];
            
            // Set task entry UI format to default
            [self resetTaskEntryUIFormat];
        }
    }
    
    return YES;
}

// On performing the Add Task action, insert task into the data store and display it in the task list table.
- (IBAction)addTask:(id)sender {
    
    // Check to see if entered summary description of the task is valid. If Yes
    if ([self taskSummaryDescValid:self.taskSummaryDescField]) {
        
        // Add task to the data store
        [self.taskDataController insertTaskWithType:@"Now" status:@"To Do" summaryDescription:self.taskSummaryDescField.text createdTimestamp:[NSDate date]];
        
        // Fire the list of tasks changed notification
        [self sendTasksChangeNotification];
        
        // Set task entry UI format to default
        [self resetTaskEntryUIFormat];
    }
}

// Validate the summary description of the task entered
- (BOOL) taskSummaryDescValid:(UITextField *)textField {
    
    NSString *inputString = textField.text;
    
    // If the entered summary description is the same as the default text
    if ([inputString isEqualToString:@"          ADD A TO DO"]) {
        return NO;
    }
    
    // If the entered summary description is empty
    if ([inputString isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

// Set the task entry UI format to reflect default initial state
- (void)resetTaskEntryUIFormat {
    
    // Dismiss keyboard from the task entry field
    [self.taskSummaryDescField resignFirstResponder];
    
    // Set text to default initial state
    [self.taskSummaryDescField setText:@"          ADD A TO DO"];
}

#pragma mark - Nav and List Table

// Return headers for the table views
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewCell *headerCell = nil;
    
    // If its the tasks nav table
    if(tableView == self.tasksNavTable) {
        headerCell = [tableView dequeueReusableCellWithIdentifier:@"TasksNavHeader"];
    }
    // If its the task list table
    else {
        headerCell = [tableView dequeueReusableCellWithIdentifier:@"TaskHeader"];
    }
    
    return headerCell;
}

// Return number of sections in the table views
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // There's only one section for both tables for now
    return 1;
}

// Return number of rows in the table views
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // If tasks nav table
    if(tableView == self.tasksNavTable) {
        
        return self.taskNavOptions.count;
    }
    
    // If tasks list table
    else {
        
        self.tasksController = [self.taskDataController getAllTasks];
        id taskSection = [[self.tasksController sections] objectAtIndex:section];
        return [taskSection numberOfObjects];
    }
}

// Return a cell configured to display a task or a task nav item
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If tasks nav table
    if(tableView == self.tasksNavTable) {
        
        static NSString *CellIdentifier = @"TasksNavCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Show the to do nav option from the array for this.
        [[cell textLabel] setText:[self.taskNavOptions objectAtIndex:indexPath.row]];
        
        return cell;
    }
    
    // If tasks list table
    else {
        
        static NSString *CellIdentifier = @"TaskCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Get task to display
        Task *taskAtIndex;
        taskAtIndex = [self.tasksController objectAtIndexPath:indexPath];
        
        // Construct and display the task type and status e.g. TO DO, NOW
        NSString *taskTypeLabel = [[NSString alloc] initWithFormat:@"%@, %@",[taskAtIndex.status uppercaseString],[taskAtIndex.type uppercaseString]];
        [[cell textLabel] setText:taskTypeLabel];
        
        // Display the task summary description
        [[cell detailTextLabel] setNumberOfLines:2];
        [[cell detailTextLabel] setText:taskAtIndex.summaryDescription];
        
        return cell;
    }
}

#pragma mark - Notifications

// Send a notification that the list of tasks has changed (updated)
- (void)sendTasksChangeNotification {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TaskStoreUpdated" object:self];
}

// Refresh the tasks list table when the message store for the table has changed
- (void)taskStoreChanged:(NSNotification *)notification {
    
    [self.tasksListTable reloadData];
}

#pragma mark - Unused Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
