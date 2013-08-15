# Bar Chart 
BarChart is a Bar Graphing standalone library with animation for iOS Apps (Cocoa Touch). BarChart is easy to integrate with your existing or new iOS projects, allows for styling and easy customization, and provides multiple methods to easily populate your bar graph with data from a variety of sources (XML, NSArray, or NSDictionary).

![Screenshot on iPad and iPhone](https://github.com/iRareMedia/BarChart/raw/master/Screenshot.png)

## Integration
Follow these steps to add Bar Chart to your iOS App project in Xcode. Check the [compatibility requirements](https://github.com/iRareMedia/BarChart/blob/master/README.md#compatibility-requirements) to make sure you can use Bar Chart in your project.

 1. Add the CoreGraphics and QuartzCore Frameworks to your project  
 2. Add the Bar Chart files to your project (can be found in the folder titled *BarChart Library*)  
 3. Import Bar Chart into your View Controller: `#import "BarChartView.h"`  
 4. Create a Bar Chart View in your interface and set its class to `BarChartView`
 5. Connect the Bar Chart View to your ViewController Class: `@property (strong, nonatomic) IBOutlet BarChartView *barChart;`
 6. Loading data into the Bar Chart can be done using an `XML file` or with an `NSArray`. Please refer to one of the sections below about loading data.

##Loading Data with NSArray
Filling your Bar Chart with data from an NSArray is the easiest and most flexible way to setup and load data into a `BarChartView`. Bar Chart provides a simple method that properly formats and generates an `NSArray` for use with a Bar Chart. Here's how you can easily generate data for a Bar Chart:

    //Generate properly formatted data to give to the bar chart
    NSArray *array = [barChart createChartDataWithTitles:[NSArray arrayWithObjects:@"Title 1", @"Title 2", @"Title 3", @"Title 4", nil]
                                                  values:[NSArray arrayWithObjects:@"4.7", @"8.3", @"17", @"5.4", nil]
                                                  colors:[NSArray arrayWithObjects:@"87E317", @"17A9E3", @"E32F17", @"FFE53D", nil]
                                             labelColors:[NSArray arrayWithObjects:@"FFFFFF", @"FFFFFF", @"FFFFFF", @"FFFFFF", nil]];
                                             
As you can see, there are four different arrays you must pass as a parameter (none of the arrays can be nil, and they all must have the same number of objects). The first array, `Titles`, should contain the labels for each bar on the X-Axis from left to right. The second array, `values`, should contain the value of each bar from left to right. The last two arrays, `colors` and `labelColors`, should contain HEX values for each bar and its label from left to right.

The above method returns an `NSArray` if the arrays are properly formatted, if not the method will return `nil` and an error will be printed in the log.

##Loading Data with XML
To properly display and parse your data into a bar graph, Bar Chart must be given an XML file to read in the following format with the following attributes:

    <?xml version="1.0" encoding="UTF-8"?>
    <chart>
        <set label="T1" value="19" color="3e5273" labelColor="3e5273"/>
        <set label="T2" value="41" color="F0230C" labelColor="F0230C"/>
        <set label="T3" value="101" color="566967" labelColor="566967"/>
    </chart> 

It is important that all four attributes are present in each set, otherwise there may be an error or exception while creating the Bar Chart. Colors must be HEX values, they cannot be RGB or UIColor. Refer to the [`barChart.xml`](https://github.com/iRareMedia/BarChart/blob/master/BarChart/Data/barChart.xml) file to see an example of how to format your data.

Once you create and format an XML file, you can then load it into a Bar Chart using the following method:

    //Load the bar chart with a premade XML file in your app's bundle
    [barChart setXmlData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"barChart" ofType:@"xml"]] showAxis:DisplayBothAxes withColor:[UIColor whiteColor] shouldPlotVerticalLines:YES];

Note that you must give the XML File as an `NSData` object, not a file or file path.

##Customizing Bar Chart
Customizing Bar Chart is easy. Bar Chart has three different types that allow for customization of the Bar Graph's Bars. More ways to customize Bar Chart are coming soon.

###Bar Display Style
Changes the visual appearance of the bars on the Bar Chart. There are three different styles available:  
  * **BarStyleGlossy**: Adds a glossy shine and shades the bars. This is the default value if no value is set.   
  * **BarStyleMatte**: Bars have shading but no gloss effects.  
  * **BarStyleFlat**: Bars no no effects and are a solid flat color.  

You can set the Bar Style using the following method. You should always call this method before you update or load your Bar Chart:

    //Set the Style of the Bars (Glossy, Matte, or Flat) - Glossy is default
    [barChart setupBarViewStyle:BarStyleGlossy];
    
###Bar Shape
Changes the shape of the bars on the Bar Chart. There are two different styles available:  
  * **BarShapeRounded**: Rounds the corners of the bars at the top. This is the default value if no value is set.   
  * **BarShapeSquared**: Bars are not rounded - they are rectangles.    

You can set the Bar Shape using the following method. You should always call this method before you update or load your Bar Chart:

    //Set the Shape of the Bars (Rounded or Squared) - Rounded is default
    [barChart setupBarViewShape:BarShapeRounded];

###Bar Shadow
Changes the visual appearance of the shadow behind the bars on the Bar Chart. There are three different shadow styles available:  
  * **BarShadowLight**: Bars have a light gray shadow with a slight blur and low opacity. This is the default value if no value is set.   
  * **BarShadowHeavy**: Bars have a dark and (relative compared to the light shadow) defined shadow.  
  * **BarShadowNone**: No QuartzCore Shadow is added to the bars - they lie flat against the Bar Chart.  

You can set the Bar Style using the following method. You should always call this method before you update or load your Bar Chart:

    //Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
    [barChart setupBarViewShadow:BarShadowLight];

###Bar Animation
Changes the presentation animation of the bars on the Bar Chart. There are three different animation styles available (more coming soon):  
  * **BarAnimationRise**: Bars will "rise" or grow up from the bottom of the chart to their specified height and value while fading in. This is the default value if no value is set.   
  * **BarAnimationFade**: Bars will fade-in simultaneously when presented.  
  * **BarAnimationNone**: Bars suddenly appear without any animation.  

You can set the Bar Style using the following method. You should always call this method before you update or load your Bar Chart:

    //Set the Initial Animation of the Bars (Rise, Fade, or None) - Rise is default
    [barChart setupBarViewAnimation:BarAnimationRise];

##Compatibility Requirements
Before using Bar Chart, make sure your project meets its requirements.  
 - Bar Chart works on iOS 4.2 and higher, however the sample project only runs on iOS 5.0 and higher.  
 - Bar Chart now uses Objective-C ARC. If your project does not use ARC, add the ARC flag to the **Bar Chart** files in your project's Compile Sources section: `-fobjc-arc`  
 - You must add the `CoreGraphics` and `QuartzCore` frameworks to your project   

##To-Do
Bar Chart is a work in progress. We're planning to add these features soon:    
- [x] Re-add animations to Bar Chart  
- [x] Add ways to customize Bar Chart  
- [ ] Add styling options to popup tips    
- [ ] Add more animations, custom animations    
- [ ] Add ability to plot negative values to Bar Chart  

##Changelog

<table>
<tr><th colspan="2" style="text-align:center;"><b>Version 4.0</b></th></tr>
  <tr>
    <td>New animations and methods allow for deeper customization of BarChart. Many warnings and issues have been fixed, including the absence of animation. BarChart is compatible with iOS 7 and can now be used in your iOS 7-ready apps.
    <ul>
   		<li>BarChart now animates bar data using two beautiful animations that you can choose from using the new <tt>setupBarViewAnimation</tt> method. Three new constants are available to set the animation type (fade, rise, or none). If you do not set an animation, the default rise animation will be used in combination with the fade.</li>
   		<li>The BarChart background color is now clear instead of grey. This allows for easy customization of backgrounds.</li>
   		<li>The sample app now allows for changes to the bar graph in real-time in the UI.</li>
   		<li>Fixed issues with text aligment and line wrapping</li>
   		<li>Tested and compatible with iOS 7</li>
   		<li>Updated project settings to recommended Xcode settings. Now architecture is automatically selected, enabled warnings.</li>
	</ul>
  </td>
  </tr>
  <tr><th colspan="2" style="text-align:center;"><b>Version 3.0</b></th></tr>
  <tr>
    <td>Setup a Bar Chart using only Storyboards / XIBs. Load data into a Bar Chart using an NSArray. Customize the visual appearance of a Bar Chart.
    <ul>
   		<li>Bar Charts can be added directly from the interface instead of through code. Just add a <tt>UIView</tt> to your View Controller and change its class to <tt>BarChartView</tt>. Then set it up in your implementation. Take a look at the improved sample project for more information.</li>
   		<li>Load data into a Bar Chart using an <tt>NSArray</tt> rather than an XML File. Use the new method to format and generate data for use with a Bar Chart: <tt>[createChartDataWithTitles: values: colors: labelColors:]</tt>. Refer to the new documentation for more information.</li>
   		<li>Less formatting is required for XML data loading. Use <tt>[dataWithContentsOfFile: values: colors: labelColors:]</tt> to set Bar Chart properties (rather than doing so in your XML file). Refer to the new documentation for more information.</li>
   		<li>Set which axis to display using the <tt>AxisDisplaySettings</tt> type. You can set this property when loading data into your Bar Chart</li>
   		<li>Added new methods and types to change the visual appearance of the Bar Chart</li>
   		<li>Fixed bugs and memory leaks</li>
   		<li>Code cleanup and reorganization to make it easier on the eyes.</li>
	</ul>
  </td>
  </tr>
  <tr><th colspan="2" style="text-align:center;"><b>Version 2.0</b></th></tr>
  <tr>
    <td>This update makes large improvements to the performance of code by converting the project to Objective-C ARC.  </br> 
    <ul>
   <li>Converted project to ARC. If your project does not use ARC, add the ARC flag to the <b>Bar Chart</b> files in your project's Compile Sources section: <tt>-fobjc-arc</tt>.</li>
    <li>Improved the demo app. The demo app now runs on iPhone 5 and iOS 5 or higher. It also begins the transition to a more interface based Bar Chart integration system.</li>
    <li>Code cleanup and reorganization to make it easier on the eyes.</li>
    <li>Project now compiles with ARMV7 and ARMV7S instead of ARMV6</li>
    </ul>
    </td>
  </tr>
<tr><th colspan="2" style="text-align:center;"><b>Version 1.0</b></th></tr>
  <tr>
    <td>Initial Commit. View <a href="https://github.com/iRareMedia/BarChart/commits/master">commit history.</a></td>
  </tr>
</table>

##License
Copyright © 2012 Mezrin Kirill. Updated by iRare Media, some portions Copyright © 2013 iRare Media.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

<span style="font-variant: small-caps">THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</span>