//
//  BarChartItem.h
//  BarChart
//
//  Created by Everett Michaud on 9/5/13.
//
//

#import <Foundation/Foundation.h>

@interface BarChartItem : NSObject
@property (nonatomic,strong) NSString *barTitle;
@property (nonatomic,strong) NSNumber *barValue;
@property (nonatomic,copy) void (^selectionBlock)(NSString *title,NSNumber *value);
@end