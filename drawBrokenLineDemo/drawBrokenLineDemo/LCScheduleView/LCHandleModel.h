//
//  LCHandleModel.h
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/19.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LCHandleView.h"
@interface LCHandleModel : NSObject
/**
 *  中心
 */
@property (nonatomic , assign) CGPoint center_Point;
/**
 *  不重叠的范围
 */
@property (nonatomic , assign) CGRect handle_Frame;
/**
 *  手柄
 */
@property (nonatomic , strong) LCHandleView *handleView;
@property (nonatomic , strong) NSNumber *Hour;
@property (nonatomic , strong) NSNumber *Min;
@property (nonatomic , strong) NSNumber *Temprature;
@end
