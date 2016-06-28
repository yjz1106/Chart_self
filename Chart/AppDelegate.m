//
//  AppDelegate.m
//  Chart
//
//  Created by usus on 4/12/16.
//  Copyright (c) 2016 usus. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

@synthesize myView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    ZMCChartView *chart = [[ZMCChartView alloc] initWithFrame:CGRectMake(0, 0, 320, 300) withChartViewType:kZMCBarChartView];
    chart.dataSource = self;
    NSLog(@"ddd");
    [self.myView addSubview:chart];
    [chart startLoadingData];
    NSLog(@"ddd");
}

- (NSInteger)dataTypeInChartView:(ZMCChartView *)chartView
{
    if (chartView.chartViewType != kZMCPieChartView) {
        return 2;
    }
    return 1;
}

- (NSArray *)columnNamesInChartView:(ZMCChartView *)chartView
{
    return [NSArray arrayWithObjects:@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", nil];
}

- (NSArray *)dataInChartView:(ZMCChartView *)chartView
{
    if (chartView.chartViewType != kZMCPieChartView) {
        return [NSArray arrayWithObjects:
                [NSArray arrayWithObjects:@"100", @"30", @"201", @"22", @"10", @"300", nil],
                [NSArray arrayWithObjects:@"200", @"10", @"101", @"52", @"10", @"100", nil],
                nil];
    }
    return [NSArray arrayWithObjects:@"100", @"30", @"201", @"22", @"10", @"300", nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
