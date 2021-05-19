//
//  MWButtonGroup.h
//  MWButtonGroup-Example
//
//  Created by martin on 17/05/14.
//  Copyright (c) 2014 Martin Wilz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MWButtonGroup;

@protocol MWButtonGroupDelegate

@optional

- (void)buttonGroup:(MWButtonGroup *)buttonGroup didSelectButtonAtIndex:(NSUInteger)index;
- (void)buttonGroup:(MWButtonGroup *)buttonGroup didDeselectButtonAtIndex:(NSUInteger)index;

- (void)buttonGroup:(MWButtonGroup *)buttonGroup didSelectButton:(UIButton *)button;
- (void)buttonGroup:(MWButtonGroup *)buttonGroup didDeselectButton:(UIButton *)button;

@end

/** a UIView subclass containing an array of buttons
 */
@interface MWButtonGroup : UIView

/** a delegate which is notified via the protocols methods, if the user has selected a button */
@property (weak, nonatomic)  NSObject<MWButtonGroupDelegate>    *delegate;

/** readonly property for accessing the array of buttons */
@property (strong, nonatomic,readonly)  NSArray                 *buttons;

/** textColor of the button labels. existing buttons will be updated after change of this value. */
@property (strong, nonatomic)           UIColor                 *textColor;

/** background color of the button labels. existing buttons will be updated after change of this value. */
@property (strong, nonatomic)           UIColor                 *buttonBackgroundColor;

/** border color of the button labels. if not set textColor will be used. existing buttons will be updated after change of this value */
@property (strong, nonatomic)           UIColor                 *borderColor;

/** border width of the group. the default is 1. triggers relayout of the view */
@property (assign, nonatomic)           CGFloat                 borderWidth;

/** background font used for the button labels. existing buttons will be updated after change of this value. */
@property (strong, nonatomic)           UIFont                  *font;

/** property for determining the selection pattern */
@property (assign)                      BOOL                    multiSelectAllowed;

/* set of indexes of the selected buttons. readonly */
@property (strong, nonatomic, readonly) NSMutableIndexSet       *selectedIndexSet;

/** method for replacing the current buttons by giving a list of titles. buttons are text only in this case. Buttons
    are created with the current colors and font.

 @param titles  an NSArray of strings
 */
- (void)appendButtonsForTitles:(NSArray *)titles;

- (void)appendButtonsForImages:(NSArray *)imageNames;

- (void)appendButtons:(NSArray *)objects;

-(void)appendButton:(UIButton *)button;

/** selects a button at the given. triggers redraw of the buttons

    @param index the index of the button to select
 */
- (void)selectButtonAtIndex:(NSUInteger)index;

/** deselects a button at the given. triggers redraw the buttons
 @param index the index of the button to deselect
 */
- (void)deselectButtonAtIndex:(NSUInteger)index;

@end
