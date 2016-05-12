//
//  LCSelectedBoxModel.h
//  SmartHome
//
//  Created by MoGo on 16/3/30.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCSelectedBoxModel : NSObject
@property (nonatomic , strong) NSString *messageString;
@property (nonatomic , assign) BOOL copyFrom;
@property (nonatomic , strong) NSNumber *weekday;
@end
