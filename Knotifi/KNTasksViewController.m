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

@interface KNTasksViewController ()

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
}

#pragma mark - Nav and List Table Methods

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

@end
