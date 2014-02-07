//
//  KNTasksTableViewCell.m
//  Knotifi
//
//  Created by Sidd on 1/27/14.
//  Copyright (c) 2014 Knotifi, Inc. All rights reserved.
//

#import "KNTasksTableViewCell.h"

@implementation KNTasksTableViewCell

// Instance variables
{
    // Initial center of this cell
    CGPoint _initialCenter;
    
    // Button for marking task as done
    UIButton *_doneButton;
}

#pragma mark - Initializing cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
    }
    
    return self;
}

// When the custom task list cell is defined in the storyboard, this method gets called
// instead of the initWithStyle above. Thus adding the pan gesture here.
// TO DO: Check if there is anyway to add pan gesture to a custom cell class using storyboard.
// Currently the storyboard doesn't allow for a IBAction from a pan gesture to a custom cell class.
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // Initialization code
        
        // Add a Pan Gesture Recognizer
        UIGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTaskPan:)];
        // Set cell to be delegate
        panRecognizer.delegate = self;
        // Add the gesture recognizer to the cell
        [self addGestureRecognizer:panRecognizer];
        
        // Add the Done Button
        _doneButton = [self createActionButtonWithText:@"Done"];
        [self.contentView addSubview:_doneButton];
    }
    
    return self;
}

#pragma mark - Managing Pan Gesture

// Track only right to left pan. TO DO: Currently tracking only horizontal. Implement fully.
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    // Get the change in position
    CGPoint change = [gestureRecognizer translationInView:[self superview]];
    
    // Check to see if pan is horizontal and not vertical.
    if (fabsf(change.x) > fabsf(change.y)) {
        
        return YES;
    }
    
    return NO;
}

- (void)handleTaskPan:(UIPanGestureRecognizer *)panRecognizer {
    
    // Capture the initial center of the cell when gesture has started
    if(panRecognizer.state == UIGestureRecognizerStateBegan) {
        
        _initialCenter = self.contentView.center;
    }
    
    // Move the center of the cell as the gesture progresses
    if(panRecognizer.state == UIGestureRecognizerStateChanged) {
        
        // Get the change in position
        CGPoint change = [panRecognizer translationInView:self];
        
        // Move the cell center
        self.contentView.center = CGPointMake(_initialCenter.x + change.x, _initialCenter.y);
        
    }
}

#pragma mark - Actions View

-(UIButton *)createActionButtonWithText:(NSString *)actionText {
    
    NSLog(@"Button Created");
    UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectNull];
    [actionButton setTitle:actionText forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    [actionButton setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0]];
    return actionButton;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    //_doneButton.frame = CGRectMake(self.bounds.size.width + 10.0f, 0, 50.0f, self.bounds.size.height);
    //_doneButton.frame = self.frame;
    
    _doneButton.frame = CGRectMake(self.contentView.bounds.size.width, self.contentView.bounds.origin.y, self.frame.size.width/5.0f, self.frame.size.height);
    
    //NSLog(@"Task Cell frame dimensions are. X:%f, Y:%f, Width:%f, Height:%f", self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
}

#pragma mark - Unused

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
