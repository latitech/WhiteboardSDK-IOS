//
//  MWButtonGroup.m
//  MWButtonGroup-Example
//
//  Created by martin on 17/05/14.
//  Copyright (c) 2014 Martin Wilz. All rights reserved.
//

#import "MWButtonGroup.h"

@interface MWButtonGroup()



@end

@implementation MWButtonGroup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self _setupDefaults];
    }

    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self _setupDefaults];
    }

    return self;
}


- (void)_setupDefaults
{
    _buttons = @[];

    _font = nil;
    _borderColor = nil;
    _borderWidth = 0;

    _textColor = [UIColor whiteColor];
    _buttonBackgroundColor = [UIColor blackColor];
    _selectedIndexSet = [NSMutableIndexSet new];

    self.clipsToBounds = YES;

    self.layer.cornerRadius = 8;
    self.layer.borderColor = self.textColor.CGColor;

}


- (void)appendButtonsForTitles:(NSArray *)titles
{
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithArray:_buttons];
//    NSMutableArray *lineViews = [NSMutableArray new];

    for (NSString *title in titles) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];

        if (_font) {
            button.titleLabel.font = _font;
        }

        [button addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
        [self addSubview:button];

//        UIView *lineView = [UIView new];
//        lineView.backgroundColor = (_borderColor) ? _borderColor : _textColor;
//        [lineViews addObject:lineView];
//        [self addSubview:lineView];
    }

    _selectedIndexSet = [NSMutableIndexSet new];
    _buttons = [NSArray arrayWithArray:buttons];
}
- (void)appendButtonsForImages:(NSArray *)imageNames
{
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithArray:_buttons];

    for (NSString *image in imageNames) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
        [button setTintColor:UIColor.darkGrayColor];
        [button addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
        [self addSubview:button];
    }
    _selectedIndexSet = [NSMutableIndexSet new];
    _buttons = [NSArray arrayWithArray:buttons];
}
-(void)appendButtons:(NSArray *)objects
{
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithArray:_buttons];
    for(UIButton * button in objects)
    {
        [button addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [buttons addObject:button];
    }
    _selectedIndexSet = [NSMutableIndexSet new];
    _buttons = [NSArray arrayWithArray:buttons];
}
    -(void)appendButton:(UIButton *)button
    {
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithArray:_buttons];
        [button addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [buttons addObject:button];
        _selectedIndexSet = [NSMutableIndexSet new];
        _buttons = [NSArray arrayWithArray:buttons];
    }
// internal method used, when deselection occurs triggered by user interaction
- (void)_notifyDeselection:(NSIndexSet *)indexSet
{
    if (self.delegate) {
        [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {

            if ([self.delegate respondsToSelector:@selector(buttonGroup:didDeselectButtonAtIndex:)]) {
                [self.delegate buttonGroup:self didDeselectButtonAtIndex:index];
            }
            if ([self.delegate respondsToSelector:@selector(buttonGroup:didDeselectButton:)]) {
                [self.delegate buttonGroup:self didDeselectButton:_buttons[index]];
            }
        }];
    }
}


// internal method used, when selection occurs triggered by user interaction
- (void)_notifySelection:(NSUInteger)index
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(buttonGroup:didSelectButtonAtIndex:)]) {
            [self.delegate buttonGroup:self didSelectButtonAtIndex:index];
        }
        if ([self.delegate respondsToSelector:@selector(buttonGroup:didSelectButton:)]) {
            [self.delegate buttonGroup:self didSelectButton:_buttons[index]];
        }
    }
}


- (IBAction)buttonPressed:(id)sender
{
    NSInteger index = [_buttons indexOfObject:sender];

    if (index != NSNotFound) {
        if (self.multiSelectAllowed) {

            if (![_selectedIndexSet containsIndex:index]) {
                [self selectButtonAtIndex:index];
                [self _notifySelection:index];
            }
            else {
                //[self deselectButtonAtIndex:index];
                //[self _notifyDeselection:[NSIndexSet indexSetWithIndex:index]];
                [self _notifySelection:index];
            }

            return;
        }

        if (![_selectedIndexSet containsIndex:index]) {
            NSMutableIndexSet *copy =  [self.selectedIndexSet mutableCopy];
            [copy removeIndex:index];

            [self selectButtonAtIndex:index];
            [self _notifyDeselection:copy];
            [self _notifySelection:index];
        }
        else
            [self _notifySelection:index];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect buttonFrame = self.bounds;
    buttonFrame.size.width = ((self.frame.size.width - _borderWidth) / self.buttons.count) - _borderWidth;

    CGRect lineFrame = self.bounds;
    lineFrame.size.width = _borderWidth;

    CGFloat x = _borderWidth;

    for (NSUInteger i = 0; i < _buttons.count; i++) {
        UIButton *button = _buttons[i];
        buttonFrame.origin.x = x;
        button.frame = buttonFrame;


        x += buttonFrame.size.width + _borderWidth;
    }
}


- (void)selectButtonAtIndex:(NSUInteger)index
{
    if (index > _buttons.count) return;

    if (!self.multiSelectAllowed) {
        [_selectedIndexSet removeAllIndexes];
    }

    [_selectedIndexSet addIndex:index];

    [self updateButtons];
}


- (void)deselectButtonAtIndex:(NSUInteger)index
{
    
    if (index > self.buttons.count) return;
    
    [_selectedIndexSet removeIndex:index];
    
    [self setNeedsLayout];

    UIButton *button = _buttons[index];
    button.backgroundColor = self.textColor;
    [button setTitleColor:self.textColor forState:UIControlStateNormal];
    [self updateButtons];
}


- (void)updateButtons
{
    for (NSUInteger i = 0; i < _buttons.count; i++) {
        UIButton *button = _buttons[i];

        if ([_selectedIndexSet containsIndex:i]) {
            
            button.backgroundColor = self.buttonBackgroundColor;
        }
        else {
            button.backgroundColor = self.textColor;
        }
    }
}

#pragma mark Setters

- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor
{
    _buttonBackgroundColor = buttonBackgroundColor;
    [self updateButtons];
}


- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
//    self.layer.borderColor = (_borderColor) ? _borderColor.CGColor : _textColor.CGColor;


    [self setNeedsDisplay];
    [self updateButtons];
}
@end
