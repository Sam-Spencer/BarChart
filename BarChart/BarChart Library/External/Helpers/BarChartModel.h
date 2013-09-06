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

- (void)addItem:(NSNumber *)value 
          title:(NSString *)title 
   showPopupTip:(BOOL)showPopupTip;

- (void)addItem:(NSNumber *)value
          title:(NSString *)title
   showPopupTip:(BOOL)showPopupTip
    onSelection:(void (^)(BarView *barView,NSString *title,NSNumber *value,int index))didSelectBlock;

- (void)addItem:(NSNumber *)value
          title:(NSString *)title
       barColor:(UIColor *)barColor
     labelColor:(UIColor *)labelColor
   showPopupTip:(BOOL)showPopupTip
    onSelection:(void (^)(BarView *barView,NSString *title,NSNumber *value,int index))didSelectBlock;

- (void)updateChart;

- (void)updateChartWithPreConfiguration:(void(^)(BarChartView *barChart)) preconfigurationBlock;

- (BarChartItem*)itemForIndex:(NSInteger)index;
@end
