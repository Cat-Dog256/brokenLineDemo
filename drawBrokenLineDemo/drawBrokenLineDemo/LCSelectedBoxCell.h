//
//  LCSelectedBoxCell.h
//  SmartHome
//
//  Created by MoGo on 16/3/30.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSelectedBoxModel.h"
@class LCSelectBoxTableView;
@protocol LCSelectedBoxCellDelegate <NSObject>

- (void)selectedBoxTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath andButtonState:(BOOL)isSeledted;
@end

@interface LCSelectedBoxCell : UITableViewCell
@property (nonatomic , strong) LCSelectedBoxModel *model;
@property (nonatomic , strong) NSIndexPath *indexpath;
@property (nonatomic , assign) id<LCSelectedBoxCellDelegate>delegate;
@end
