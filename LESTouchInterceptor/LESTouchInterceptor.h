//
//  LESTouchInterceptor.h
//
//  Based on : WildcardGestureRecognizer.h
//  by Raymond Daly on 10/31/10.
//  Copyright 2010 Floatopian LLC. All rights reserved.
//
//
//  Modified by Joshua Weinberg on 1/9/14.
//  Copyright (c) 2014 Joshua Weinberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^LESTouchesEventBlock)(NSSet * touches, UIEvent * event);

@interface LESTouchInterceptor : UIGestureRecognizer{
    LESTouchesEventBlock touchesBeganCallback;
    LESTouchesEventBlock touchesEndedCallback;
    LESTouchesEventBlock touchesLongPressCallback;
    LESTouchesEventBlock touchesDoubleTapCallback;
}

@property(copy) LESTouchesEventBlock touchesDoubleTapCallback;
@property(copy) LESTouchesEventBlock touchesLongPressCallback;
@property(copy) LESTouchesEventBlock touchesBeganCallback;
@property(copy) LESTouchesEventBlock touchesEndedCallback;

@property CGFloat minimumPressDuration;
@property CGFloat doubleTapDuration;

-(id) initWithView:(UIView *)view;

@end