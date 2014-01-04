//
//  KNDataStore.h
//  Knotifi
//
//  Class that sets up a single data store. Each thread should have it's own KNDataController
//  that creates a new managed object context that talks to a single persistent store coordinator
//  in this single persistent store.
//
//  Created by Sidd on 1/3/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KNDataStore : NSObject

// Create and/or return the single shared data store
+ (KNDataStore *) sharedStore;

// Core Data Store object model
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;

// Store Coordinator for Core Data Store
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory;


@end
