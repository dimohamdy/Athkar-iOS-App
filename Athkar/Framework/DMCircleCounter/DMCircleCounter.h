

#import <UIKit/UIKit.h>

// Defaults
#define DM_CIRCLE_COLOR_DEFAULT [UIColor colorWithRed:115/255.0F green:197/255.0f blue:25/255.0f alpha:.5]
#define DM_CIRCLE_BACKGROUND_COLOR_DEFAULT [UIColor colorWithWhite:.85f alpha:1]
#define DM_CIRCLE_FILL_COLOR_DEFAULT [UIColor clearColor]
#define DM_CIRCLE_TIMER_WIDTH 8.0f

@protocol DMCircleCounterDelegate;

@interface DMCircleCounter : UIView

/// The receiver of all counter delegate callbacks.
@property (nonatomic, weak) id<DMCircleCounterDelegate> delegate;

/// The color of the circle indicating the remaining amount of time - default is DM_CIRCLE_COLOR_DEFAULT.
@property (nonatomic, strong) UIColor *circleColor;

/// The color of the circle indicating the expired amount of time - default is DM_CIRCLE_BACKGROUND_COLOR_DEFAULT.
@property (nonatomic, strong) UIColor *circleBackgroundColor;

/// The color of inside of the circle - default is DM_CIRCLE_FILL_COLOR_DEFAULT.
@property (nonatomic, strong) UIColor *circleFillColor;

/// The thickness of the circle color - default is DM_CIRCLE_TIMER_WIDTH.
@property (nonatomic, assign) CGFloat circleTimerWidth;



/**
 * Stops the counter and pauses animation as if it were at the initial, pre-started, state.
 * After reset is called, didStart, isRunning, and didFinish will all be NO.
 * You may start the timer again with startWithSeconds:.
 */

-(void)countOfSegment:(float)counter;





@property (assign) float count;
@property (assign) float resetValue;

-(void)resetView;
@end


@protocol DMCircleCounterDelegate <NSObject>

/**
 * Alerts the delegate when the timer expires. At this point, counter animation is completed too.
 *
 * @param circleCounter the counter that just expired in time
 */
@optional
- (void)circleCounterTimeDidExpire:(DMCircleCounter *)circleCounter;

@end
