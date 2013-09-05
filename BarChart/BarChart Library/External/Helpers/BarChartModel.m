//
//  BarChartModel.m
//  Created by Everett Michaud on 8/28/13.

#import "BarChartModel.h"
#import "BarChartView.h"
#import "ChartColors.h"
#import "BarChartItem.h"

@interface BarChartModel() <BarViewDelegate>
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
        _barChart = barChart;
        [_barChart setBarViewDelegate:self];
        _labelColor = [UIColor darkGrayColor];
        _fontSize = [UIFont systemFontOfSize:11];
        _plotVerticalLines = YES;
        _chartColors = [[ChartColors alloc]init];
        
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
    
    



    //self.barChart.barCornerRadius = 3.0f;
    [self.barChart setBackgroundColor:[UIColor clearColor]];
    
    //Generate the bar chart using the formatted data
    [self.barChart  setDataWithArray:chartArray
                            showAxis:DisplayBothAxes
                           withColor:self.labelColor
                            withFont:self.fontSize
             shouldPlotVerticalLines:YES];
    
    /* reset items */
    self.items = nil;
    
}
- (void)addItem:(NSNumber *)value title:(NSString *)title {
    
    NSAssert([value isKindOfClass:[NSNumber class]] , @"A number value must be provided when adding a new item to chart!");
    
    /* if list is nil then create data structures */
    if (_items.count == 0 || !_items)
    {
        _items = [NSMutableArray new];
        _titles = [NSMutableArray new];
        _itemColors = [NSMutableArray new];
        _labelColors = [NSMutableArray new];
        _tempListOfItems = [NSMutableArray new];
    }
    
    if (!title) {
        title = @"";
    }
    
    [self.items addObject:value];
    [self.titles addObject:title];
    [self.itemColors addObject:[self.chartColors colorForIndex:self.items.count]];
    [self.labelColors addObject:self.labelColor];
    
    BarChartItem *item = [[BarChartItem alloc]init];
    item.barTitle = [title copy];
    item.barValue = [value copy];
    
    [self.tempListOfItems addObject:item];
}
- (void)addItem:(NSNumber *)value
          title:(NSString *)title
       barColor:(UIColor *)barColor
     labelColor:(UIColor *)labelColor
   whenSelected:(void (^)(NSString *title,NSNumber *value,int index))didSelectBlock {
    
    
    
}
- (BarChartItem*)itemForIndex:(NSInteger)index {
    
    BarChartItem *item = [self.listOfBarItems objectAtIndex:index];
    return item;
}

- (BOOL)barChartItemDisplaysPopoverOnTap {
    // Return YES to enable popups above bars when they're tapped. Popups will show the exact value of the bar. Return NO to disable popups. The default is YES.
    return YES;
}

- (void)barChartItemTapped:(BarView *)barView {
    NSLog(@"Model: Bar Chart Item Tapped: %@", barView);
}

@end
