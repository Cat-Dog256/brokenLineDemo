//
//  LCBrokenLineView.m
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/18.
//  Copyright © 2016年 MoGo. All rights reserved.
//
#import "LCWeekTemModel.h"
#import "LCBrokenLineView.h"
#import "LCHandleView.h"
#import "LCHandleModel.h"
#import <CoreText/CoreText.h>
#import "UIView+Extension.h"
@interface LCBrokenLineView ()

@property (nonatomic , copy) void(^submitDataBlock)(NSDictionary *submitDict);
/**
 *  温度节点对象数组
 */
@property (nonatomic , strong) NSMutableArray *pointArray;
/**
 *  折线层
 */
@property (nonatomic , strong) CAShapeLayer *brokenLineLayer;
/**
 *  折线的图形上下文
 */
@property (nonatomic , assign) CGContextRef brokenLineCtx;
/**
 *  坐标的颜色
 */
@property (nonatomic , strong) UIColor *coordinateColor;

/**
 *  纵坐标刻度
 */
@property (nonatomic , assign) CGFloat ordinateScale;
/**
 *  横坐标刻度
 */
@property (nonatomic , assign) CGFloat abscissaScale;

/**
 *  坐标的Frame
 */
@property (nonatomic , assign) CGRect coordinateRect;
/**
 *  时间点
 */
@property (nonatomic , copy) NSString *timeValueString;
/**
 *  用于给handleModel赋值Hour
 */
@property (nonatomic , strong) NSNumber *HourValue;
/**
 *  用于给handleModel赋值Min
 */
@property (nonatomic , strong) NSNumber *MinValue;
/**
 *  温度点
 */
@property (nonatomic , copy) NSString *temperatureValueString;
/**
 *  用于给handleModel赋值Temperature
 */
@property (nonatomic , strong) NSNumber *tempValue;
/**
 *  显示温度与时间
 */
@property (nonatomic , strong) UILabel *showTextLabel;


@property (nonatomic , strong) UIButton *canAddButton;
@property (nonatomic , strong) UIView *noAddLine;
/**
 *  添加温度节点
 */
@property (nonatomic , assign) BOOL canAddPoint;
@property (nonatomic , strong) UIView *noRemoveLine;
@property (nonatomic , strong) UIButton *canRemoveButton;
/**
 *  删除温度节点
 */
@property (nonatomic , assign) BOOL canRemovePoint;


@property (nonatomic , assign) BOOL pointChange;
@end

@implementation LCBrokenLineView
- (void)setTimeAndTemperatureValue:(NSArray *)timeAndTemperatureValue{
    _timeAndTemperatureValue = timeAndTemperatureValue;
    for (LCWeekTemModel *model in _timeAndTemperatureValue) {
        
        //服务器把温度设置为零的点不显示
        if ([model.Temprature isEqualToString:@"0.0"]) continue;
        
     CGFloat pointY = self.frame.size.height - 80 -([model.Temprature doubleValue] - 5.0) * _ordinateScale * 2;
    CGFloat pointX = 30 + [model.Hour doubleValue] * _abscissaScale * 2;
        LCHandleModel *object = [[LCHandleModel alloc]init];
        object.center_Point = CGPointMake(pointX, pointY);
        LCHandleView *handleView = [[LCHandleView alloc]init];

        handleView.DisplayMode = self.DisplayMode;
#pragma mark**给手柄传递文字**
        handleView.handleText = [NSString stringWithFormat:@"%@°", model.Temprature];
        handleView.timestring = model.timeValue;
        handleView.center = CGPointMake(pointX, pointY);;

//        CGFloat handle_X = handleView.frame.origin.x - handleView.frame.size.width/2;
//        CGFloat handle_Y = handleView.frame.origin.y - handleView.frame.size.width / 2;
//        CGFloat handle_WH = handleView.frame.size.width * 2;
//        object.handle_Frame = CGRectMake(handle_X , handle_Y, handle_WH, handle_WH);
        object.handleView = handleView;
        
        
        object.Hour = [NSNumber numberWithInt:[model.Hour intValue]];
        object.Min = [NSNumber numberWithInt:[model.Min intValue]];
        object.Temprature = [NSNumber numberWithDouble:([model.Temprature doubleValue] * 90)];
        [self addSubview:handleView];
        [self.pointArray addObject:object];
    }
    [self drawBrokenLineLayer];
}
- (instancetype)init{
    if (self = [super init]) {
        [self drawBackgroundLayer];
    }
    return self;
}
- (CGContextRef)brokenLineCtx{
    if (!_brokenLineCtx) {
        _brokenLineCtx = UIGraphicsGetCurrentContext();
    }
    return _brokenLineCtx;
}
- (CAShapeLayer *)brokenLineLayer{
    if (!_brokenLineLayer) {
        _brokenLineLayer = [[CAShapeLayer alloc]init];
        _brokenLineLayer.backgroundColor = [UIColor clearColor].CGColor;
        _brokenLineLayer.strokeColor = [UIColor grayColor].CGColor;
        _brokenLineLayer.fillColor = [UIColor clearColor].CGColor;
        
    }
    return _brokenLineLayer;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
      
        _ordinateScale = (frame.size.height - 80 - 40)/54;
        _abscissaScale = (frame.size.width - 60)/48;
        _coordinateColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        _coordinateRect = CGRectMake(30 - 15, 40 - 15 ,_abscissaScale * 48 + 30 , frame.size.height - 80 - 40 + 30);
        [self drawBackgroundLayer];
        [self.layer addSublayer:self.brokenLineLayer];
        [self addAllButton];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
}
- (UILabel *)showTextLabel{
    if (!_showTextLabel) {
        
        CGFloat labelW = 150;
        CGFloat labelH = 30;
        CGFloat labelX = (self.frame.size.width - 150)/2;
        CGFloat labelY = 10;
        _showTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        _showTextLabel.backgroundColor = [UIColor clearColor];
        _showTextLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_showTextLabel];
    }
    return _showTextLabel;
}
- (NSMutableArray *)pointArray{
    if (!_pointArray) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}

/**
 *  绘制坐标层
 */
- (void)drawBackgroundLayer{
//    NSLog(@"%s",__func__);

    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = CGRectMake(0, 0,self.frame.size.width, self.frame.size.height - 60);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = _coordinateColor.CGColor;
    [self.layer addSublayer:layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    NSArray *array = @[@"5",
                      @"10",
                      @"15",
                      @"20",
                      @"25",
                      @"32"];
//    for (int i = 0;  i <= 54; i++) {
//        CGPoint pointStart =  CGPointMake(30, self.frame.size.height - 80 - (i) * _ordinateScale);
//        CGPoint pointEnd = CGPointMake(_abscissaScale * 48 + 30, self.frame.size.height - 80 - (i) * _ordinateScale);
//        [path moveToPoint:pointStart];
//        [path addLineToPoint:pointEnd];
//
//    }
    
    for (int i = 0; i <= 5; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = array[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        CGPoint pointStart =  CGPointMake(30, self.frame.size.height - 80 - i * 5 * 2 * _ordinateScale);
        CGPoint pointEnd = CGPointMake(_abscissaScale * 48 + 30, self.frame.size.height - 80 - i * 10 * _ordinateScale);
        if (i == 5) {
            pointStart.y = self.frame.size.height - 80 - (i * 10 * _ordinateScale + _ordinateScale * 4);
            pointEnd.y = pointStart.y;
        }
        
        label.textColor = _coordinateColor;
        label.frame = CGRectMake(pointStart.x - 20, pointStart.y - 10, 20, 20);
        [self addSubview:label];
        
        
        [path moveToPoint:pointStart];
        [path addLineToPoint:pointEnd];
    }
    
    
    
        for (int i = 0 ; i < 49; i++) {
        UIBezierPath * pathA = [UIBezierPath bezierPath];
        [pathA moveToPoint:CGPointMake(30 + _abscissaScale * i, self.frame.size.height - 80)];
        if (i % 2 != 0) {
            [pathA addLineToPoint:CGPointMake(30 + _abscissaScale * i, self.frame.size.height - 85)];
        }else{
            
            
            CGPoint textPoint = CGPointMake(30 + _abscissaScale * i, self.frame.size.height - 80);
            [pathA addLineToPoint:CGPointMake(30 + _abscissaScale * i, self.frame.size.height - 90)];
            
            
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:8];
            label.frame = CGRectMake(textPoint.x - 10, textPoint.y + 2,30, 20);
            label.textColor = _coordinateColor;

            label.textAlignment = NSTextAlignmentCenter;
            NSString *text = [NSString stringWithFormat:@"%d",i / 2];

            label.text = text;
            if (i == 0) {
                label.text = @"0:00";
                label.font = [UIFont systemFontOfSize:8];
            }else if (i == 48){
                label.text = @"24:00";
                label.font = [UIFont systemFontOfSize:8];
            }
            [self addSubview:label];
//            CATextLayer *textLayer = [[CATextLayer alloc]init];
//            //背景色
//            textLayer.backgroundColor = [UIColor redColor].CGColor;
//            //缩放比
//            textLayer.contentsScale = [UIScreen mainScreen].scale;
//            
//            //换行
//            textLayer.wrapped = YES;
//
//            textLayer.frame = CGRectMake(textPoint.x, textPoint.y + 2,30, 30);
//            
//            NSString *text = [NSString stringWithFormat:@"%d",i / 2];
//            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12] , NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
//            
//            /**
//             *  字体间距
//             */
//            long number = 0;
//            CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
//            [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
//            CFRelease(num);
//            
//            textLayer.string = attributedString;
//            [layer addSublayer:textLayer];
        }
        
        [path appendPath:pathA];
    }
    
//    UIView *VIEW = [[UIView alloc]initWithFrame:_coordinateRect];
//    VIEW.backgroundColor = [UIColor redColor];
//    VIEW.alpha = 0.3;
//    [self addSubview:VIEW];
    layer.path = path.CGPath;
}
- (void)addAllButton{
    CGFloat butX = 44;
    CGFloat butY = self.frame.size.height - 50;
    CGFloat butW = 80;
    CGFloat butH = 30;
    CGFloat space = 20;
    CGFloat butLastTwo = self.frame.size.width - butX - space - butW * 2;
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc]init];
        [self addSubview:button];

        button.backgroundColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = YES;
        if (i < 2) {
            button.frame = CGRectMake(butX + i * (butW + space), butY, butW, butH);
        }else{
            button.frame = CGRectMake(butLastTwo + (i-2) * (butW + space), butY, butW, butH);
        }
        
        if (i == 0) {
            self.canAddButton = button;
            UIView *line = [[UIView alloc]init];
            line.x = CGRectGetMinX(button.frame) + 5;
            line.centerY = butY + butH/2 - 1/2;
            line.height = 1;
            line.width = butW - 10;
            line.backgroundColor = [UIColor redColor];
            line.hidden = YES;
            
            line.hidden = YES;
            self.noAddLine = line;
            [self addSubview:line];
            
            
            [button setTitle:@"Add" forState:UIControlStateNormal];
            [button setTitle:@"Fisish" forState:UIControlStateSelected];
        }else if (i == 1){
            self.canRemoveButton = button;
           
            [button setTitle:@"Remove" forState:UIControlStateNormal];
            [button setTitle:@"Fisish" forState:UIControlStateSelected];
            UIView *line = [[UIView alloc]init];
            line.x = CGRectGetMinX(button.frame) + 5;
            line.centerY = butY + butH/2 - 1/2;
            line.height = 1;
            line.width = butW - 10;
            line.backgroundColor = [UIColor redColor];
            line.hidden = YES;
            self.noRemoveLine = line;
            [self addSubview:line];

        }else if (i == 2){
            [button setTitle:@"Done" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        }else{
            [button setTitle:@"Copy" forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:@"lan_icon_copyto"] forState:UIControlStateNormal];
        }
        
        button.tag = i + 100;
        
        [button addTarget:self action:@selector(pressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark**按钮点击**
- (void)pressButtonAction:(UIButton *)button{
    
    if(button.tag == 100){
        if (self.pointArray.count == 13) {
            return;
        }
        
        _canAddPoint = !_canAddPoint;
        UIButton *removeButton = (UIButton *)[self viewWithTag:101];
        removeButton.selected = NO;
        self.canRemovePoint = NO;
    }else if (button.tag == 101){
        if (self.pointArray.count == 0) {
            return;
        }

        self.canRemovePoint = !self.canRemovePoint;
        UIButton *addButton = (UIButton *)[self viewWithTag:100];
        addButton.selected = NO;
        self.canAddPoint = NO;
    }else if(button.tag == 102){
        UIButton *removeButton = (UIButton *)[self viewWithTag:101];
        removeButton.selected = NO;
        self.canRemovePoint = NO;
        UIButton *addButton = (UIButton *)[self viewWithTag:100];
        addButton.selected = NO;
        self.canAddPoint = NO;

        /**
         {
         "ProgramTime": [
         {
         "Hour": 0,
         "Min": 0,
         "Temprature": 0
         }
         ]
         }
         */
        
        
        if (self.pointChange == NO) {
            NSLog(@"No Change");
            return;
        }
        NSMutableArray *ProgramTime = [NSMutableArray array];
        for (LCHandleModel *model in self.pointArray) {
            NSMutableDictionary *bodyDict = [NSMutableDictionary dictionary];
            bodyDict[@"Hour"] = model.Hour;
            bodyDict[@"Min"] = model.Min;
            bodyDict[@"Temprature"] = model.Temprature;
            [ProgramTime addObject:bodyDict];

        }
        NSDictionary *firstDict = [ProgramTime firstObject];

        NSDictionary *lastDict = [ProgramTime lastObject];
        if (![firstDict[@"Hour"] isEqualToNumber:@0]) {
            NSLog(@"The first point is must at 00:00");
            return;
        }
        if (![lastDict[@"Hour"] isEqualToNumber:@24]) {
            NSLog(@"The end point is must at 24:00");
            return;
        }

        NSMutableDictionary *submitDict = [NSMutableDictionary dictionary];
        submitDict[@"weekday"] = self.weekday;
        submitDict[@"ProgramTime"] = @{@"ProgramTime":ProgramTime};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"oneDaySchedule" object:submitDict];
    }else if(button.tag == 103){
        UIButton *removeButton = (UIButton *)[self viewWithTag:101];
        removeButton.selected = NO;
        self.canRemovePoint = NO;
        UIButton *addButton = (UIButton *)[self viewWithTag:100];
        addButton.selected = NO;
        self.canAddPoint = NO;
        NSMutableArray *ProgramTime = [NSMutableArray array];
        for (LCHandleModel *model in self.pointArray) {
            NSMutableDictionary *bodyDict = [NSMutableDictionary dictionary];
            bodyDict[@"Hour"] = model.Hour;
            bodyDict[@"Min"] = model.Min;
            bodyDict[@"Temprature"] = model.Temprature;
            [ProgramTime addObject:bodyDict];
            
        }
        
        NSMutableDictionary *submitDict = [NSMutableDictionary dictionary];
        submitDict[@"weekday"] = self.weekday;
        submitDict[@"ProgramTime"] = @{@"ProgramTime":ProgramTime};

        [[NSNotificationCenter defaultCenter]postNotificationName:@"copyToAction" object:submitDict];
    }
    button.selected = !button.selected;

}

- (void)setCanRemovePoint:(BOOL)canRemovePoint{
    _canRemovePoint = canRemovePoint;
    if (_canRemovePoint) {
        for (LCHandleModel *object in self.pointArray) {
            object.handleView.canRemove = YES;
            [object.handleView setNeedsDisplay];
        }
    }else{
        for (LCHandleModel *object in self.pointArray) {
            object.handleView.canRemove = NO;
            [object.handleView setNeedsDisplay];
        }
    }
}
- (void)drawBrokenLineLayer{
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0 ; i < self.pointArray.count ; i ++) {
        LCHandleModel *object = self.pointArray[i];
        
        if (i == 0) {
            
            if (self.pointArray.count > 1) {
                
            }
            [path moveToPoint:object.center_Point];
        }else if(self.pointArray.count == 2){
            [path addLineToPoint:object.center_Point];
        }else if(self.pointArray.count > 0){
//            LCHandleModel *object_above = self.pointArray[1 + i];
            LCHandleModel *object_blow = self.pointArray[i - 1];

            if (object.center_Point.x - object_blow.center_Point.x < _abscissaScale/2) {
                [path addLineToPoint:object.center_Point];
            }else{
            CGPoint onePoint = CGPointMake(object.center_Point.x - _abscissaScale, object_blow.center_Point.y);
                
                if (onePoint.x - object_blow.center_Point.x < _abscissaScale) {
                    onePoint.x = object_blow.center_Point.x;
                }
           
            CGPoint point_C = CGPointMake(onePoint.x - _abscissaScale/4,onePoint.y +  (object.center_Point.y - onePoint.y)/2);
            
            [path addLineToPoint:onePoint];
            [path addQuadCurveToPoint:object.center_Point controlPoint:point_C];
            
        }
        
        }
    }
    
    path.lineWidth = 2;
    
    // 设置线段样式
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    self.brokenLineLayer.path = path.CGPath;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    NSLog(@"%s",__func__);
    
    
    
    CGPoint point = [self makePointFromTouch:touches];
    if (self.canRemovePoint) {
        self.noAddLine.hidden = YES;
               //改变
        self.pointChange = YES;
        for (int i = 0 ; i < self.pointArray.count ; i ++) {
            LCHandleModel *object = self.pointArray[i];
            if (CGRectContainsPoint(object.handle_Frame, point) ) {
                [object.handleView removeFromSuperview];
                [self.pointArray removeObject:object];
                //绘制折线
                [self drawLayer:self.brokenLineLayer inContext:self.brokenLineCtx];
                if(self.pointArray.count == 0){
                    _canRemovePoint = NO;
                    self.noRemoveLine.hidden = NO;
                    self.canRemoveButton.selected = NO;
                }

                return;
            }
            
        }

    }
    if (!_canAddPoint) return;
    //改变
    self.pointChange = YES;
    

    if (!CGRectContainsPoint(_coordinateRect, point)) return;
    
    for (int i = 0 ; i < self.pointArray.count ; i ++) {
        LCHandleModel *object = self.pointArray[i];
        if (CGRectContainsPoint(object.handle_Frame, point) ) {
            return;
        }
        
    }
    
    LCHandleView *handleView = [[LCHandleView alloc]init];
    handleView.DisplayMode = self.DisplayMode;

    handleView.center = point;
#pragma mark**给手柄传递文字**
    handleView.handleText = _temperatureValueString;
    handleView.timestring = _timeValueString;
    [self addSubview:handleView];
    
    
    
    LCHandleModel *model = [[LCHandleModel alloc]init];
    model.center_Point = point;
//    CGFloat handle_X = handleView.frame.origin.x - handleView.frame.size.width/2;
//    CGFloat handle_Y = handleView.frame.origin.y - handleView.frame.size.width / 2;
//    CGFloat handle_WH = handleView.frame.size.width * 2;
//    model.handle_Frame = CGRectMake(handle_X , handle_Y, handle_WH, handle_WH);
    model.handleView = handleView;
    
    
#pragma mark**记录时间和温度**
    model.Hour = _HourValue;
    model.Min  = _MinValue;
    model.Temprature = _tempValue;
    [self.pointArray addObject:model];
    
    

    //排序
    for (int i = 0; i < self.pointArray.count; i ++) {
        LCHandleModel *object_I = self.pointArray[i];
        for (int j = i + 1 ; j < self.pointArray.count; j++) {
            LCHandleModel *object_J = self.pointArray[j];
            if (object_I.center_Point.x > object_J.center_Point.x) {
                [self.pointArray exchangeObjectAtIndex:j withObjectAtIndex:i];
            }
        }
    }
    //绘制折线
    [self drawLayer:self.brokenLineLayer inContext:self.brokenLineCtx];
    NSLog(@"%lu",(unsigned long)self.pointArray.count);
#pragma mark**最多可以有十三个点**
    self.noRemoveLine.hidden = YES;
    
    if (self.pointArray.count == 13) {
        _canAddPoint = NO;
        self.canAddButton.selected = NO;
        self.noAddLine.hidden = NO;
    }

}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self makePointFromTouch:touches];
    if (!CGRectContainsPoint(_coordinateRect, point)) return;
    //改变
    self.pointChange = YES;

    for (int i = 0 ; i < self.pointArray.count ; i ++) {
        
        
        
        LCHandleModel *object = self.pointArray[i];
       

        if (CGRectContainsPoint(object.handleView.frame, point) ) {
#pragma mark**处理scrollview的滚动**

            UIScrollView * sc = (UIScrollView*)self.superview;
            sc.scrollEnabled = NO;

            
            
            self.showTextLabel.hidden = NO;
            self.showTextLabel.alpha = 1.0;
            self.showTextLabel.text = [NSString stringWithFormat:@"%@  %@",_timeValueString , _temperatureValueString];
//                NSLog(@"%s",__func__);
            //触摸点在中间,移动范围在前后两点中间
            if (i > 0 && i < self.pointArray.count-1) {
                LCHandleModel *object_above = self.pointArray[1 + i];
                LCHandleModel *object_blow = self.pointArray[i - 1];
                
                if (point.x > object_above.center_Point.x) {
                    point.x = object_above.center_Point.x;
                    
                }
                if (point.x < object_blow.center_Point.x) {
                    point.x = object_blow.center_Point.x;
                }
               //触摸点是第一个点,移动范围不能大于下一个点
            }else if(i == 0 && self.pointArray.count > 1){
                LCHandleModel *object_above = self.pointArray[1 + i];
                
                if (point.x > object_above.center_Point.x) {
                    point.x = object_above.center_Point.x;
                    
                }
                //触摸点是最后一个点,移动范围不能小于前一个点
            }else if(i == self.pointArray.count - 1 && self.pointArray.count > 1){
                LCHandleModel *object_blow = self.pointArray[i - 1];
                
                if (point.x < object_blow.center_Point.x) {
                    point.x = object_blow.center_Point.x;
                }

            }
            //移动手柄的坐标
            object.handleView.center = point;
            object.center_Point = point;
//            CGFloat handle_X = object.handleView.frame.origin.x - object.handleView.frame.size.width/2;
//            CGFloat handle_Y = object.handleView.frame.origin.y - object.handleView.frame.size.width / 2;
//            CGFloat handle_WH = object.handleView.frame.size.width * 2;
//            object.handle_Frame = CGRectMake(handle_X , handle_Y, handle_WH, handle_WH);
#pragma mark**给手柄传递文字**

            object.handleView.handleText = _temperatureValueString;
            object.handleView.timestring = _timeValueString;
            [object.handleView setNeedsDisplay];
            
            
            
#pragma mark**记录时间和温度**
            object.Hour = _HourValue;
            object.Min  = _MinValue;
            object.Temprature = _tempValue;
            //重新绘制折线
            [self drawLayer:self.brokenLineLayer inContext:self.brokenLineCtx];
            return;
        }
        
    }
    

}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    NSLog(@"%s",__func__);

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
#pragma mark**处理scrollview的滚动**
    UIScrollView * sc = (UIScrollView*)self.superview;
    sc.scrollEnabled = YES;
    [UIView animateWithDuration:1.0 animations:^{
        _showTextLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        _showTextLabel.hidden = YES;
    }];
//    NSLog(@"%s",__func__);

}
#pragma mark **计算触摸点**
- (CGPoint)makePointFromTouch:(NSSet<UITouch *> *)touches{
    //触摸对象
    UITouch *touch = [touches anyObject];
    //触摸点
    CGPoint pointTouch = [touch locationInView:self];
    if (pointTouch.y < 40) {
        pointTouch.y = 40;
    }else if(pointTouch.y > self.frame.size.height - 80){
        pointTouch.y = self.frame.size.height - 80;
    };
    if (pointTouch.x < 30) {
        pointTouch.x = 30;
    }else if (pointTouch.x > self.frame.size.width - 30){
        pointTouch.x = self.frame.size.width - 30;
    };
    int timeValue = (pointTouch.x - 30) / _abscissaScale;
    int temperatureValue = (pointTouch.y - 40) / _ordinateScale;
    if (temperatureValue > 54) {
        temperatureValue = 54;
    }else if (temperatureValue < 0){
        temperatureValue = 0;
    }
    
    CGPoint point = CGPointZero;
    
    double differenceValueX = pointTouch.x - 30 - timeValue * _abscissaScale;
    double differenceValueY = pointTouch.y - 40 - temperatureValue * _ordinateScale;
    if (differenceValueX > _abscissaScale/2) {
        timeValue++;
        point.x = _abscissaScale * timeValue  + 30;
    }else{
        point.x = _abscissaScale * timeValue + 30;
    }
    
    if (point.x < 30) {
        point.x = 30;
    }
    if (point.x > 30 + 48 * _abscissaScale) {
        point.x = 30 + 48 * _abscissaScale;
    }
    if (differenceValueY > _ordinateScale/2) {
        temperatureValue++;
        if (temperatureValue > 54) {
            temperatureValue = 54;
        }else if (temperatureValue < 0){
            temperatureValue = 0;
        }

        point.y = _ordinateScale * temperatureValue + 40;
    }else{
        point.y = _ordinateScale * temperatureValue + 40;
    }
    
    if (point.y < 40) {
        point.y = 40;
    }
    if (point.y > 40 + 54 * _ordinateScale) {
        point.y = 40 + 54 * _ordinateScale;
    }
    
    if (timeValue % 2 == 0) {
        _timeValueString = [NSString stringWithFormat:@"%d:00" ,timeValue / 2];
    }else{
        _timeValueString = [NSString stringWithFormat:@"%d:30" ,(timeValue - 1) / 2];
    }
#pragma mark **记录当前点的时间**
    _HourValue = [NSNumber numberWithInt:[[_timeValueString substringToIndex:2] intValue]];
    _MinValue = [NSNumber numberWithInt:[[_timeValueString substringFromIndex:3] intValue]];
    //    point.y = pointTouch.y;
    if (temperatureValue % 2 == 0) {
        _temperatureValueString = [NSString stringWithFormat:@"%d.0°", (temperatureValue / 2 - 27) * (-1) + 5];
    }else{
        _temperatureValueString = [NSString stringWithFormat:@"%d.5°",((temperatureValue)/ 2 - 27) * (-1) + 4];
        }
    _tempValue = [NSNumber numberWithDouble:([[_temperatureValueString substringToIndex:(_temperatureValueString.length - 1)] doubleValue] * 90)];
    return point;
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [self drawBrokenLineLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"%s",__func__);

//    UIBezierPath *path = [UIBezierPath bezierPath];
//    for (int i = 0 ; i < self.pointArray.count ; i ++) {
//        LCHandleModel *object = self.pointArray[i];
//        
//        if (i == 0) {
//            [path moveToPoint:object.center_Point];
//        }else if(self.pointArray.count == 2){
//            [path addLineToPoint:object.center_Point];
//        }else if(self.pointArray.count > 2 && i > 0 && i < self.pointArray.count - 1){
//            LCHandleModel *object_above = self.pointArray[1 + i];
//            LCHandleModel *object_blow = self.pointArray[i - 1];
//            CGPoint onePoint = CGPointMake(object.center_Point.x - 20, object_blow.center_Point.y);
//            CGPoint twoPoint = CGPointMake(object_above.center_Point.x - 20, object.center_Point.y);
//            CGPoint point_C = CGPointMake(onePoint.x,onePoint.y +  (twoPoint.y - onePoint.y)/2);
//            
//            [path addLineToPoint:onePoint];
//            [path addQuadCurveToPoint:object.center_Point controlPoint:point_C];
//            [path addLineToPoint:twoPoint];
//            if (i == self.pointArray.count - 2) {
//
//                CGPoint point_D = CGPointMake(twoPoint.x,twoPoint.y +  (object_above.center_Point.y - twoPoint.y)/2);
//                [path addQuadCurveToPoint:object_above.center_Point controlPoint:point_D];
//
//            }
//        }
//        
//        
//    }
//    path.lineWidth = 2;
//
//    // 设置线段样式
//    path.lineJoinStyle = kCGLineJoinRound;
//    path.lineCapStyle = kCGLineCapRound;
//    [[UIColor purpleColor] set];
//    [path stroke];
}
*/

@end
