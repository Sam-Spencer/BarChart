//
//  ChartColors.h
//  Created by Everett Michaud on 8/22/13.


#import <Foundation/Foundation.h>

@interface ChartColors : NSObject
- (UIColor*)green;
- (UIColor*)red;
- (UIColor*)yellow;
- (UIColor*)orange;
- (UIColor*)lightBlue;
- (UIColor*)darkBlue;
- (UIColor*)purple;
- (NSArray*)listOfStandardColors;
- (UIColor*)colorForIndex:(NSUInteger)index;
@end
