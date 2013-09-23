//
//  BarChartItem.h
//  BarChart
//
//  Created by Everett Michaud on 9/5/13.
//
//

#import <Foundation/Foundation.h>
@class BarView;

@interface BarChartItem : NSObject
@property (nonatomic,strong) NSString *barTitle;
@property (nonatomic,strong) NSNumber *barValue;
@property (nonatomic,assign) BOOL showPopupTip;
@property (nonatomic,copy) void (^selectionBlock)(BarView *barView,NSString *title,NSNumber *value,NSInteger index);
@end