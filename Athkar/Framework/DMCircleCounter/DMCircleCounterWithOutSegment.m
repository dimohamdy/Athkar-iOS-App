//
//  DMCircleCounterWithOutSegment.m
//  DemoApp
//
//  Created by binaryboy on 6/27/15.
//  Copyright (c) 2015 johngraham262. All rights reserved.
//

#import "DMCircleCounterWithOutSegment.h"

@implementation DMCircleCounterWithOutSegment{
    CGContextRef context;
    
}

///-----------------------------------
/// @name Degree and Radian Conversion
///-----------------------------------

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

//@synthesize segment;
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.circleBackgroundColor = [UIColor clearColor];
        self.circleFillColor = [UIColor clearColor];
        self.circleColor= [UIColor colorWithRed:115/255.0F green:197/255.0f blue:25/255.0f alpha:.5];
    }
    
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    /*[UIColor greenColor]*/;
    
    // Drawing code
    context = UIGraphicsGetCurrentContext();
    CGFloat radius = CGRectGetWidth(rect)/2.0f - self.circleTimerWidth/2.0f;
    
    // Draw the background of the circle.
    CGContextSetLineWidth(context, self.circleTimerWidth);
    CGContextBeginPath(context);
    CGContextAddArc(context,
                    CGRectGetMidX(rect), CGRectGetMidY(rect),
                    radius,
                    0,
                    2*M_PI,
                    0);
    CGContextSetStrokeColorWithColor(context, [self.circleBackgroundColor CGColor]);
    CGContextSetFillColorWithColor(context, [self.circleFillColor CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    
    
    
    // Draw the remaining amount of timer circle.
    CGContextSetLineWidth(context, self.circleTimerWidth);
    CGContextBeginPath(context);
    NSLog(@"self.resetValue %f",self.resetValue);
    NSLog(@"self.count) %f",self.count);
    
    float start_angle = (-M_PI_2)*self.resetValue;//2*M_PI*self.count-M_PI_2;
    float end_angle = (2*M_PI*(self.count)-M_PI_2)*self.resetValue;
    
    
    CGContextAddArc(context,
                    CGRectGetMidX(rect), CGRectGetMidY(rect),
                    radius,
                    start_angle,
                    end_angle ,
                    0);
    
    
    
    CGContextSetStrokeColorWithColor(context, [self.circleColor CGColor]);
    CGContextStrokePath(context);
    self.alpha = 1.0F;
    self.resetValue = 1.0;
    
}
-(void)resetView{
    self.resetValue = 0.0;
    self.circleColor= [UIColor clearColor];
    [self setNeedsDisplay];
    self.circleColor= [UIColor colorWithRed:115/255.0F green:197/255.0f blue:25/255.0f alpha:.5];
    
}

@end
