//
//  LCSelectBoxTableView.m
//  SmartHome
//
//  Created by MoGo on 16/3/24.
//  Copyright © 2016年 MoGo. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// RGB颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "LCSelectBoxTableView.h"
@interface LCSelectBoxTableView ()<UITableViewDataSource , UITableViewDelegate , LCSelectedBoxCellDelegate>
@property (nonatomic , strong) UIButton *SelectBoxButton;
@property (nonatomic , copy) void(^selectBoxRowBlock)(NSArray *didSelected);

@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) NSMutableArray *selectedData;
@end

@implementation LCSelectBoxTableView

- (NSMutableArray *)selectedData{
    if (!_selectedData) {
        _selectedData = [NSMutableArray array];
    }
    return _selectedData;
}
- (instancetype)initWithFrame:(CGRect)frame andShowMessageArray:(NSArray *)dataArray{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
   
    if (self) {
        self.rowHeight = 50;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;
        self.dataArray = [NSMutableArray arrayWithArray:dataArray];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 1, SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
    }
    return self;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"%@",indexPath];
    LCSelectedBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LCSelectedBoxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row%2 == 1) {
            cell.backgroundColor = LCColor(230, 230, 230);
        }

    }
    
    cell.indexpath = indexPath;
    cell.model = self.dataArray[indexPath.row];
       return cell;
}
- (void)selectedBoxTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath andButtonState:(BOOL)isSeledted{
    if (isSeledted) {
        [self.selectedData addObject:self.dataArray[indexPath.row]];
    }else{
        LCSelectedBoxModel *removeModel = self.dataArray[indexPath.row];
        for (LCSelectedBoxModel *model in self.selectedData) {
            if ([model isEqual:removeModel]) {
                [self.selectedData removeObject:model];
                break;
            }
        }
    }
    
    self.selectBoxRowBlock(self.selectedData);
}
- (void)allDidSelectedRows:(void (^)(NSArray *))didSelectedBlock{
    [self setSelectBoxRowBlock:^(NSArray *selectedArray) {
        didSelectedBlock(selectedArray);
    }];
}


@end
