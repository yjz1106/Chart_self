//
//  ZMCBarChartView.h
//  
//
//  Created by usus on 4/12/16.
//
//

#import <Cocoa/Cocoa.h>

@interface ZMCBarChartView : NSView{
    
    NSArray *barColors;
    NSArray *columnNames;
    NSArray *data;
    NSInteger dataType;
    
    NSMutableArray *points;
}

@property(strong, nonatomic) NSArray *barColors;
@property(strong, nonatomic) NSArray *columnNames;
@property(strong, nonatomic) NSArray *data;
@property(nonatomic) NSInteger dataType;

-(void)startLoadingData;

@end
