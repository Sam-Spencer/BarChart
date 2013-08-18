//
//  PlotChart.m
//
//  Created by Mezrin Kirill on 17.02.12.
//  Copyright (c) Mezrin Kirill 2012-2013.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "PlotChartView.h"
#import "UIColor+i7HexColor.h"

@interface PlotChartView()
- (void)setUp;
@end

@implementation PlotChartView

@synthesize paddingTop;
@synthesize paddingBotom;
@synthesize fontSize;
@synthesize colorAxisY;
@synthesize stepCountAxisX;
@synthesize stepWidthAxisY;
@synthesize maxValueAxisY;
@synthesize stepValueAxisY;
@synthesize labelSizeAxisY;
@synthesize plotVerticalLines;

#pragma mark - Initialization and teardown

- (id) init {
	self = [super init];
	if (self)  {
		[self setUp];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self)  {
		[self setUp];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.backgroundColor = [UIColor clearColor];
}

- (void)didRotate:(NSNotification *)notification {
    // Redraw the plot chart view when the device orientation changes
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	if (orientation != UIDeviceOrientationFaceUp && orientation != UIDeviceOrientationFaceDown && orientation != UIDeviceOrientationUnknown) {
		[self setNeedsDisplay];
	}
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	rect = CGRectMake(0.0f, paddingTop, rect.size.width, rect.size.height - paddingTop - paddingBotom);
    
	CGFloat leftPaddingAxisY = stepWidthAxisY + labelSizeAxisY.width;
	NSUInteger stepCountAxisY = maxValueAxisY/stepValueAxisY; // The number of steps on the Y Axis
	CGFloat stepHeightAxisY = rect.size.height/stepCountAxisY;
	
	CGFloat barFullWidth = (rect.size.width - leftPaddingAxisY)/stepCountAxisX;
    
	CGContextSetLineWidth(context, 1.0f);
	CGContextSetStrokeColorWithColor(context, [[UIColor colorWithHexString:@"e8ebee"] CGColor]);
	
	for (NSUInteger i = 0; i < stepCountAxisY; i++)  {
        // Draw Plot View Background - set to clear color
		if (i % 2) {
            CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
		} else {
            CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
		}
		
		CGContextBeginPath(context);
		CGContextAddRect(context, CGRectMake(CGRectGetMinX(rect) + leftPaddingAxisY,  CGRectGetMinY(rect) + i*stepHeightAxisY, CGRectGetMaxX(rect) + leftPaddingAxisY, stepHeightAxisY));
        CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFill);
	}
    
	CGContextSetFillColorWithColor(context, colorAxisY);
	CGContextSetStrokeColorWithColor(context, colorAxisY);
	
    // Plot the Y values on the Y Axis - first check to make sure the label size is not zero (meaning that there should be no Y Axis scale)
	if (!CGSizeEqualToSize(labelSizeAxisY, CGSizeZero))  {
        NSInteger numOfScales = 5; // Number of points on the scale - TODO add a method to allow customization
        for (int i = 0; i < numOfScales; i++) {
            double scaleValue = 0.0;
            if (i == 0){
                scaleValue = 0.0; // Bottom of the Scale
            } else if (i == (numOfScales-1)) {
                scaleValue = maxValueAxisY; // Top of the Scale
            } else {
                scaleValue = maxValueAxisY * ((double)i/(double)(numOfScales-1)); // Values between the maximum and minimum
            }
            
            NSInteger barY = self.bounds.size.height*0.999; //bottom of bar
            NSInteger currentBarY = (barY-15) - (((self.bounds.size.height) / numOfScales) * i*1.2); // Weird math to properly space the labels on the scale

            NSString *textX = [NSString stringWithFormat:@"%.f", scaleValue]; 
			CGRect textRect = CGRectMake(CGRectGetMinX(rect), currentBarY, labelSizeAxisY.width, labelSizeAxisY.height);
            
			[textX drawInRect:textRect withFont:[UIFont systemFontOfSize:fontSize] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
            
			CGContextBeginPath(context);
			CGContextMoveToPoint(context, CGRectGetMinX(rect) + labelSizeAxisY.width, CGRectGetMinY(rect) + i*stepHeightAxisY);
			//CGContextAddLineToPoint(context, CGRectGetMinX(rect) + leftPaddingAxisY, CGRectGetMinY(rect) + i*stepHeightAxisY); // Add Scale lines - for some reason, they don't properly space out
			CGContextClosePath(context);
			CGContextDrawPath(context, kCGPathStroke);
        }
	}
	
    // Plot vertical lines
	if (plotVerticalLines)  {
        // Set the line stroke color
		CGContextSetStrokeColorWithColor(context, [[UIColor colorWithHexString:@"dadadb"] CGColor]);
		
        // Find the number of bars and place a line through the center coordinates of each bar, behind the bar
		for (NSUInteger i = 1; i <= stepCountAxisX; i++) {
			CGContextBeginPath(context);
			CGContextMoveToPoint(context, CGRectGetMinX(rect) + leftPaddingAxisY + (barFullWidth/2)*(2*i - 1), CGRectGetMinY(rect));
			CGContextAddLineToPoint(context, CGRectGetMinX(rect) + leftPaddingAxisY + (barFullWidth/2)*(2*i - 1), CGRectGetMaxY(rect));
			CGContextClosePath(context);
			CGContextDrawPath(context, kCGPathStroke);
			
		}
	}
	
	CGContextSetStrokeColorWithColor(context, colorAxisY);
	CGContextStrokeRect(context, CGRectMake(CGRectGetMinX(rect) + leftPaddingAxisY,  CGRectGetMinY(rect), CGRectGetMaxX(rect) - leftPaddingAxisY - 1.0f, rect.size.height));
}

@end
