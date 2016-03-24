//
//  StarSlider.m
//  StarSlider
//
//  Created by Eleven Chen on 15/7/17.
//  Copyright (c) 2015年 Eleven. All rights reserved.
//

#import "StarSlider.h"

#define OFF_ART	[UIImage imageNamed:@"manyiweixuanzhong"]
#define ON_ART	[UIImage imageNamed:@"manyixuanzhong"]

@interface StarSlider()

@property (assign, nonatomic) CGFloat starWidth;

@property (assign, nonatomic) NSInteger value;

@end

@implementation StarSlider

- (CGFloat) starWidth {
    
     return self.bounds.size.width / 8.0f;
}

- (instancetype) initWithFrame:(CGRect)frame withBlcok:(startValueBlcok)block {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initViewsWithBlock:block];
    }
    
    return self;
}

- (void) initViewsWithBlock:(startValueBlcok)block {
    
    self.startBlock = block;
    
    for (int i = 0; i < 5; i++) {
        UIImageView *view = [[UIImageView alloc] initWithImage:OFF_ART];
        view.frame = CGRectMake(0, 0, 25, 25);
        [self addSubview:view];
    }

}

- (void) updateView {

    float offsetCenter = self.starWidth;
    for (UIImageView* imageView in self.subviews) {
        imageView.center = CGPointMake(offsetCenter, self.bounds.size.height/2);
        offsetCenter += self.starWidth*1.5f;
    }
    
}

- (void) layoutSubviews {
    [super layoutSubviews];

    [self updateView];
}


- (void) updateValueAtPoint: (CGPoint) point {
    
    int newValue = 0;
    UIImageView* changeView = nil;
    
    for (UIImageView* eatchItem in self.subviews) {

        if (point.x < eatchItem.frame.origin.x) {
            eatchItem.image = OFF_ART;
        } else {
            changeView = eatchItem;
            eatchItem.image = ON_ART;
            newValue+=2;
        }
    }

    if (self.value != newValue) {
        self.value = newValue;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        // Animation
        [UIView animateWithDuration:0.15f
                         animations:^{
                             changeView.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.1f
                                              animations:^{
                                                  changeView.transform = CGAffineTransformIdentity;
                                              } completion:nil];
                         }];
    }
    
    if (self.startBlock != nil) {
        
        self.startBlock(newValue);
    }
    
}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    [self sendActionsForControlEvents:UIControlEventTouchDown];
    [self updateValueAtPoint:point];
    return YES;
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.frame, point)) {
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    } else {
        [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
    }
    [self updateValueAtPoint:point];
    return YES;
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.frame, point)) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
        [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
    }
}

- (void) cancelTrackingWithEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventTouchCancel];
}

@end
