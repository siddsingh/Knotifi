//
//  KNDataController.m
//  Knotifi
//
//  Class to interact with the core data store. Each thread should have it's own KNDataController
//  that creates a new managed object context that talks to the single data store.
//
//  Created by Sidd on 1/3/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import "KNDataController.h"
#import "KNDataStore.h"
#import "Task.h"

@implementation KNDataController

#pragma mark - Data Store related

// Managed Object Context to interact with Data Store.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    // Get the single persistent store for this application.
    self.appDataStore = [KNDataStore sharedStore];
    
    if ([self.appDataStore persistentStoreCoordinator] != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:[self.appDataStore persistentStoreCoordinator]];
    }
    
    return _managedObjectContext;
}

#pragma mark - Task Data Related

// Insert a task into the data store
- (void)insertTaskWithType:(NSString *)taskType status:(NSString *)taskStatus summaryDescription:(NSString *)taskSummaryDescription createdTimestamp:(NSDate *)taskCreatedTimestamp
{
    NSManagedObjectContext *dataStoreContext = [self managedObjectContext];
    
    Task *taskToInsert = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:dataStoreContext];
    
    taskToInsert.type = taskType;
    taskToInsert.status = taskStatus;
    taskToInsert.summaryDescription = taskSummaryDescription;
    taskToInsert.createdTimestamp = taskCreatedTimestamp;
    
    NSError *error;
    if (![dataStoreContext save:&error]) {
        NSLog(@"ERROR: Saving task to data store failed: %@",error.description);
    }
}

// Get all tasks from the data store
- (NSFetchedResultsController *)getAllTasks
{
    NSManagedObjectContext *dataStoreContext = [self managedObjectContext];
    
    NSFetchRequest *taskFetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *taskEntity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:dataStoreContext];
    [taskFetchRequest setEntity:taskEntity];
    
    // Sort first to get "now" tasks and then "later". Within these categories get the latest created first.
    NSArray *sortByFields = [NSArray arrayWithObjects:
                                [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:NO],
                                [NSSortDescriptor sortDescriptorWithKey:@"createdTimestamp" ascending:NO],
                                nil];
    [taskFetchRequest setSortDescriptors:sortByFields];
    
    [taskFetchRequest setFetchBatchSize:15];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:taskFetchRequest
                                                                 managedObjectContext:dataStoreContext sectionNameKeyPath:nil
                                                                            cacheName:nil];
    
    NSError *error;
    if (![self.resultsController performFetch:&error]) {
        NSLog(@"ERROR: Getting all tasks from data store failed: %@",error.description);
    }
    
    return self.resultsController;
}

// Get tasks with a particular status from the data store.
- (NSFetchedResultsController *)getTasksWithStatus:(NSString *)taskStatus
{
    NSManagedObjectContext *dataStoreContext = [self managedObjectContext];
    
    NSFetchRequest *taskFetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *taskEntity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:dataStoreContext];
    [taskFetchRequest setEntity:taskEntity];
    
    // Set a clause to do a case insensitive query on task status
    NSPredicate *taskPredicate = [NSPredicate predicateWithFormat:@"status =[c] %@",taskStatus];
    [taskFetchRequest setPredicate:taskPredicate];

    // Sort first to get "now" tasks and then "later". Within these categories get the latest created first.
    NSArray *sortByFields = [NSArray arrayWithObjects:
                             [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:NO],
                             [NSSortDescriptor sortDescriptorWithKey:@"createdTimestamp" ascending:NO],
                             nil];
    [taskFetchRequest setSortDescriptors:sortByFields];
    
    [taskFetchRequest setFetchBatchSize:15];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:taskFetchRequest
                                                                 managedObjectContext:dataStoreContext sectionNameKeyPath:nil
                                                                            cacheName:nil];
    
    NSError *error;
    if (![self.resultsController performFetch:&error]) {
        NSLog(@"ERROR: Getting tasks with status %@ from data store failed: %@",taskStatus,error.description);
    }
    
    return self.resultsController;
}

@end
