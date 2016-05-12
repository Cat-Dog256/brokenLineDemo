//
//  LCWeekTemModel.m
//  SmartHome
//
//  Created by MoGo on 16/3/6.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "LCWeekTemModel.h"

@implementation LCWeekTemModel

- (NSString *)Temprature{
    double temperatureV = [_Temprature doubleValue] / 90.0;
    
    return [NSString stringWithFormat:@"%.01f",temperatureV];
}
- (NSString *)Hour{
    if ([_Min isEqualToString:@"30"]) {
        _Hour = [NSString stringWithFormat:@"%@.5",_Hour];
    }
    return _Hour;
}
- (NSString *)timeValue{
    int hourValue = [_Hour intValue];
    int minvalue = [_Min intValue];
    return [NSString stringWithFormat:@"%d:%.02d",hourValue,minvalue];
}
@end
