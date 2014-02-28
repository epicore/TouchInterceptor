//
//  LESTouchInterceptor.m
//
//  Based on : WildcardGestureRecognizer.m
//  by Raymond Daly on 10/31/10.
//  Copyright 2010 Floatopian LLC. All rights reserved.
//
//  Modified by Joshua Weinberg on 1/9/14.
//  Copyright (c) 2014 Joshua Weinberg. All rights reserved.
//

#import "LESTouchInterceptor.h"

#define MIN_PRESS_DURATION  2.0f
#define DOUBLE_TAP_DURATION 0.3f

@interface LESTouchInterceptor()
@property (strong, nonatomic) NSTimer *longPressTimer;
@end

@implementation LESTouchInterceptor
@synthesize touchesDoubleTapCallback,
            touchesBeganCallback,
            touchesEndedCallback,
            touchesLongPressCallback,
            longPressTimer,
            minimumPressDuration,
            doubleTapDuration;

#pragma mark -
#pragma mark - Lifecycle method(s)

-(id) initWithView:(UIView *)view{
    
    if (self = [self init]){
        [view addGestureRecognizer:self];
    }
    
    return self;

}

-(id) init{
    
    if (self = [super init]){
        self.cancelsTouchesInView   = NO;
        minimumPressDuration        = MIN_PRESS_DURATION;
        doubleTapDuration           = DOUBLE_TAP_DURATION;
    }
    
    return self;
}

#pragma mark -
#pragma mark - UIGestureRecognizer delgate method(s)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self clearLongPressTimer];
    longPressTimer                  = [NSTimer scheduledTimerWithTimeInterval:minimumPressDuration
                                                                   target:self
                                                                 selector:@selector(longPressOccurred:)
                                                                 userInfo:touches
                                                                  repeats:NO];
    
    if(touchesDoubleTapCallback){
        
        UITouch *touch              = [touches anyObject];
        NSUInteger tapCount         = [touch tapCount];
        
        switch (tapCount) {
            case 1:
                
                [self performSelector:@selector(singleTapMethodWithEvent:)
                           withObject:event
                           afterDelay:doubleTapDuration];
                
                if(touchesBeganCallback){
                    touchesBeganCallback(touches, event);
                }
                break;
                
            case 2:
                
                [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                         selector:@selector(singleTapMethodWithEvent:)
                                                           object:event];
                
                [self performSelector:@selector(doubleTapMethodWithEvent:)
                           withObject:event
                           afterDelay:doubleTapDuration];
                break;
                
            default:
                
                break;
        }
        
    } else if(touchesBeganCallback){
        touchesBeganCallback(touches, event);
    }

}

#pragma mark -
#pragma mark - Userdefined Block callbacks

- (void) singleTapMethodWithEvent:(UIEvent *)event{
    [self touchesEnded:nil withEvent:event];
}

- (void) doubleTapMethodWithEvent:(UIEvent *)event{
    if (touchesDoubleTapCallback){
        touchesDoubleTapCallback(nil, event);
    }
}
- (void) longPressOccurred:(NSTimer*)timer{
    if (touchesLongPressCallback){
        touchesLongPressCallback(timer.userInfo, nil);
    }
}

- (void) clearLongPressTimer{
    if(longPressTimer){
        [longPressTimer invalidate];
        longPressTimer = nil;
    }
}

#pragma mark -
#pragma mark - UIGestureRecognizer delgate method(s)

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self clearLongPressTimer];
    
    if (touchesEndedCallback){
        touchesEndedCallback(touches, event);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self clearLongPressTimer];
    
    if (touchesEndedCallback){
        touchesEndedCallback(touches, event);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    /*
     if (touchesBeganCallback){
     touchesBeganCallback(touches, event);
     }
     */
}

- (void)reset{}

- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event{}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer{
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer{
    return NO;
}

@end