//
//  ZMCBarChartView.m
//  
//
//  Created by usus on 4/12/16.
//
//

#import "ZMCBarChartView.h"
#import <QuartzCore/CALayer.h>

#define kZMCCoordinateXHeight 260
#define kZMCCoordinateYHeight 200
#define kZMCCoordinateSignWidth 4
#define kZMCCoordinateOrigin CGPointMake(40,240)

@implementation ZMCBarChartView

-(id)initWithFrame:(NSRect)frameRect{
    
    self = [super initWithFrame:frameRect];
    if (self) {
        self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    }
    
    return self;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
}

-(void)drawBarCoordinate:(CGPoint)point{
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    
    //画X轴和Y轴
    CGContextSetStrokeColorWithColor(context, [NSColor blackColor].CGColor);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x, point.y - kZMCCoordinateYHeight);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x + kZMCCoordinateXHeight, point.y);
    
    //画y轴的箭头
    CGContextSetFillColorWithColor(context, [NSColor blackColor].CGColor);
    CGContextMoveToPoint(context, point.x, point.y - kZMCCoordinateYHeight);
    CGContextAddLineToPoint(context, point.x - 4, point.y - kZMCCoordinateYHeight + 6);
    CGContextAddLineToPoint(context, point.x, point.y - kZMCCoordinateYHeight - 8);
    CGContextAddLineToPoint(context, point.x + 4, point.y - kZMCCoordinateYHeight +6);
    CGContextAddLineToPoint(context, point.x, point.y - kZMCCoordinateYHeight);
    CGContextFillPath(context);
    //画Y轴显示的标志
    CGContextSetStrokeColorWithColor(context, [NSColor blackColor].CGColor);
    CGContextSetLineWidth(context, 0.4);
    //间距
    CGFloat distance = kZMCCoordinateYHeight/6;
    for (int i = 1; i < 6; i ++) {
        CGContextMoveToPoint(context, point.x, point.y - distance * i);
        CGContextAddLineToPoint(context, point.x + kZMCCoordinateYHeight, point.y - distance * i );
    }
    CGContextStrokePath(context);
    
    //画X轴的箭头
    CGContextSetFillColorWithColor(context, [NSColor blackColor].CGColor);
    CGContextMoveToPoint(context, point.x + kZMCCoordinateSignWidth, point.y);
    CGContextAddLineToPoint(context, point.x + kZMCCoordinateXHeight - 6 , point.y - 4);
    CGContextAddLineToPoint(context, point.x + kZMCCoordinateXHeight + 8 , point.y);
    CGContextAddLineToPoint(context, point.x + kZMCCoordinateXHeight - 6, point.y + 4);
    CGContextFillPath(context);
    
}

//加载数据
-(void)startLoadingData{
    
    CGFloat distanceX = kZMCCoordinateXHeight/self.columnNames.count;
    NSInteger maxYValue = [self maximumYvalue:self.data];
    CGFloat YValue = maxYValue/(5.0 * kZMCCoordinateXHeight / 6.0);
    
    points = [[NSMutableArray alloc] initWithCapacity: self.dataType];
    
    //贝塞尔曲线
    for (int j = 0; j < self.dataType; j++) {
        NSArray *array = [self.data objectAtIndex:j];
        NSMutableArray *endPoints = [[NSMutableArray alloc] initWithCapacity:self.columnNames.count];
        for (int i = 0; i < self.columnNames.count; i++) {
            NSBezierPath *bezierPath = [NSBezierPath bezierPath];
            //计算路径开始点
            CGPoint startPoint = CGPointMake(kZMCCoordinateOrigin.x + distanceX * i + 10 + (2 * j + 1) * (distanceX - 15)/(2 * self.dataType), kZMCCoordinateOrigin.y - 0.5);
            float dataValue = [[array objectAtIndex:i] floatValue];
            CGPoint endPoint = CGPointMake(startPoint.x, kZMCCoordinateOrigin.y - dataValue/YValue + 1);
            [endPoints addObject:[NSValue valueWithPoint:endPoint]];
            bezierPath.lineWidth = (distanceX - 15)/self.dataType;
            [bezierPath moveToPoint:startPoint];
            [bezierPath lineToPoint:endPoint];
            //定义layer
//            CAShapeLayer *shaperLayer = [[CAShapeLayer alloc] init];
//            shaperLayer.path = bezierPath.CGPath;
//            shaperLayer.strokeColor = (NSColor *)[[barColors objectAtIndex:j].CGColor];
//            shaperLayer.lineWidth = bezierPath.lineWidth;
//            shaperLayer.lineCap = kCALineCapButt;
//            shaperLayer.strokeEnd = 0.0f;
//            [self.layer addSublayer:shaperLayer];
            
            // 动画
//            CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//            basicAnimation.duration = 1.0f;
//            basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//            basicAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//            basicAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//            [shaperLayer addAnimation:basicAnimation forKey:@"strokeEndAnimation"];
            //shaperLayer.strokeEnd = 1.0f;
        }
        
        [points addObject:endPoints];
    }
    
}
//求最大的数
-(float)maximumYvalue:(NSArray *)array{
    
    float max = 0;
    for (NSArray *a in array) {
        for (NSString *str in a) {
            float a = [str floatValue];
            if (a > max) {
                max = a;
            }
        }
    }
    if (max <= 10) {
        max = 10;
    }else{
        max = ((int)max)/100 * 100 + 100;
    }
    
    return max;
}

@end
