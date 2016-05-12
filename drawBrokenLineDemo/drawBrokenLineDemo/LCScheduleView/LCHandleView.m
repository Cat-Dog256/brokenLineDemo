//
//  LCHandleView.m
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/19.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "LCHandleView.h"
#import "LCBrokenLineView.h"
@implementation LCHandleView
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.bounds = CGRectMake(0, 0, 60, 50);
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.size.width/2 - 15, rect.size.height/2 - 15, 30, 30) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(50, 100)];
    
    
    double temperatureValue = [[self.handleText substringToIndex:self.handleText.length - 1] doubleValue];
    
    
    if (temperatureValue >= 5.0 && temperatureValue < 15.0) {
        [[UIColor colorWithRed:0 green:140/255.0 blue:214/255.0 alpha:1.0] set];
    }else if (temperatureValue >= 15.0 && temperatureValue < 20){
        [[UIColor colorWithRed:111/255.0 green:186/255.0 blue:42/255.0 alpha:1.0] set];
    }else if (temperatureValue >= 20 && temperatureValue < 28){
        [[UIColor colorWithRed:239/255.0 green:128/255.0 blue:4/255.0 alpha:1.0] set];
    }else{
        [[UIColor colorWithRed:237/255.0 green:1/255.0 blue:13/255.0 alpha:1.0] set];
    }
    [path fill];
    NSString *handleString = self.handleText;
    if ([self.DisplayMode isEqualToNumber:@1]) {
        handleString = [NSString stringWithFormat:@"%.01f°",(temperatureValue * 90 / 5 + 320)/10];
    }

#pragma mark**绘制温度**
  CGSize textSize = [handleString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size;
    CGRect textRect = CGRectMake(rect.size.width/2 - textSize.width/2, rect.size.height/2 - textSize.height/2, textSize.width, textSize.height);
        [handleString drawInRect:textRect withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12] , NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
#pragma mark**绘制时间**
    CGSize timeSize = [self.timestring boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:8]} context:nil].size;
    CGRect timeRect = CGRectMake(rect.size.width - timeSize.width, rect.size.height - timeSize.height, timeSize.width, timeSize.height);
    [self.timestring drawInRect:timeRect withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:8] , NSForegroundColorAttributeName : [UIColor grayColor]}];
#pragma mark**删除点的红叉**
    if (self.canRemove) {
        UIBezierPath *pathLine = [UIBezierPath bezierPath];
        pathLine.lineWidth = 2;

        [[UIColor redColor] set];
        
        [pathLine moveToPoint:CGPointMake(CGRectGetMaxX(rect) - 15,0)];
        [pathLine addLineToPoint:CGPointMake(CGRectGetMaxX(rect) -15 - 8, 8)];
        
        [pathLine moveToPoint:CGPointMake(CGRectGetMaxX(rect) -15  - 8,0)];
        [pathLine addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - 15, 8)];
        
        [pathLine stroke];
    }
    

}
#pragma mark**实现点的拖动**
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    // 获取UITouch
//    UITouch *touch = [touches anyObject];
//    
//    // 获取当前的点
//    CGPoint curP = [touch locationInView:self];
//    
//    // 获取上一个的点
//    CGPoint preP = [touch previousLocationInView:self];
//    
//    // 获取偏移量
//    CGFloat offsetX = curP.x - preP.x;
//    CGFloat offsetY = curP.y - preP.y;
//    
//    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
//    
//    [self.nextResponder touchesBegan:touches withEvent:event];
//}
//
//#pragma mark**处理scrollView的拖动**
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    
//    UIScrollView * sc = (UIScrollView*)self.superview.superview;
//    sc.scrollEnabled = NO;
//}
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UIScrollView * sc = (UIScrollView*)self.superview.superview;
//    sc.scrollEnabled = YES;
//
//}

@end
