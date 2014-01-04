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

@implementation KNDataController

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

@end
