//
//  ChartColors.m
//  Created by Everett Michaud on 8/22/13.

#import "ChartColors.h"

@interface ChartColors()
@property (nonatomic,strong) NSArray *standardColors;
@end

@implementation ChartColors
- (id)init {
    self = [super init];
    if (self) {
        _standardColors = [self generateListOfStandardColors];
    }
    return self;
}
- (UIColor*)colorForIndex:(NSUInteger)index {
    UIColor *sliceColor = [self.standardColors objectAtIndex:(index % self.standardColors.count)];
    return sliceColor;
}
- (UIColor*)green {
    return [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
}
- (UIColor*)red {
    return [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f];
}
- (UIColor*)yellow {
    return [UIColor colorWithRed:1.0f green:0.79f blue:0.28f alpha:1.0f];
}
- (UIColor*)orange {
    return [UIColor colorWithRed:1.0f green:0.58f blue:0.21f alpha:1.0f];
}
- (UIColor*)lightBlue {
    return [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];
}
- (UIColor*)darkBlue {
    return [UIColor colorWithRed:0.0f green:0.49f blue:0.96f alpha:1.0f];
}
- (UIColor*)purple {
    return [UIColor colorWithRed:0.35f green:0.35f blue:0.81f alpha:1.0f];
}
- (NSArray*)listOfStandardColors {
    return _standardColors;
}
- (NSArray*)generateListOfStandardColors {
    
    NSMutableArray *colors = [NSMutableArray array];
    
    //#fecc09 (yellow)
    [colors addObject:[UIColor colorWithRed:0.996 green:0.800 blue:0.035 alpha:1.000]];
    
    //#17b7fe (blue)
    [colors addObject:[UIColor colorWithRed:0.090 green:0.718 blue:0.996 alpha:1.000]];
    
    //#a410f9 (purple)
    [colors addObject:[UIColor colorWithRed:0.643 green:0.063 blue:0.976 alpha:1.000]];
    
    //IOS7 RedColor
    [colors addObject:[UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f]];
    
    //IOS7 OrangeColor
    [colors addObject:[UIColor colorWithRed:1.0f green:0.58f blue:0.21f alpha:1.0f]];
    
    //IOS7 Green
    [colors addObject:[UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f]];
    
    //IOS7 YellowColor
    [colors addObject:[UIColor colorWithRed:1.0f green:0.79f blue:0.28f alpha:1.0f]];
    
    //pink color
    [colors addObject:[UIColor colorWithRed:1.0f green:0.17f blue:0.34f alpha:1.0f]];
    
    //#095bff (darker blue)
    [colors addObject:[UIColor colorWithRed:0.035 green:0.357 blue:1.000 alpha:1.000]];
    
    //#9da2a4 (gray)
    [colors addObject:[UIColor colorWithRed:0.616 green:0.635 blue:0.643 alpha:1.000]];
    
    //#fc1c1c (red)
    [colors addObject:[UIColor colorWithRed:0.988 green:0.110 blue:0.110 alpha:1.000]];
    
    //#fd7c08 (orange)
    [colors addObject:[UIColor colorWithRed:0.992 green:0.486 blue:0.031 alpha:1.000]];
    
    //#7b7b81 (darker gray)
    [colors addObject:[UIColor colorWithRed:0.482 green:0.482 blue:0.506 alpha:1.000]];
    
    //#fec809 (darker yellow)
    [colors addObject:[UIColor colorWithRed:0.996 green:0.784 blue:0.035 alpha:1.000]];
    
    //green
    [colors addObject: [UIColor colorWithRed:25/255.0f green:188/255.0f blue:63/255.0f alpha:1.0]];
    
    //brown
    [colors addObject:[UIColor colorWithRed:94/255.0f green:38/255.0f blue:5/255.0f alpha:1.0]];

    //Orange
    [colors addObject:[UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1]];
    
    //#479543 (darker green)
    [colors addObject:[UIColor colorWithRed:0.278 green:0.584 blue:0.263 alpha:1.000]];
    
    //Blue
    [colors addObject:[UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1]];
    
    //Goldenrod #FCD667
    [colors addObject:[UIColor colorWithRed:0.988 green:0.839 blue:0.404 alpha:1]];

    //Red
    [colors addObject:[UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1]];

    //Black
    [colors addObject:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    
    //wheat
    [colors addObject:[UIColor colorWithRed:1 green:0.725 blue:0.482 alpha:1]];

    //#26df12 (green)
    [colors addObject:[UIColor colorWithRed:0.149 green:0.875 blue:0.071 alpha:1.000]];
    
    //Gray
    [colors addObject:[UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1]];
    
    //lt blue #7A89B8
    [colors addObject:[UIColor colorWithRed:0.478 green:0.537 blue:0.722 alpha:1]];
    
    //Peach #FFCBA4
    [colors addObject:[UIColor colorWithRed:1 green:0.796 blue:0.643 alpha:1]];
    
    //orange #ff6037
    [colors addObject:[UIColor colorWithRed:1 green:0.376 blue:0.216 alpha:1]];
    
    //Green
    [colors addObject:[UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1]];
    
    //Tumbleweed #dea681
    [colors addObject:[UIColor colorWithRed:0.871 green:0.651 blue:0.506 alpha:1]];
    
    //Gray #8B8680
    [colors addObject:[UIColor colorWithRed:0.545 green:0.525 blue:0.502 alpha:1]];
    
    //yellow #FFFF66
    [colors addObject:[UIColor colorWithRed:1 green:1 blue:0.4 alpha:1]];
    
    //red
    [colors addObject:[UIColor colorWithRed:0.992 green:0.055 blue:0.208 alpha:1]];
    
    //Navy Blue #0066CC
    [colors addObject:[UIColor colorWithRed:0 green:0.4 blue:0.8 alpha:1]];
    
    return colors;
}

@end
