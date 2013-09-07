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
@property (weak, nonatomic) IBOutlet BarChartView *iboBarChart2;
@property (nonatomic,strong) BarChartModel *chart2Model;

@end

@implementation BarChartModelExampleController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.navigationController) {
        self.navigationItem.title = @"Wins by Team";
    }
    __weak typeof(self) blockSelf = self;
    
    self.chart2Model = [[BarChartModel alloc]initWithBarChart:self.iboBarChart2];

    NSArray *item1Values = @[@17,@23,@20,@14];
    
    [self.chart2Model addItem:[item1Values valueForKeyPath:@"@sum.self"]
                   title:@"Wings" 
            showPopupTip:NO
             onSelection:^(BarView *barView, NSString *title, NSNumber *value, int index) {
        
        UIViewController *controller = [[UIViewController alloc]init];
        controller.title = title;
                 BarChartView *chart = [[BarChartView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
                 BarChartModel *model = [[BarChartModel alloc]initWithBarChart:chart];
                 
                 for (NSNumber *num in item1Values) {
                     [model addItem:num title:[num stringValue] showPopupTip:YES];
                 }
                 
                 [model updateChartWithPreConfiguration:^(BarChartView *barChart) {
                     [barChart  setupBarViewShape:BarShapeRounded];
                     [barChart setupBarViewStyle:BarStyleFlat];
                     [barChart  setupBarViewShadow:BarShadowHeavy];
                     barChart.barCornerRadius = 4.0f;
                     [barChart setupBarViewAnimation:BarAnimationFade];
                 }];
                 
                 [controller.view addSubview:chart];
                 
                 [blockSelf.navigationController pushViewController:controller animated:YES];
                 controller.view.backgroundColor = [UIColor blueColor];
                 return;
    }];
    
    [self.chart2Model addItem:@16
                   title:@"Lions" 
                barColor:[UIColor greenColor] 
              labelColor:nil 
            showPopupTip:YES 
             onSelection:nil];
    
    [self.chart2Model addItem:@91
                   title:@"Pistons" 
                barColor:[UIColor brownColor]
              labelColor:[UIColor blueColor] 
            showPopupTip:NO 
             onSelection:^(BarView *barView, NSString *title, NSNumber *value, int index) {
                
                NSString *message = [NSString stringWithFormat:@"You selected:%@ \nvalue:%@",title,value];
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Bar Item Selected" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }];
    
    
    [self.chart2Model addItem:@93
                   title:@"Tigers" 
                barColor:nil 
              labelColor:nil 
            showPopupTip:NO
             onSelection:^(BarView *barView, NSString *title, NSNumber *value, int index) {
        
        NSLog(@"block selection - bar:%@ value:%@ index:%d",title,value,index);
                 
                 NSString *message = [NSString stringWithFormat:@"You selected:%@ \nvalue:%@",title,value];
                 
                 UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:message delegate:nil cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Destructive Button" otherButtonTitles:@"Other Button", nil];
                 
                 [actionSheet showFromTabBar:blockSelf.tabBarController.tabBar];
                 
    }];
    
    
    [self.chart2Model updateChartWithPreConfiguration:^(BarChartView *barChart) {
        
        //Set the Shape of the Bars (Rounded or Squared) - Rounded is default
        [barChart  setupBarViewShape:BarShapeRounded];
        
        //Set the Style of the Bars (Glossy, Matte, or Flat) - Glossy is default
        [barChart setupBarViewStyle:BarStyleFlat];
        
        //Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
        [barChart  setupBarViewShadow:BarShadowHeavy];
        
        barChart.barCornerRadius = 4.0f;
        
        //[barChart setBackgroundColor:[UIColor clearColor]];
        //Set the Initial Animation of the Bars (Rise, Float, Fade, or None) - Rise is default
        [barChart setupBarViewAnimation:BarAnimationRise];
    }];
}

@end
