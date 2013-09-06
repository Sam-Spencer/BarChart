//
//  BarChartModel.m
//  Created by Everett Michaud on 8/28/13.

#import "BarChartModel.h"
#import "BarChartView.h"
#import "ChartColors.h"
#import "BarChartItem.h"
#import "BarView.h"


@interface BarChartModel()<BarViewDelegate>
@property (nonatomic,strong) ChartColors *chartColors;
@property (nonatomic,strong) BarChartView *barChart;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSMutableArray *itemColors;
@property (nonatomic,strong) NSMutableArray *labelColors;
@property (nonatomic,strong) NSMutableArray *tempListOfItems;
@property (nonatomic,readwrite) NSArray *listOfBarItems;
@end


@implementation BarChartModel

- (id)initWithBarChart:(BarChartView*)barChart {
    
    if ([self init]) {
        barChart.barViewDelegate = self;
        self.barChart = barChart;
        self.labelColor = [UIColor darkGrayColor];
        self.fontSize = [UIFont systemFontOfSize:11];
        self.plotVerticalLines = YES;
        self.chartColors = [[ChartColors alloc]init];
    }
    return self;
    
}
- (void)updateChartWithPreConfiguration:(void (^)(BarChartView *))preconfigurationBlock {
    
    preconfigurationBlock(self.barChart);
    [self updateChart];
    
}
- (void)updateChart {
    
    /* return if no items */
    if (self.items.count == 0) {
        return;
    }
    
    /* create list of BarItems for external use */
    self.listOfBarItems = [NSArray arrayWithArray:self.tempListOfItems];
    
    /* conform to current barChart initialization requirements */
    NSArray *chartArray = [self.barChart createChartDataWithTitles:[self.titles copy] values:[self.items copy] colors:[self.itemColors copy] labelColors:[self.labelColors copy]];

    [self.barChart  setDataWithArray:chartArray
                            showAxis:DisplayBothAxes
                           withColor:self.labelColor
                            withFont:self.fontSize
             shouldPlotVerticalLines:YES];
    
    /* reset items as flag that next update is new */
    self.items = nil;
    
}
- (void)addItem:(NSNumber *)value title:(NSString *)title showPopupTip:(BOOL)showPopupTip {
    
    [self addItem:value title:title barColor:nil labelColor:nil showPopupTip:showPopupTip onSelection:nil];
    
}
- (void)addItem:(NSNumber *)value 
          title:(NSString *)title 
   showPopupTip:(BOOL)showPopupTip
    onSelection:(void (^)(BarView *barView,NSString *title,NSNumber *value,int index))didSelectBlock {
    
    [self addItem:value title:title barColor:nil labelColor:nil showPopupTip:showPopupTip onSelection:didSelectBlock];
    
}
- (void)addItem:(NSNumber *)value
          title:(NSString *)title
       barColor:(UIColor *)barColor
     labelColor:(UIColor *)labelColor 
   showPopupTip:(BOOL)showPopupTip
    onSelection:(void (^)(BarView *barView,NSString *title,NSNumber *value,int index))didSelectBlock
{
    
    NSAssert([value isKindOfClass:[NSNumber class]] , @"A number value must be provided when adding a new item to chart!");
    
    /* if list is nil then create data structures */
    if (self.items.count == 0 || !self.items)
    {
        self.items = [NSMutableArray new];
        self.titles = [NSMutableArray new];
        self.itemColors = [NSMutableArray new];
        self.labelColors = [NSMutableArray new];
        self.tempListOfItems = [NSMutableArray new];
    }
    
    if (!title) {
        title = @"";
    }
    
    if (barColor) {
        [self.itemColors addObject:barColor];
    }
    else {
        [self.itemColors addObject:[self.chartColors colorForIndex:self.items.count]];
    }
    
    if (labelColor) {
        [self.labelColors addObject:labelColor];
    }
    else {
        [self.labelColors addObject:self.labelColor];
    }
    
    [self.items addObject:value];
    [self.titles addObject:title];
    
    /* come back to this and create an initializer for BarChartItem */
    BarChartItem *item = [[BarChartItem alloc]init];
    item.barTitle = [title copy];
    item.barValue = [value copy];
    item.showPopupTip = showPopupTip;
    item.selectionBlock = [didSelectBlock copy];
    
    [self.tempListOfItems addObject:item];
    
}
- (BarChartItem*)itemForIndex:(NSInteger)index {
    
    BarChartItem *item = [self.listOfBarItems objectAtIndex:index];
    return item;
}

- (BOOL)barChartItemDisplaysPopoverOnTap:(BarView *)barView {
    
    BarChartItem *item = [self itemForIndex:barView.indexOfItem];
    
    return item.showPopupTip;
    
}

- (void)barChartItemTapped:(BarView *)barView {
    
    NSLog(@"model:%@",self.chartName);

    NSLog(@"Item Tapped: title:%@ value:%.2f index:%d",barView.barTitle,barView.barValue,barView.indexOfItem);
    
    BarChartItem *item = [self itemForIndex:barView.indexOfItem];
    
    if (item.selectionBlock) {
        item.selectionBlock(barView,barView.barTitle,[NSNumber numberWithFloat:barView.barValue],barView.indexOfItem);
    }
}

@end
