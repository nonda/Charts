//
//  CubicLineChartViewController.m
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

#import "CubicLineChartViewController.h"
#import "ChartsDemo-Swift.h"

@interface CubicLineSampleFillFormatter : NSObject <IChartFillFormatter>
{
}
@end

@implementation CubicLineSampleFillFormatter

- (CGFloat)getFillLinePositionWithDataSet:(LineChartDataSet *)dataSet dataProvider:(id<LineChartDataProvider>)dataProvider
{
    return -10.f;
}

@end

@interface CubicLineChartViewController () <ChartViewDelegate>

@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property (nonatomic, strong) IBOutlet UISlider *sliderX;
@property (nonatomic, strong) IBOutlet UISlider *sliderY;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextX;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextY;

@end

@implementation CubicLineChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Cubic Line Chart";
    
    self.options = @[
                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
                     @{@"key": @"toggleFilled", @"label": @"Toggle Filled"},
                     @{@"key": @"toggleCircles", @"label": @"Toggle Circles"},
                     @{@"key": @"toggleCubic", @"label": @"Toggle Cubic"},
                     @{@"key": @"toggleHorizontalCubic", @"label": @"Toggle Horizontal Cubic"},
                     @{@"key": @"toggleStepped", @"label": @"Toggle Stepped"},
                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
                     @{@"key": @"animateX", @"label": @"Animate X"},
                     @{@"key": @"animateY", @"label": @"Animate Y"},
                     @{@"key": @"animateXY", @"label": @"Animate XY"},
                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
                     @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
                     @{@"key": @"toggleData", @"label": @"Toggle Data"},
                     ];
    
    _chartView.delegate = self;
    
    [_chartView setViewPortOffsetsWithLeft:0.f top:20.f right:0.f bottom:0.f];
    _chartView.backgroundColor = [UIColor colorWithRed:0.07 green:0.09 blue:0.16 alpha:1.00];

    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.maxHighlightDistance = 300.0;

    _chartView.xAxis.enabled = NO;
    
    ChartYAxis *yAxis = _chartView.leftAxis;
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    [yAxis setLabelCount:6 force:NO];
    yAxis.labelTextColor = UIColor.whiteColor;
    yAxis.labelPosition = YAxisLabelPositionInsideChart;
    yAxis.drawGridLinesEnabled = NO;
    yAxis.axisLineColor = UIColor.whiteColor;
    
    _chartView.rightAxis.enabled = NO;
    _chartView.legend.enabled = NO;

    ChartLimitLine *line = [[ChartLimitLine alloc] initWithLimit:50 label: @"Recommended\n50.0 PSI"];

    line.lineDashLengths = @[@1, @3];
    line.lineColor = [UIColor colorWithRed:0.56 green:0.98 blue:0.76 alpha:1.00];
    line.lineWidth = 1.0;
    line.labelPosition = ChartLimitLabelPositionLeftTop;
    line.valueTextColor = [UIColor colorWithRed:0.56 green:0.98 blue:0.76 alpha:1.00];
    [_chartView.leftAxis addLimitLine:line];

    ChartLimitLine *line1 = [[ChartLimitLine alloc] initWithLimit:70 label: @"70.0 PSI"];

    line1.lineDashLengths = @[@1, @3];
    line1.lineColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    line1.lineWidth = 1.0;
    line1.labelPosition = ChartLimitLabelPositionLeftTop;
    line1.valueTextColor = [UIColor colorWithRed:0.56 green:0.98 blue:0.76 alpha:1.00];
    [_chartView.leftAxis addLimitLine:line1];

    ChartLimitLine *line2 = [[ChartLimitLine alloc] initWithLimit:30 label: @"30.0 PSI"];

    line2.lineDashLengths = @[@1, @3];
    line2.lineColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    line2.lineWidth = 1.0;
    line2.labelPosition = ChartLimitLabelPositionLeftTop;
    line2.valueTextColor = [UIColor colorWithRed:0.56 green:0.98 blue:0.76 alpha:1.00];
    [_chartView.leftAxis addLimitLine:line2];

    ChartLimitLine *line3 = [[ChartLimitLine alloc] initWithLimit:70 label: @"82°F"];

    line3.lineDashLengths = @[@1, @3];
    line3.lineColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    line3.lineWidth = 1.0;
    line3.labelPosition = ChartLimitLabelPositionRightTop;
    line3.valueTextColor = [UIColor colorWithRed:0.23 green:0.43 blue:0.81 alpha:1.00];
    [_chartView.leftAxis addLimitLine:line3];

    ChartLimitLine *line4 = [[ChartLimitLine alloc] initWithLimit:30 label: @"68°F"];

    line4.lineDashLengths = @[@1, @3];
    line4.lineColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    line4.lineWidth = 1.0;
    line4.labelPosition = ChartLimitLabelPositionRightTop;
    line4.valueTextColor = [UIColor colorWithRed:0.23 green:0.43 blue:0.81 alpha:1.00];
    [_chartView.leftAxis addLimitLine:line4];

    _chartView.leftAxis.enabled = YES;

    _chartView.leftAxis.drawLabelsEnabled = NO;
    
    _sliderX.value = 45.0;
    _sliderY.value = 100.0;
    [self slidersValueChanged:nil];
    
//    [_chartView animateWithXAxisDuration:2.0 yAxisDuration:2.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateChartData
{
    if (self.shouldHideData)
    {
        _chartView.data = nil;
        return;
    }
    
    [self setDataCount:_sliderX.value + 1 range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 100; i++)
    {
        double mult = 50;
        double val = (double) (arc4random_uniform(mult)) + 20;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];

        double val2 = (double) (arc4random_uniform(mult)) + 20;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y: val2]];

        if (i % 7 == 0) {
            double val3 = (double) (arc4random_uniform(mult)) + 20;
            [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:val3 data:@"1:00-2:00"]];

            double val4 = (double) (arc4random_uniform(mult)) + 20;
            [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y: val4]];
        }
    }
    
    LineChartDataSet *set1 = nil;

    set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"DataSet 1"];
    set1.mode = LineChartModeCubicBezier;
    set1.cubicIntensity = 0.2;
    set1.drawCirclesEnabled = NO;
    set1.drawFilledEnabled = NO;
    set1.lineWidth = 1.8;
    set1.circleRadius = 4.0;
    [set1 setCircleColor: [UIColor colorWithRed:0.56 green:0.98 blue:0.76 alpha:1.00]];
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    [set1 setColor:[UIColor colorWithRed:0.56 green:0.98 blue:0.76 alpha:1.00]];

    NSArray *gradientColors = @[
                                (id)[UIColor clearColor].CGColor,
                                (id)[ChartColorTemplates colorFromString:@"#90FAC2"].CGColor
                                ];
    CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);

    set1.fillAlpha = 0.3f;
    set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
    set1.drawFilledEnabled = YES;

    CGGradientRelease(gradient);

    set1.drawHorizontalHighlightIndicatorEnabled = NO;

    LineChartDataSet *set2 = nil;

    set2 = [[LineChartDataSet alloc] initWithValues:yVals2 label:@"DataSet 2"];
    set2.mode = LineChartModeCubicBezier;
    set2.cubicIntensity = 0.2;
    set2.drawCirclesEnabled = NO;
    set2.drawFilledEnabled = NO;
    set2.lineWidth = 1.8;
    set2.circleRadius = 4.0;
    [set2 setCircleColor:UIColor.blueColor];
    set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    [set2 setColor: [UIColor colorWithRed:0.23 green:0.43 blue:0.81 alpha:1.00]];

    NSArray *gradientColors2 = @[
                                (id)[UIColor clearColor].CGColor,
                                (id)[ChartColorTemplates colorFromString:@"#3B6DCF"].CGColor
                                ];
    CGGradientRef gradient2 = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors2, nil);

    set2.fillAlpha = 0.3f;
    set2.fill = [ChartFill fillWithLinearGradient:gradient2 angle:90.f];
    set2.drawFilledEnabled = YES;

    CGGradientRelease(gradient2);

    set2.drawHorizontalHighlightIndicatorEnabled = NO;

    LineChartData *data = [[LineChartData alloc] initWithDataSets:@[set1, set2]];

    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.f]];
    [data setDrawValues:NO];
    
    _chartView.data = data;
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleFilled"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawFilledEnabled = !set.isDrawFilledEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCircles"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawCirclesEnabled = !set.isDrawCirclesEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeCubicBezier ? LineChartModeLinear : LineChartModeCubicBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleStepped"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeStepped ? LineChartModeLinear : LineChartModeStepped;
        }
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleHorizontalCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeCubicBezier ? LineChartModeHorizontalBezier : LineChartModeCubicBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    [super handleOption:key forChartView:_chartView];
}

#pragma mark - Actions

- (IBAction)slidersValueChanged:(id)sender
{
    _sliderTextX.text = [@((int)_sliderX.value) stringValue];
    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
    
    [self updateChartData];
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
