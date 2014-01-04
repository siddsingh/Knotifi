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

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * summaryDescription;
@property (nonatomic, retain) NSDate * createdTimestamp;

@end
