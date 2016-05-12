//
//  LCHandleView.h
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/19.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCHandleView : UIView
/**
 *  文字 温度
 */
@property (nonatomic , strong) NSString *handleText;
/**
 *  时间
 */
@property (nonatomic , strong) NSString *timestring;
/**
 *  能够删除
 */
@property (nonatomic , assign) BOOL canRemove;
/**
 *  温度单位 
 */
@property (nonatomic, strong) NSNumber *DisplayMode;
@end
