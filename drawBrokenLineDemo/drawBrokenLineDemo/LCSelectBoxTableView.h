//
//  LCSelectBoxTableView.h
//  SmartHome
//
//  Created by MoGo on 16/3/24.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSelectedBoxCell.h"

@interface LCSelectBoxTableView : UITableView
- (instancetype)initWithFrame:(CGRect)frame andShowMessageArray:(NSArray *)dataArray;


- (void)allDidSelectedRows:(void(^)(NSArray *selectedArray))didSelectedBlock;
@end
