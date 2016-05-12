//
//  LCBrokenLineView.h
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/18.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCBrokenLineView : UIView
@property (nonatomic, strong) NSNumber *DisplayMode;
/**
 *  节点
 */
@property (nonatomic , strong) NSArray *timeAndTemperatureValue;
@property (nonatomic , strong) NSNumber *weekday;
@end
