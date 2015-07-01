//
//  DMCircleCounter.m
//  Version 0.2.2
//
//  https://github.com/johngraham262/DMCircleCounter
//

#import "DMCircleCounter.h"

#define DM_SECONDS_ADJUSTMENT 1000
#define DM_TIMER_INTERVAL .015 // ~60 FPS

@interface DMCircleCounter()




@end

@implementation DMCircleCounter{

}
#pragma mark - Public methods
@synthesize  count;
@synthesize  resetValue;

- (void)baseInit {
    self.backgroundColor = [UIColor clearColor];
    resetValue = 1.0;
    self.circleTimerWidth = DM_CIRCLE_TIMER_WIDTH;
    self.circleBackgroundColor = [UIColor grayColor];
    self.circleFillColor = [UIColor clearColor];
    self.circleColor= [UIColor colorWithRed:115/255.0F green:197/255.0f blue:25/255.0f alpha:.5];
    


}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }

    return self;
}
- (void)drawRect:(CGRect)rect {
    
    self.circleBackgroundColor = [UIColor clearColor];
    self.circleFillColor = [UIColor clearColor];
    self.circleColor= [UIColor grayColor];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat radius = CGRectGetWidth(rect)/2.0f - self.circleTimerWidth/2.0f;

    // Draw the background of the circle.
    CGContextSetLineWidth(context, self.circleTimerWidth);
    CGContextBeginPath(context);
    CGContextAddArc(context,
                    CGRectGetMidX(rect), CGRectGetMidY(rect),
                    radius,
                    0.0,
                    2.0*M_PI,
                    0.0);
    CGContextSetStrokeColorWithColor(context, [self.circleBackgroundColor CGColor]);
    CGContextSetFillColorWithColor(context, [self.circleFillColor CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);
    
 //محيط الدائرة
    
    // Draw the remaining amount of timer circle.
    CGContextSetLineWidth(context, self.circleTimerWidth);
    float mohit = (radius*2.0*M_PI)-(count*1);
    //divid the circle segment array
    CGFloat ra[] = {mohit/count,1.0};
    CGContextSetLineDash(context, 1.0, ra, 2.0); // nb "2" == ra count

    
    CGContextBeginPath(context);
    CGFloat startAngle = -M_PI_2;


    //draw the
    CGContextAddArc(context,
                    CGRectGetMidX(rect), CGRectGetMidY(rect),
                    radius,
                    startAngle,
                    2.0*M_PI,
                    0);
    CGContextSetStrokeColorWithColor(context, [self.circleColor CGColor]);
    CGContextStrokePath(context);
}
-(void)countOfSegment:(float)counter{
    count = counter ;
    [self setNeedsDisplay];

}
-(void)resetView{
    resetValue = 0;
    [self setNeedsDisplay];
    resetValue = 1;

}
@end
