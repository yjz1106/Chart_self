//
//  AppDelegate.h
//  Chart
//
//  Created by usus on 4/12/16.
//  Copyright (c) 2016 usus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZMCChartView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,ZMCChartViewDataSource, ZMCChartViewDelegate >

@property (weak) IBOutlet NSView *myView;

@end

