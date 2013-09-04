//
//  BarChartView.m
//
//  Created by Mezrin Kirill on 17.02.12.
//  Copyright (c) Mezrin Kirill 2012-2013.
//
//  Major Updates by iRare Media.
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

#import "BarChartView.h"

@interface BarChartView () {
    BarView *bar;
}
- (void)codeSetUp;
- (void)interfaceSetUp;
- (void)setUpChart;
- (void)calculateFrames;
@end

@implementation BarChartView
@synthesize barViewShape, barViewDisplayStyle, barViewShadow, barViewAnimation, plotViewColor;
@synthesize barViewDelegate;

//------------------------------------------------------//
//--- Bar Chart Setup ----------------------------------//
//------------------------------------------------------//
#pragma mark - Bar Chart Setup

- (id)init {
	self = [super init];
	if (self)  {
		[self codeSetUp];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self codeSetUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self interfaceSetUp];
    }
    return self;
}

- (void)interfaceSetUp {
	plotChart = [[PlotChartView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height - fontSize)];
	plotChart.stepValueAxisY = STEP_AXIS_Y;
	plotChart.fontSize = FONT_SIZE;
	plotChart.paddingTop = PLOT_PADDING_TOP;
	plotChart.paddingBotom = PLOT_PADDING_BOTTOM;
	plotChart.stepWidthAxisY = self.width/STROKE_AXIS_Y_SCALE;
	[self addSubview:plotChart];
	
	plotView = [[UIView alloc] initWithFrame:CGRectZero];
	plotView.backgroundColor = [UIColor clearColor];
	plotView.clipsToBounds = true;
	[plotChart addSubview:plotView];
	
	barViews = [[NSMutableArray alloc] initWithCapacity:0];
	barLabels = [[NSMutableArray alloc] initWithCapacity:0];
	chartDataArray = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)codeSetUp {
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	self.clipsToBounds = false;
	self.backgroundColor = [UIColor colorWithHexString:@"e8ebee"];
	
	plotChart = [[PlotChartView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height - fontSize)];
	plotChart.stepValueAxisY = STEP_AXIS_Y;
	plotChart.fontSize = FONT_SIZE;
	plotChart.paddingTop = PLOT_PADDING_TOP;
	plotChart.paddingBotom = PLOT_PADDING_BOTTOM;
	plotChart.stepWidthAxisY = self.width/STROKE_AXIS_Y_SCALE;
	[self addSubview:plotChart];
	
	plotView = [[UIView alloc] initWithFrame:CGRectZero];
	plotView.backgroundColor = [UIColor clearColor];
	plotView.clipsToBounds = true;
	plotView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [plotChart addSubview:plotView];
	
	barViews = [[NSMutableArray alloc] initWithCapacity:0];
	barLabels = [[NSMutableArray alloc] initWithCapacity:0];
	chartDataArray = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)setUpChart {	
	[self calculateFrames];
	
	NSUInteger _index = 0;
	for (NSDictionary *barInfo in chartDataArray)  {
		bar = [[BarView alloc] initWithFrame:CGRectMake((barFullWidth - barWidth)/2 + _index*(barFullWidth),  plotView.height - roundf([[barInfo objectForKey:@"value"] floatValue]*barHeightRatio), barWidth, roundf([[barInfo objectForKey:@"value"] floatValue]*barHeightRatio))];
		bar.cornerRadius = 10.0f;
		bar.barValue = [[barInfo objectForKey:@"value"] floatValue];
		bar.owner = self;
		if (realMaxValue == [[barInfo objectForKey:@"value"] floatValue]) {
			bar.special = true;
		}
        bar.barViewShape = self.barViewShape;
        bar.barViewDisplayStyle = self.barViewDisplayStyle;
        bar.barViewShadow = self.barViewShadow;
		bar.backgroundColor = [UIColor clearColor];
		bar.buttonColor = [barInfo objectForKey:@"color"];
        plotView.alpha = 0.0;
		[plotView addSubview:bar];
		[barViews addObject:bar];
		
		if (showAxisX) {
			BarLabel *barLabel = [[BarLabel alloc] initWithFrame:CGRectMake(roundf(plotView.left + _index*barFullWidth), plotChart.bottom - PLOT_PADDING_BOTTOM,roundf(barFullWidth), fontSize + PLOT_PADDING_BOTTOM)];
			barLabel.textColor = [barInfo objectForKey:@"labelColor"];
			barLabel.text =  [barInfo objectForKey:@"label"];
			barLabel.font = [UIFont systemFontOfSize:fontSize];
			barLabel.textAlignment = UITextAlignmentCenter;
			barLabel.clipsToBounds = false;
			barLabel.backgroundColor = [UIColor clearColor];
			[barLabels addObject:barLabel];
			[self addSubview:barLabel];
		}		 
		_index++;
	}
    
    if (barViewDelegate) {
        [bar setupBarViewDelegate:barViewDelegate];
    }
    
    if (self.barViewAnimation == BarAnimationRise) {
        [self performSelector:@selector(animateBars) withObject:NULL afterDelay:0.5];
    } else if (self.barViewAnimation == BarAnimationFade) {
        [self performSelector:@selector(fadeBars) withObject:NULL afterDelay:0.5];
    } else if (self.barViewAnimation == BarAnimationFloat) {
        [self performSelector:@selector(floatBars) withObject:NULL afterDelay:0.5];
    } else if (self.barViewAnimation == BarAnimationNone) {
        plotView.alpha = 1.0;
        return;
    } else {
        [self performSelector:@selector(animateBars) withObject:NULL afterDelay:0.5];
    }
}

//------------------------------------------------------//
//--- Calculations -------------------------------------//
//------------------------------------------------------//
#pragma mark - Calculations

- (void)calculateFrames {
	CGSize maxStringSize = [[NSString stringWithFormat:@"%i", (int)maxValue] sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE]];
	
	if (showAxisY) {
		leftPadding = self.width/STROKE_AXIS_Y_SCALE + maxStringSize.width;
	} else {
		leftPadding = 0.0f;
	}
    
	plotChart.stepWidthAxisY = showAxisY?self.width/STROKE_AXIS_Y_SCALE:0.0f;
	plotView.frame = CGRectMake(leftPadding, PLOT_PADDING_TOP, plotChart.width - leftPadding, plotChart.height - PLOT_PADDING_TOP - PLOT_PADDING_BOTTOM);
	barHeightRatio = plotView.height/maxValue;
	barWidth = plotView.width/chartDataArray.count;
	barFullWidth = plotView.width/chartDataArray.count;
	
	if (barWidth > MAX_BAR_WIDTH)
		barWidth = MAX_BAR_WIDTH;
	
	stepWidth = plotView.width/chartDataArray.count - MAX_BAR_WIDTH;
	
	if (stepWidth < 0.0f)
		stepWidth = 0.0f;
	
	[plotChart setNeedsDisplay];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self calculateFrames];
	NSUInteger index = 0;
	for (NSDictionary *barInfo in chartDataArray)  {
		bar = [barViews objectAtIndex:index];
		bar.frame = CGRectMake((barFullWidth - barWidth)/2 + index*(barFullWidth),
                               plotView.height - roundf([[barInfo objectForKey:@"value"] floatValue]*barHeightRatio),
                               barWidth, roundf([[barInfo objectForKey:@"value"] floatValue]*barHeightRatio));
		[bar setNeedsDisplay];
		
		if (showAxisX) {
			BarLabel *barLabel = [barLabels objectAtIndex:index];
			barLabel.frame = CGRectMake(roundf(plotView.left + index*barFullWidth),
                                        plotChart.bottom - PLOT_PADDING_BOTTOM,
                                        barFullWidth, fontSize + PLOT_PADDING_BOTTOM);
            
			[barLabel setNeedsDisplay];
		}
		index++;
	}
}

//------------------------------------------------------//
//--- Animations ---------------------------------------//
//------------------------------------------------------//
#pragma mark - Animations

- (void)animateBars {
	for (bar in barViews)  {
		bar.bottom += bar.height;
	}
	
	[UIView animateWithDuration:0.8 animations:^{
        plotView.alpha = 1.0;
		NSUInteger index = 0;
		for (NSDictionary *barInfo in chartDataArray)  {
			bar = [barViews objectAtIndex:index];
			bar.frame = CGRectMake((barFullWidth - barWidth)/2 + index*(barFullWidth), plotView.height - roundf([[barInfo objectForKey:@"value"] floatValue]*barHeightRatio), barWidth, roundf([[barInfo objectForKey:@"value"] floatValue]*barHeightRatio));
			index++;
		}
	}];
}

- (void)fadeBars {
    [UIView animateWithDuration:0.5 animations:^{
        plotView.alpha = 1.0;
	}];
}

- (void)floatBars {
	for (bar in barViews)  {
        bar.transform = CGAffineTransformMakeScale(0.5,0.5);
	}
    
    
    [UIView animateWithDuration:1.0 / 0.58 animations:^{
        plotView.alpha = 1.0;
        NSUInteger index = 0;
        [UIView setAnimationRepeatCount:0.58];
        [UIView setAnimationRepeatAutoreverses:YES];
        
        for (NSDictionary *barInfo in chartDataArray)  {
            bar = [barViews objectAtIndex:index];
            bar.transform = CGAffineTransformMakeScale(1.1,1.1);
            index++;
        }
    } completion:^(BOOL finished) {
        NSUInteger index = 0;
        for (NSDictionary *barInfo in chartDataArray)  {
            bar = [barViews objectAtIndex:index];
            bar.transform = CGAffineTransformIdentity;
            index++;
        }
    }];
}

//------------------------------------------------------//
//--- Settings -----------------------------------------//
//------------------------------------------------------//
#pragma mark - Settings

- (void)setupBarViewStyle:(BarDisplayStyle)displayStyle {
    [bar setupBarStyle:displayStyle];
    self.barViewDisplayStyle = displayStyle;
}

- (void)setupBarViewShape:(BarShape)shape {
    [bar setupBarShape:shape];
    self.barViewShape = shape;
}

- (void)setupBarViewShadow:(BarShadow)shadow {
    [bar setupBarShadow:shadow];
    self.barViewShadow = shadow;
}

- (void)setupBarViewAnimation:(BarAnimation)animation {
    self.barViewAnimation = animation;
}

//------------------------------------------------------//
//--- Data ---------------------------------------------//
//------------------------------------------------------//
#pragma mark - Data

- (void)setXmlData:(NSData *)xmlData showAxis:(AxisDisplaySetting)axisDisplay withColor:(UIColor *)axisColor withFont:(UIFont *)axisFont shouldPlotVerticalLines:(BOOL)verticalLines {
	// Clear current chart data
    [chartDataArray removeAllObjects];
    
    // Set chart data
	XMLElement *xml = [XMLParser parse:xmlData];
	
	if (!(xml != NULL && xml.children.count)) 
		return;
	
	NSMutableArray *barValues = [NSMutableArray arrayWithCapacity:0];
	@autoreleasepool {
		for (XMLElement *barElement in xml.children) {
			NSDictionary *barInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [barElement getAttribute:@"label"], @"label",
                                     [NSNumber numberWithFloat:[[barElement getAttribute:@"value"] floatValue]], @"value",
                                     [UIColor colorWithHexString:[barElement getAttribute:@"color"]], @"color",
                                     [UIColor colorWithHexString:[barElement getAttribute:@"labelColor"]], @"labelColor", nil];
			[chartDataArray addObject:barInfo];
			[barValues addObject:[NSNumber numberWithFloat:[[barElement getAttribute:@"value"] floatValue]]];
		}
	}
	
	// Setup the maximum chart values based on the chartData
	maxValue = [[barValues valueForKeyPath:@"@max.floatValue"] floatValue] + [[barValues valueForKeyPath:@"@max.floatValue"] floatValue]*15/100;
	realMaxValue = [[barValues valueForKeyPath:@"@max.floatValue"] floatValue];
	maxValue = maxValue - fmodf(maxValue, STEP_AXIS_Y);
	if (maxValue < realMaxValue)  {
		maxValue = maxValue + STEP_AXIS_Y;
	}
	
    // Get axis display settings
    if (axisDisplay == DisplayBothAxes) {
        showAxisY = YES;
        showAxisX = YES;
    } else if (axisDisplay == DisplayNietherAxes) {
        showAxisY = NO;
        showAxisX = NO;
    } else if (axisDisplay == DisplayOnlyXAxis) {
        showAxisY = NO;
        showAxisX = YES;
    } else if (axisDisplay == DisplayOnlyYAxis) {
        showAxisY = YES;
        showAxisX = NO;
    }
    
    // Set vertical lines attribute
	plotVerticalLines = verticalLines;
	
    // Set color of axis
	colorAxisY = axisColor;
	
    // Set axis specific properties
	if (showAxisX)  {
		fontSize = axisFont.pointSize;
	}
	
    // Setup maximum string size for labels
	CGSize maxStringSize = [[NSString stringWithFormat:@"%i", (int)maxValue] sizeWithFont:axisFont];
	
    // Setup plot chart area
	plotChart.frame = CGRectMake(0.0f, 0.0f, self.width, self.height - fontSize);
	plotChart.fontSize = axisFont.pointSize;
	plotChart.stepCountAxisX = chartDataArray.count;
	plotChart.stepWidthAxisY = self.width/STROKE_AXIS_Y_SCALE;
	plotChart.maxValueAxisY = maxValue;
	plotChart.stepValueAxisY = STEP_AXIS_Y;
	plotChart.colorAxisY = [colorAxisY CGColor];
	plotChart.plotVerticalLines = plotVerticalLines;
	
	if (showAxisY) {
		plotChart.labelSizeAxisY = maxStringSize;
	} else {
		plotChart.labelSizeAxisY = CGSizeZero;
    }
    
    // Display the configured chart
	[self setUpChart];
}

- (void)setDataWithArray:(NSArray *)chartData showAxis:(AxisDisplaySetting)axisDisplay withColor:(UIColor *)axisColor withFont:(UIFont *)axisFont shouldPlotVerticalLines:(BOOL)verticalLines {
    // Clear current chart data
    [chartDataArray removeAllObjects];
	
    // Make sure chartData is not nil
    if (!(chartData != NULL && chartData.count))
		return;
    
    // Set the chart data
    // Loop through chartData and retrieve attributes of each object to display on each bar
	NSMutableArray *barValues = [NSMutableArray arrayWithCapacity:0];
    @autoreleasepool {
        for (NSDictionary *objectData in chartData) {
            if ([[objectData objectForKey:@"color"] isKindOfClass:[UIColor class]]) {
                NSDictionary *barInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [objectData objectForKey:@"label"], @"label",
                                         [NSNumber numberWithFloat:[[objectData objectForKey:@"value"] floatValue]], @"value",
                                         [objectData objectForKey:@"color"], @"color",
                                         [objectData objectForKey:@"labelColor"], @"labelColor", nil];
                [chartDataArray addObject:barInfo];
                [barValues addObject:[NSNumber numberWithFloat:[[objectData objectForKey:@"value"] floatValue]]];
            } else {
                NSDictionary *barInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [objectData objectForKey:@"label"], @"label",
                                         [NSNumber numberWithFloat:[[objectData objectForKey:@"value"] floatValue]], @"value",
                                         [UIColor colorWithHexString:[objectData objectForKey:@"color"]], @"color",
                                         [UIColor colorWithHexString:[objectData objectForKey:@"labelColor"]], @"labelColor", nil];
                [chartDataArray addObject:barInfo];
                [barValues addObject:[NSNumber numberWithFloat:[[objectData objectForKey:@"value"] floatValue]]];
            }
        }
    }
    
    // Setup the maximum chart values based on the chartData
	maxValue = [[barValues valueForKeyPath:@"@max.floatValue"] floatValue] + [[barValues valueForKeyPath:@"@max.floatValue"] floatValue]*15/100;
	realMaxValue = [[barValues valueForKeyPath:@"@max.floatValue"] floatValue];
	maxValue = maxValue - fmodf(maxValue, STEP_AXIS_Y);
	if (maxValue < realMaxValue)  {
		maxValue = maxValue + STEP_AXIS_Y;
	}
	
    // Get axis display settings
    if (axisDisplay == DisplayBothAxes) {
        showAxisY = YES;
        showAxisX = YES;
    } else if (axisDisplay == DisplayNietherAxes) {
        showAxisY = NO;
        showAxisX = NO;
    } else if (axisDisplay == DisplayOnlyXAxis) {
        showAxisY = NO;
        showAxisX = YES;
    } else if (axisDisplay == DisplayOnlyYAxis) {
        showAxisY = YES;
        showAxisX = NO;
    } else {
        showAxisY = YES;
        showAxisX = YES;
    }
    
    // Set vertical lines attribute
	plotVerticalLines = verticalLines;
	
    // Set color of axis
	colorAxisY = axisColor;
	
    // Set axis specific properties
	if (showAxisX)  {
		fontSize = axisFont.pointSize;
	}
	
    // Setup maximum string size for labels
	CGSize maxStringSize = [[NSString stringWithFormat:@"%i", (int)maxValue] sizeWithFont:axisFont];
	
    // Setup plot chart area
	plotChart.frame = CGRectMake(0.0f, 0.0f, self.width, self.height - fontSize);
	plotChart.fontSize = axisFont.pointSize;
	plotChart.stepCountAxisX = chartDataArray.count;
	plotChart.stepWidthAxisY = self.width/STROKE_AXIS_Y_SCALE;
	plotChart.maxValueAxisY = maxValue;
	plotChart.stepValueAxisY = STEP_AXIS_Y;
	plotChart.colorAxisY = [colorAxisY CGColor];
	plotChart.plotVerticalLines = plotVerticalLines;
	
	if (showAxisY) {
		plotChart.labelSizeAxisY = maxStringSize;
	} else {
		plotChart.labelSizeAxisY = CGSizeZero;
    }
    
    // Display the configured chart
	[self setUpChart];
}

- (NSArray *)createChartDataWithTitles:(NSArray *)titles values:(NSArray *)values colors:(NSArray *)colors labelColors:(NSArray *)labelColors {
    // Make sure each array has the same number of objects, otherwise there'll be an exception and a crash
    if ([titles count] == [values count] && [titles count] == [colors count] && [colors count] == [labelColors count]) {
        NSMutableArray *chartData = [[NSMutableArray alloc] init];
        for (int i =  0; i < [titles count]; i++) {
            if ([[colors objectAtIndex:i] isKindOfClass:[UIColor class]] && [[labelColors objectAtIndex:i] isKindOfClass:[UIColor class]]) {
                NSDictionary *barInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [titles objectAtIndex:i], @"label",
                                         [values objectAtIndex:i], @"value",
                                         [colors objectAtIndex:i], @"color",
                                         [labelColors objectAtIndex:i], @"labelColor",
                                         nil];
                [chartData addObject:barInfo];
            } else if ([[colors objectAtIndex:i] isKindOfClass:[NSString class]] && [[labelColors objectAtIndex:i] isKindOfClass:[NSString class]]) {
                NSDictionary *barInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [titles objectAtIndex:i], @"label",
                                         [values objectAtIndex:i], @"value",
                                         [colors objectAtIndex:i], @"color",
                                         [labelColors objectAtIndex:i], @"labelColor",
                                         nil];
                [chartData addObject:barInfo];
            } else {
                NSLog(@"Error while creating chart data. The color and labelColor NSArrays specified in the [createChartDataWithTitles: andValues: andColors: andLabelColors:]; method must have the exact same number of objects and types of objects. Make sure both the color array and the labelColor array contain only UIColor objects or only HEX Strings then try again. Below are the objects in both arrays:\nColors Array: %@ \nLabel Colors Array: %@ objects", colors, labelColors);
                return nil;
            }
        }
        return chartData;
    } else {
        NSLog(@"Error while creating chart data. Each NSArray specified in the [createChartDataWithTitles: andValues: andColors: andLabelColors:]; method must have the exact same number of objects. Make sure each array has the same number of objects then try again. Below are the number of objects in each array:\nTitles Array: %i objects\nValues Array: %i objects\nColors Array: %i objects\nLabel Colors Array: %i objects", [titles count], [values count], [colors count], [labelColors count]);
        return nil;
    }
}


@end
