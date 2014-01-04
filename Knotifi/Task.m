//
//  Task.m
//  Knotifi
//
//  Class represents Task object in the core data model.
//
//  Created by Sidd on 1/3/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import "Task.h"


@implementation Task

// Type can take the following values: Now - short term tasks, Later - long term tasks.
@dynamic type;

// Status can be: To Do, Done
@dynamic status;

// Short description of the task
@dynamic summaryDescription;

// Time when the task was created
@dynamic createdTimestamp;

@end
