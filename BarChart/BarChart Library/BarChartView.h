//
//  BarChartView.h
//
//  Created by Mezrin Kirill on 17.02.12
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

#if !__has_feature(objc_arc)
#error BarChart uses Objective-C ARC. Turn on ARC and convert this project to ARC OR add the -fobjc-arc compiler flag to the BarChart files in your Project Build Phases.
#endif

#define MAX_BAR_WIDTH 60.0f
#define STEP_AXIS_Y 20.0f
#define STROKE_AXIS_Y_SCALE 85
#define FONT_SIZE 12.0f
#define PLOT_PADDING_TOP 10.0f
#define PLOT_PADDING_BOTTOM 10.0f

#import <UIKit/UIKit.h>
#import "PlotChartView.h"
#import "UIViewSizeShortcuts.h"
#import "XMLParser.h"
#import "UIColor+i7HexColor.h"
#import "BarView.h"
#import "BarLabel.h"
#import "BarTypes.h"

@interface BarChartView : UIView {
	PlotChartView *plotChart;
	UIView *plotView;
	
	NSMutableArray *barViews;
	NSMutableArray *barLabels;
	NSMutableArray *chartDataArray;
	
	BOOL showAxisY;
	BOOL showAxisX;
	BOOL plotVerticalLines;
	
	UIColor *colorAxisY;
	UIColor *bgColor;
	
	CGFloat realMaxValue;
	CGFloat maxValue;
	
	double barHeightRatio;
	CGFloat leftPadding;
	CGFloat barWidth;
	CGFloat stepWidth;
	CGFloat barFullWidth;
	CGFloat fontSize;
}

@property (nonatomic, strong) id <BarViewDelegate> barViewDelegate;

@property (assign) BarDisplayStyle barViewDisplayStyle;
@property (assign) BarShape barViewShape;
@property (assign) BarShadow barViewShadow;
@property (assign) BarAnimation barViewAnimation;
@property (nonatomic, strong) UIColor *plotViewColor;
@property (nonatomic, assign) CGFloat barCornerRadius;

/**
 	Set the data source for the bar graph using XML data. This method will generate and display a bar graph based on the provided parameters and using any other data set with other methods.
 
 	@param	xmlData	The XML data must conform to the format specified in the BarChart documentation, otherwise a parsing error may occur.
 	@param	axisDisplay	The Axis Display setting, choose which axis should be displayed: X, Y, both, or neither.
    @param	axisColor	The color of the displayed axis
    @param	axisFont	The font of the displayed axis, if no font is set the system font will be used at 12 pt.
 	@param	verticalLines	A boolean value determining whether or not vertical lines should be plotted
 */
- (void)setXmlData:(NSData *)xmlData showAxis:(AxisDisplaySetting)axisDisplay withColor:(UIColor *)axisColor withFont:(UIFont *)axisFont shouldPlotVerticalLines:(BOOL)verticalLines;

/**
 	Set the data source for the bar graph using an NSArray of data. This method will generate and display a bar graph based on the provided parameters and using any other data set with other methods.
 
 	@param	chartData	The NSArray data must conform to the format specified in the BarChart documentation, otherwise a parsing error may occur. It is recommended that you use the createChartDataWithTitles:values:colors:labelColors: method to format your data properly
 	@param	axisDisplay	The Axis Display setting, choose which axis should be displayed: X, Y, both, or neither.
    @param	axisColor	The color of the displayed axis
    @param	axisFont	The font of the displayed axis, if no font is set the system font will be used at 12 pt.
 	@param	verticalLines	A boolean value determining whether or not vertical lines should be plotted
 */
- (void)setDataWithArray:(NSArray *)chartData showAxis:(AxisDisplaySetting)axisDisplay withColor:(UIColor *)axisColor withFont:(UIFont *)axisFont shouldPlotVerticalLines:(BOOL)verticalLines;

/**
 	Generate a properly formatted NSArray of bar graph data, this data returned from this method should be used in the setDataWithArray:showAxis:withColor:shouldPlotVerticalLines: method
 
 	@param	titles	An array of titles for each value, these will be displayed on the bar chart to the user
 	@param	values	An array of values (in the same order as the titles) to populate the bar chart with for the corresponding titles
 	@param	colors	An array of HEX color values for each bar in the bar chart
 	@param	labelColors	An array of HEX color values for each bar label in the bar chart
 
 	@return	NSArray of properly formatted Bar Chart data to be displayed in a BarChart
 */
- (NSArray *)createChartDataWithTitles:(NSArray *)titles values:(NSArray *)values colors:(NSArray *)colors labelColors:(NSArray *)labelColors;

- (void)setupBarViewStyle:(BarDisplayStyle)displayStyle;
- (void)setupBarViewShape:(BarShape)shape;
- (void)setupBarViewShadow:(BarShadow)shadow;
- (void)setupBarViewAnimation:(BarAnimation)animation;

@end
