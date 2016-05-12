//
//  LCHandleModel.m
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/19.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "LCHandleModel.h"

@implementation LCHandleModel
- (CGRect)handle_Frame{
    CGFloat handle_X = _handleView.frame.origin.x + _handleView.frame.size.width/2 - 15;
    CGFloat handle_Y = _handleView.frame.origin.y +  _handleView.frame.size.height/2 - 15;
    CGFloat handle_WH = 30;

    return CGRectMake(handle_X , handle_Y, handle_WH, handle_WH);
}
@end
