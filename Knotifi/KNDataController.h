//
//  KNDataController.h
//  Knotifi
//
//  Class to interact with the core data store. Each thread should have it's own KNDataController
//  that creates a new managed object context that talks to the single data store.
//
//  Created by Sidd on 1/3/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KNDataStore;
@class NSFetchedResultsController;

@interface KNDataController : NSObject

#pragma mark - Data Store related

// A single persistent data store for this app.
@property (strong,nonatomic) KNDataStore *appDataStore;

// Managed Object Context to interact with Data Store.
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

// Controller containing results of queries to Core Data
@property (strong, nonatomic) NSFetchedResultsController *resultsController;

#pragma mark - Task Data Related

// Insert a task into the data store
- (void)insertTaskWithType:(NSString *)taskType status:(NSString *)taskStatus summaryDescription:(NSString *)taskSummaryDescription createdTimestamp:(NSDate *)taskCreatedTimestamp;

@end
