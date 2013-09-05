//
//  BarChartModelExampleController.m
//  BarChart
//
//  Created by Everett Michaud on 9/5/13.
//
//

#import "BarChartModelExampleController.h"
#import "BarChartView.h"
#import "BarChartModel.h"

@interface BarChartModelExampleController ()
@property (weak, nonatomic) IBOutlet BarChartView *iboBarChart1;
@property (weak, nonatomic) IBOutlet BarChartView *iboBarChart2;

@end

@implementation BarChartModelExampleController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BarChartModel *chart2Model = [[BarChartModel alloc]initWithBarChart:self.iboBarChart2];

    [chart2Model addItem:@85 title:@"Math"];
    [chart2Model addItem:@74 title:@"Science"];
    [chart2Model addItem:@91 title:@"Language"];
    [chart2Model addItem:@93 title:@"Social Studies"];
    [chart2Model updateChartWithPreConfiguration:^(BarChartView *barChart) {
        
        //Set the Shape of the Bars (Rounded or Squared) - Rounded is default
        [barChart  setupBarViewShape:BarShapeRounded];
        
        //Set the Style of the Bars (Glossy, Matte, or Flat) - Glossy is default
        [barChart setupBarViewStyle:BarStyleFlat];
        
        //Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
        [barChart  setupBarViewShadow:BarShadowHeavy];
        
        //Set the Initial Animation of the Bars (Rise, Float, Fade, or None) - Rise is default
        [barChart setupBarViewAnimation:BarAnimationRise];
    }];
}

@end
