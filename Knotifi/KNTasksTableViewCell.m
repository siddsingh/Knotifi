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
    
    // Flag to indicate action menu is active on a task row
    BOOL _actionMenuActive;
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
        
        // Set action menu is active on a task row to default No
        _actionMenuActive = NO;
        
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

// Respond to the right to left pan by revealing the action buttons.
- (void)handleTaskPan:(UIPanGestureRecognizer *)panRecognizer {
    
    // Capture the initial center of the cell when gesture has started
    if(panRecognizer.state == UIGestureRecognizerStateBegan) {
        
        _initialCenter = self.contentView.center;
    }
    
    // Move the center of the cell as the gesture progresses
    if(panRecognizer.state == UIGestureRecognizerStateChanged) {
        
        // Get the change in position
        CGPoint change = [panRecognizer translationInView:self.contentView];
        
        NSLog(@"Change is x:%f and y:%f",change.x,change.y);
        NSLog(@"Difference in the 2 positions is:%f and the width of the button is:%f",(self.contentView.center.x - _initialCenter.x),(self.frame.size.width)/5.0f);
        
        // Slide the view to the left only if the action menu is not active to take care of extra swipes
        if (!_actionMenuActive) {
            
            // If the change is less than the width of the button, slide the view that much to left
            if (fabsf(change.x) <= (self.frame.size.width)/5.0f) {
                
                self.contentView.center = CGPointMake(_initialCenter.x + change.x, _initialCenter.y);
            }
            
            // If it's more then slide only to the width of the button and set action menu as active
            else {
                
                self.contentView.center = CGPointMake(_initialCenter.x - (self.frame.size.width)/5.0f, _initialCenter.y);
                _actionMenuActive = YES;
                
            }
        }

    }
    
    // Set the final position of the cell when the gesture has ended
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        
        // If the user has not slid to expose the full menu, revert it back to hidden
        if (!_actionMenuActive) {
           
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.contentView.center = CGPointMake(_initialCenter.x, _initialCenter.y);
                             }
             ];
        }
    }
}

#pragma mark - Actions View

// Create an action button with given label text
-(UIButton *)createActionButtonWithText:(NSString *)actionText {

    UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectNull];
    [actionButton setTitle:actionText forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    [actionButton setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0]];
    
    return actionButton;
}

// Layout the subviews, currently the action buttons that are added as a subview to the immediate right of the
// task cell label.
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    // Layout the done action button to the immediate right of the task cell label.
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
