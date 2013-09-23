//
//  BarChartModel.h
//  Created by Everett Michaud on 8/28/13.

#import <Foundation/Foundation.h>

@class BarChartView;
@class BarChartItem;
@class BarView;

@interface BarChartModel : NSObject
@property (nonatomic,strong) NSString *chartName;
@property (nonatomic,readonly) NSArray *listOfBarItems;
@property (nonatomic,strong) UIColor *labelColor;
@property (nonatomic,strong) UIFont *fontSize;
@property (nonatomic,assign) BOOL plotVerticalLines;

- (id)initWithBarChart:(BarChartView*)barChart;


/**
 The most basic way to get bar itmes on the chart.  The chart will automatically setup the bar colors for you. Simply add each item as a NSNumber along with a title set the flag for popup.
 
 @param	value An NSNumber object that represents the value of the bar.
 @param title The title of the bar
 @param showPopupTip Should the bar respond to taps?
 */
- (void)addItem:(NSNumber *)value
          title:(NSString *)title 
   showPopupTip:(BOOL)showPopupTip;


/**
 Basic method to add items that includes a selection block which allows for specific action to take if the bar it tapped.
 
 @param	value An NSNumber object that represents the value of the bar.
 @param title The title of the bar
 @param showPopupTip Should the bar respond to taps?
 @param onSelection Use selection block to take a specific action after the bar is tapped
 */

- (void)addItem:(NSNumber *)value
          title:(NSString *)title
   showPopupTip:(BOOL)showPopupTip
    onSelection:(void (^)(BarView *barView,NSString *title,NSNumber *value,int index))didSelectBlock;



/**
 Advanced method to add items that includes customization options for setting the bar's color and bar's label color.  Also includes a selection block which allows for specific action to take if the bar it tapped.
 
 @param	value An NSNumber object that represents the value of the bar.
 @param title The title of the bar
 @param barColor Set the specific color of the bar
 @param labelColor Set the specific color of the bar label
 @param showPopupTip Should the bar respond to taps?
 @param onSelection Use selection block to take a specific action after the bar is tapped
 */

- (void)addItem:(NSNumber *)value
          title:(NSString *)title
       barColor:(UIColor *)barColor
     labelColor:(UIColor *)labelColor
   showPopupTip:(BOOL)showPopupTip
    onSelection:(void (^)(BarView *barView,NSString *title,NSNumber *value,int index))didSelectBlock;


/**
 Basic method to updateChart method after the model is properly configured. Each use assumes it is setting up a new chart.
 */
- (void)updateChart;

/**
 Advanced method to updateChart method after the model is properly configured. Each use assumes it is setting up a new chart.
 
 @param	value An NSNumber object that represents the value of the bar.
 @param title The title of the bar
 @param showPopupTip Should the bar respond to taps?
 @param preconfigurationBlock Use block to configure chart properties before the chart is updated.
 */
- (void)updateChartWithPreConfiguration:(void(^)(BarChartView *barChart)) preconfigurationBlock;


/**
 Method to call on the model to retrieve the specific BarChartItem when a selection is made.
 */

- (BarChartItem*)itemForIndex:(NSInteger)index;
@end
