//
//  KNTasksTableViewCell.h
//  Knotifi
//
//  Created by Sidd on 1/27/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNTasksTableViewCell : UITableViewCell

// Label that shows the task summary description
@property (weak, nonatomic) IBOutlet UILabel *summaryDescription;

// Label to show color, based on priority, associated with the task
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

@end
