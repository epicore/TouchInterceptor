# TouchInterceptor ♣
**When all else fails add a TouchInterceptor to the UIView**
A quick (but not so dirty) way to intercept Touches on a UIView without interfering with other classes that may already be attached. i.e., MKMapView.

> I was having with the standard UIGestureRecognizers on a MKMapView until I ran across a StackOverflow post showcasing a 'WildcardGestureRecognizer' by Raymond Daly. This proved to be the best way to handle the issue and the code committed herein is an amplification of Raymond's original to make it a little easier to integrate into a project.

## Usage

```objective-c

#import "LESTouchInterceptor.h"

LESTouchInterceptor * touchInterceptorOne         = [[LESTouchInterceptor alloc] initWithView:self.someViewOne];
LESTouchInterceptor * touchInterceptorTwo         = [[LESTouchInterceptor alloc] initWithView:self.someViewTwo];
LESTouchInterceptor * touchInterceptorThree       = [[LESTouchInterceptor alloc] initWithView:self.someViewThree];

touchInterceptorOne.touchesBeganCallback          = ^(NSSet * touches, UIEvent * event) {
	self.messageLbl.text = @"Touches began on Not a Button 1";
};

touchInterceptorTwo.touchesEndedCallback          = ^(NSSet * touches, UIEvent * event) {
	self.messageLbl.text = @"Touches ended on Not a Button 1";
};

tapInterceptorTwo.touchesDoubleTapCallback      = ^(NSSet * touches, UIEvent * event) {
	self.messageLbl.text = @"Tapped Twice on Not a Button 2";
};

touchInterceptorThree.touchesLongPressCallback    = ^(NSSet * touches, UIEvent * event) {
	self.messageLbl.text = @"Long Press on Not a Button 3";
};

### Contact

[Joshua Weinberg](https://github.com/epicore)
[@epicore](https://twitter.com/epicore)

## License

TouchInterceptor is available under the MIT license. See the LICENSE file for more info.
