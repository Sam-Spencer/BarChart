//
//  BarTypes.h
//  BarChart
//
//  Created by iRare Media on 6/5/13.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    DisplayBothAxes = 0,
    DisplayNietherAxes = 1,
    DisplayOnlyXAxis = 2,
    DisplayOnlyYAxis = 3
} AxisDisplaySetting;

typedef enum {
    BarStyleGlossy = 0,
    BarStyleMatte = 1,
    BarStyleFair = 2,
    BarStyleFlat = 3
} BarDisplayStyle;

typedef enum {
    BarShapeRounded = 0,
    BarShapeSquared = 1
} BarShape;

typedef enum {
    BarShadowHeavy = 0,
    BarShadowLight  = 1,
    BarShadowNone = 2
} BarShadow;

typedef enum {
    BarAnimationRise = 0,
    BarAnimationFade  = 1,
    BarAnimationFloat = 2,
    BarAnimationNone = 3
} BarAnimation;
