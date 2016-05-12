//
//  LCCopyToSomeDayViewController.m
//  SmartHome
//
//  Created by MoGo on 16/3/23.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "LCCopyToSomeDayViewController.h"
#import "LCSelectBoxTableView.h"
#import "LCSubmitButton.h"
#import "UIView+Extension.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// RGB颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface LCCopyToSomeDayViewController ()

@property (nonatomic ,strong) LCSelectBoxTableView *myTableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *submitArray;
@end

@implementation LCCopyToSomeDayViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   }
- (void)backButtonAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
        NSArray *data = [NSArray arrayWithObjects:@"Mon.",@"Tue.",@"Wed.",@"Thu.",@"Fri.",@"Sat.",@"Sun.", nil];
        for (int i = 0; i < 7; i++) {
            LCSelectedBoxModel *model = [[LCSelectedBoxModel alloc]init];
            model.messageString  = data[i];
            model.weekday = [NSNumber numberWithInt:(i+1)];
            if (i == 6) {
                model.weekday = [NSNumber numberWithInt:(0)];
            }
            if (self.copyFromIndex == 0) {
                self.copyFromIndex = 7;
            }
            if (i == self.copyFromIndex - 1) {
                model.copyFrom = YES;
            }else{
                model.copyFrom = NO;
            }
            [self.dataArray addObject:model];
        }
        
    }
    return _dataArray;
}

- (NSMutableArray *)submitArray{
    if (!_submitArray) {
        _submitArray = [NSMutableArray array];
    }
    return _submitArray;
}
- (LCSelectBoxTableView *)myTableView{
    if (!_myTableView) {
              _myTableView = [[LCSelectBoxTableView alloc]initWithFrame:CGRectMake(0, 64 , SCREEN_HEIGHT, 50 * 7) andShowMessageArray:self.dataArray];
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LCColor(230, 230, 230);
    [self.myTableView allDidSelectedRows:^(NSArray *selectedArray) {
        [self.submitArray addObjectsFromArray:selectedArray];
    }];
    
    LCSubmitButton *doneButton = [[LCSubmitButton alloc]init];
    doneButton.width = SCREEN_HEIGHT - 80;
    doneButton.height = 30;
    doneButton.x = 40;
    doneButton.y = CGRectGetMaxY(self.myTableView.frame)  + 10;
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(clickDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
    
    
  
    // Do any additional setup after loading the view from its nib.
}
- (void)clickDoneButton:(LCSubmitButton *)button{
       
    NSLog(@"%@",self.submitArray);
    [self dismissViewControllerAnimated:YES completion:nil];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
