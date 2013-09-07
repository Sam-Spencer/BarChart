//
//  BarChartEasyModelController.m
//  BarChart
//
//  Created by Everett Michaud on 9/5/13.
//
//

#import "BarChartEasyModelController.h"
#import "BarChartView.h"
#import "BarChartModel.h"


@interface BarChartEasyModelController ()
@property (weak, nonatomic) IBOutlet BarChartView *chartOnTop;
@property (nonatomic,strong) BarChartModel *chartOnTopModel;
@property (nonatomic,strong) NSArray *weekDayData;
@property (nonatomic,strong) NSArray *surveyResultsData;
@property (nonatomic,strong) NSArray *teamData;
@property (weak, nonatomic) IBOutlet BarChartView *chartOnBottomLeft;
@property (weak, nonatomic) IBOutlet BarChartView *chartOnBottomRight;

@end

@implementation BarChartEasyModelController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupDataSources];
    [self setupChartOnTop];
    [self setupChartOnBottomLeft];
    [self setupChartOnBottomRight];
  
}
- (void)setupDataSources {
    
    NSDictionary *d1 = @{@"title": @"Wings",@"value":@24.5};
    NSDictionary *d2 = @{@"title": @"Lions",@"value":@33.0};
    NSDictionary *d3 = @{@"title": @"Pistons",@"value":@21.5};
    NSDictionary *d4 = @{@"title": @"Tigers",@"value":@24.5};
    self.teamData = @[d1,d2,d3,d4];
    
    
    NSDictionary *d8 = @{@"title": @"Mon",@"value":@24.5};
    NSDictionary *d9 = @{@"title": @"Tue",@"value":@29.5};
    NSDictionary *d10 = @{@"title": @"Wed",@"value":@22.5};
    NSDictionary *d11 = @{@"title": @"Thu",@"value":@19.5};
    NSDictionary *d12 = @{@"title": @"Fri",@"value":@34.5};
    self.weekDayData = @[d8,d9,d10,d11,d12];
    
    
}
- (void)setupChartOnTop {
    
     /* A basic bar chart in about 4 lines of code.
     
       Simply iterate through your datasource and add items as needed.  
       BarChartModel will automatically assign a bar color to each item and use
       standard default settings.
     
     */
    
    BarChartModel *model1 = [[BarChartModel alloc]initWithBarChart:self.chartOnTop];
    
    for (NSDictionary *dict in self.weekDayData) {
        [model1 addItem:dict[@"value"] title:dict[@"title"] showPopupTip:YES];
    }
    
    [model1 updateChart];
}
- (void)setupChartOnBottomLeft {
    
    /* A basic bar chart with some specific configuration options set
     using the a PreConfigurationBlock
     
     Add bar items as noted in TopChart and then call updateChartWithPreConfiguration
     rather than updateChart.  updateChartWithPreConfiguration includes a block that is
     executed just before updating the bar chart. Here we use this block to set barChart 
     configuration values prior to updating.
     
     */
    
    BarChartModel *LLModel = [[BarChartModel alloc]initWithBarChart:self.chartOnBottomLeft];
    
    for (NSDictionary *dict in self.teamData) {
        [LLModel addItem:dict[@"value"] title:dict[@"title"] showPopupTip:YES];
    }
    
    [LLModel updateChartWithPreConfiguration:^(BarChartView *barChart) {
        
        [barChart setupBarViewShape:BarShapeRounded];
        [barChart setupBarViewStyle:BarStyleFlat];
        [barChart setupBarViewShadow:BarShadowHeavy];
        [barChart setupBarViewAnimation:BarAnimationFade];
        [barChart setBarCornerRadius:4.0f];
        
    }];
    
}
- (void)setupChartOnBottomRight {
    
    /* A basic bar chart with some specific configuration options set
       using the a PreConfigurationBlock
     
       Note that the data model is created in an adhoc manner.  Some charts 
       have very simple needs and this is an example of how to create a very
       basic chart (YES/NO) with some specific configuration in less than 10 lines 
       of code.
     
     */
    
    BarChartModel *LRModel = [[BarChartModel alloc]initWithBarChart:self.chartOnBottomRight];
    
    [LRModel addItem:@43 title:@"Yes" barColor:[UIColor blueColor] labelColor:nil showPopupTip:YES onSelection:nil];
    
    [LRModel addItem:@40 title:@"No" barColor:[UIColor redColor] labelColor:nil showPopupTip:NO onSelection:nil];

    [LRModel updateChartWithPreConfiguration:^(BarChartView *barChart) {
        
        [barChart setupBarViewShape:BarShapeSquared];
        [barChart setupBarViewStyle:BarStyleFair];
        [barChart setupBarViewAnimation:BarAnimationFloat];
    }];
    
    
}


@end
