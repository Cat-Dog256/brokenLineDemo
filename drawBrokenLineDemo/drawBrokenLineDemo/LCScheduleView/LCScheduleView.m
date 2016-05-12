//
//  LCScheduleView.m
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/23.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "LCScheduleView.h"
#import "LCBrokenLineView.h"
#import "LCWeekTemModel.h"
#import "LCHandleView.h"
#import "MJExtension.h"
@interface LCScheduleView ()<UIScrollViewDelegate>

@end

@implementation LCScheduleView
{
    
    UIScrollView *mainScrollView;
    UIImageView *lineImageView;
    UIButton *lastButton;
    CGFloat butX;
    CGFloat butY;
    CGFloat butW;
    CGFloat butH;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        CGFloat W = [UIScreen mainScreen].bounds.size.width;
        CGFloat H = [UIScreen mainScreen].bounds.size.height;

        
         butX = 40;
         butY = 0;
         butW = (H - 80)/7;
         butH = 40;

        
        NSArray *buttonNames = @[@"Mon.",
                                 @"Tue.",
                                 @"Wed.",
                                 @"Thu.",
                                 @"Fri.",
                                 @"Sat.",
                                 @"sun.",];
        for (int i = 0; i < 7; i++) {
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(butX + butW * i, butY, butW, butH)];
            
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitle:buttonNames[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:146/255.0 green:157/255.0 blue:164/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            button.backgroundColor = [UIColor clearColor];
            [self addSubview:button];
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor grayColor];
            [self addSubview:lineView];

            if (i == 0) {
                
                button.selected = YES;
                lastButton = button;
                
                UIView *lineV = [[UIView alloc]init];
                lineV.backgroundColor = [UIColor grayColor];
                [self addSubview:lineV];

                lineV.frame = CGRectMake(butX,10, 1, 20);

            }
           lineView.frame = CGRectMake(CGRectGetMaxX(button.frame),10, 1, 20);
        
        }
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(40, 40, H - 80, 4)];
        
        bottomView.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomView];
        
        lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1, butW, 2)];
        lineImageView.backgroundColor = [UIColor orangeColor];
        [bottomView addSubview:lineImageView];
        
        
        mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, H, W - 44 - 64)];
        mainScrollView.showsVerticalScrollIndicator = NO;
        mainScrollView.showsHorizontalScrollIndicator = NO;
        
        
//        mainScrollView.scrollEnabled = NO;
        
        
        
        mainScrollView.delegate = self;
        mainScrollView.bounces = NO;
        mainScrollView.pagingEnabled = YES;
        mainScrollView.backgroundColor = [UIColor clearColor];
        mainScrollView.contentSize = CGSizeMake(H * 7, W - 44 - 64);
#pragma mark**weekday是周日到周一为1~7   UI顺序为周一到周日是0~6**
       int weekday = [self getWeekIntValueCurrentDate];
        if (weekday == 1) {
            weekday = 8;
        }
        mainScrollView.contentOffset = CGPointMake(H * (weekday - 2), 0);
        [self addSubview:mainScrollView];
    }
    return self;
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    for (int i = 0 ; i < 7; i++) {
        
        LCBrokenLineView *brokenlineView = [[LCBrokenLineView alloc]initWithFrame:CGRectMake(H * i, 0, H, W - 44 - 64)];
        
        NSArray *ProgramTime = nil;
        if (i < 6) {
            ProgramTime = dataArray[i + 1][@"ProgramTime"];
        }else{
            ProgramTime = dataArray[0][@"ProgramTime"];
        }
        NSArray *dataArray = [LCWeekTemModel mj_objectArrayWithKeyValuesArray:ProgramTime];
        brokenlineView.weekday = [NSNumber numberWithInt:(i + 1)];
        
        if (i==6) {
            brokenlineView.weekday = [NSNumber numberWithInt:(0)];
        }
        
        /**
         *  这两句的顺序不要交换
         */
        brokenlineView.DisplayMode = self.DisplayMode;
        brokenlineView.timeAndTemperatureValue = dataArray;

        brokenlineView.backgroundColor = [UIColor whiteColor];
        [mainScrollView addSubview:brokenlineView];
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSUInteger page = (scrollView.contentOffset.x + mainScrollView.frame.size.width / 2)/ mainScrollView.frame.size.width;
    
    
    
    lastButton.selected = NO;
    UIButton *button = (UIButton *)[self viewWithTag:1000 + page];
    button.selected = YES;
    lastButton = button;
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        lineImageView.frame = CGRectMake(butW * page, 1, butW, 2);
    }];
    
}
- (void)clickButtonAction:(UIButton *)button{
    if (button.selected == YES) return;
    
    
    mainScrollView.contentOffset = CGPointMake(mainScrollView.frame.size.width * (button.tag - 1000), 0);
    lineImageView.frame = CGRectMake(butW * (button.tag - 1000), 1, butW, 2);
    lastButton.selected = NO;
    button.selected = YES;
    lastButton = button;
}
/**
 *  判断当天是周几
    周日是“1”，周一是“2”...
 */
-(int)getWeekIntValueCurrentDate
{
    int weekIntValue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps= [calendar components:(NSCalendarUnitYear |
                                                   NSCalendarUnitMonth |
                                                   NSCalendarUnitDay |
                                                   NSCalendarUnitWeekday) fromDate:[NSDate date]];
    return weekIntValue = (int)[comps weekday];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
