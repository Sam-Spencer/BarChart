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
    
    
    NSDictionary *d5 = @{@"title": @"Yes",@"value":@24.5};
    NSDictionary *d6 = @{@"title": @"No",@"value":@17.75};
    self.surveyResultsData = @[d5,d6];
    
    
    NSDictionary *d8 = @{@"title": @"Mon",@"value":@24.5};
    NSDictionary *d9 = @{@"title": @"Tue",@"value":@29.5};
    NSDictionary *d10 = @{@"title": @"Wed",@"value":@22.5};
    NSDictionary *d11 = @{@"title": @"Thu",@"value":@19.5};
    NSDictionary *d12 = @{@"title": @"Fri",@"value":@34.5};
    self.weekDayData = @[d8,d9,d10,d11,d12];
    
    
}
- (void)setupChartOnBottomRight {
    BarChartModel *LRModel = [[BarChartModel alloc]initWithBarChart:self.chartOnBottomRight];
    LRModel.chartName = @"Lower Right";
    for (NSDictionary *dict in self.surveyResultsData) {
        [LRModel addItem:dict[@"value"] title:dict[@"title"] showPopupTip:YES];
    }
    [LRModel updateChartWithPreConfiguration:^(BarChartView *barChart) {
        
        [barChart  setupBarViewShape:BarShapeSquared];
        [barChart setupBarViewStyle:BarStyleFair];
        [barChart setupBarViewAnimation:BarAnimationFloat];
    }];
    
    
}
- (void)setupChartOnBottomLeft {
    
    
    BarChartModel *LLModel = [[BarChartModel alloc]initWithBarChart:self.chartOnBottomLeft];
    LLModel.chartName = @"lowerleft";
    for (NSDictionary *dict in self.teamData) {
        [LLModel addItem:dict[@"value"] title:dict[@"title"] showPopupTip:YES];
    }
    
    [LLModel updateChartWithPreConfiguration:^(BarChartView *barChart) {
        //Set the Shape of the Bars (Rounded or Squared) - Rounded is default
        [barChart  setupBarViewShape:BarShapeRounded];
        [barChart setupBarViewStyle:BarStyleFlat];
        [barChart  setupBarViewShadow:BarShadowHeavy];
        barChart.barCornerRadius = 4.0f;
        [barChart setupBarViewAnimation:BarAnimationFade];
    }];
    
}
- (void)setupChartOnTop {
    
    BarChartModel *model1 = [[BarChartModel alloc]initWithBarChart:self.chartOnTop];
    model1.chartName = @"upperchart";
    
    for (NSDictionary *dict in self.weekDayData) {
        [model1 addItem:dict[@"value"] title:dict[@"title"] showPopupTip:YES];
    }
    
    [model1 updateChart];
}
@end
