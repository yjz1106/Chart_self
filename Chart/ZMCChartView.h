//
//  ZMCChartView.h
//  
//
//  Created by usus on 4/12/16.
//
//

#import <Cocoa/Cocoa.h>
#import "ZMCBarChartView.h"

typedef NS_ENUM(NSInteger,ZMCChartViewType){
    
    kZMCBarChartView = 0,
    kZMCLineChartView,
    kZMCPieChartView
};

@protocol ZMCChartViewDelegate;
@protocol ZMCChartViewDataSource;

@interface ZMCChartView : NSView{
    
    NSArray *columnNames;
    NSArray *data;
    NSInteger dataType;
    NSArray *chartColor;
    id charView;
}

@property(assign, nonatomic) ZMCChartViewType chartViewType;
@property(strong, nonatomic) id<ZMCChartViewDelegate> delegate;
@property(strong, nonatomic) id<ZMCChartViewDataSource> dataSource;

-(id)initWithFrame:(CGRect)frame withChartViewType:(ZMCChartViewType)type;
-(void)startLoadingData;

@end

@protocol ZMCChartViewDelegate <NSObject>

@optional
-(NSArray *)columnColor:(ZMCChartView *)chartView;

@end

@protocol ZMCChartViewDataSource <NSObject>

@required
-(NSArray *)columnNamesInChartView:(ZMCChartView *)chartView;
-(NSArray *)dataInChartView:(ZMCChartView *)chartView;

@optional
-(NSInteger)dataTypeInChartView:(ZMCChartView *)chartView;

@end
