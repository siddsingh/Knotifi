//
//  Task.h
//  Knotifi
//
//  Class represents Task object in the core data model.
//
//  Created by Sidd on 1/3/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

// Type can take the following values: Now - short term tasks, Later - long term tasks.
@property (nonatomic, retain) NSString * type;

// Status can be: To Do, Done
@property (nonatomic, retain) NSString * status;

// Short description of the task
@property (nonatomic, retain) NSString * summaryDescription;

// Time when the task was created
@property (nonatomic, retain) NSDate * createdTimestamp;

@end
