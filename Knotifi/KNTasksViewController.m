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

@interface KNTasksViewController ()

// Validate the summary description of the task entered
- (BOOL) taskSummaryDescValid:(UITextField *)textField;

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
}

#pragma mark - Add Task UI

// On performing the Add Task action, insert task into the data store and display it in the task list table.
- (IBAction)addTask:(id)sender {
    
    // Check to see if entered summary description of the task is valid. If Yes
    if ([self taskSummaryDescValid:self.taskSummaryDescField]) {
        
        // Add task to the data store
        [self.taskDataController insertTaskWithType:@"Now" status:@"To Do" summaryDescription:self.taskSummaryDescField createdTimestamp:<#(NSDate *)#>];
        
        // Fire the list of categories changed notification
        [self sendCategoriesChangeNotification];
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
    return 1;
}

// Return a cell configured to display a task or a task nav item
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If tasks nav table
    if(tableView == self.tasksNavTable) {
        
        static NSString *CellIdentifier = @"TasksNavCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    
    // If tasks list table
    else {
        
        static NSString *CellIdentifier = @"TaskCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    
}

#pragma mark - Unused Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTask:(id)sender {
}
@end
