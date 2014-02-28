//
//  LESViewController.m
//  LESTouchInterceptor
//
//  Created by Joshua Weinberg on 2/28/14.
//  Copyright (c) 2014 Joshua Weinberg. All rights reserved.
//

#import "LESViewController.h"
#import "LESTouchInterceptor.h"

@interface LESViewController ()

@end

@implementation LESViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	  
    // how to use it example:
    LESTouchInterceptor * tapInterceptorOne         = [[LESTouchInterceptor alloc] initWithView:self.notAbtnOne];
    LESTouchInterceptor * tapInterceptorTwo         = [[LESTouchInterceptor alloc] initWithView:self.notABtnTwo];
    LESTouchInterceptor * tapInterceptorThree       = [[LESTouchInterceptor alloc] initWithView:self.notABtnThree];
    
    tapInterceptorOne.touchesBeganCallback          = ^(NSSet * touches, UIEvent * event) {
        self.messageLbl.text = @"Touches began on Not a Button 1";
    };
    
    tapInterceptorOne.touchesEndedCallback          = ^(NSSet * touches, UIEvent * event) {
        self.messageLbl.text = @"Touches ended on Not a Button 1";
    };
    
    tapInterceptorTwo.touchesDoubleTapCallback      = ^(NSSet * touches, UIEvent * event) {
        self.messageLbl.text = @"Tapped Twice on Not a Button 2";
    };
    
    tapInterceptorThree.touchesLongPressCallback    = ^(NSSet * touches, UIEvent * event) {
        self.messageLbl.text = @"Long Press on Not a Button 3";
    };

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
