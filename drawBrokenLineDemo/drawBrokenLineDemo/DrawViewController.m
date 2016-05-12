//
//  DrawViewController.m
//  drawBrokenLineDemo
//
//  Created by MoGo on 16/2/18.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "DrawViewController.h"
#import "LCScheduleView.h"
#import "LCCopyToSomeDayViewController.h"
@interface DrawViewController ()
- (IBAction)gotoBack:(UIButton *)sender;
@property (nonatomic ,strong) NSArray *dataArray;
@end

@implementation DrawViewController
- (NSArray *)dataArray{
    if (!_dataArray) {
        NSString *paht = [[NSBundle mainBundle]pathForResource:@"ProgramTime.plist" ofType:nil];
        _dataArray = [NSArray arrayWithContentsOfFile:paht];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat W = [UIScreen mainScreen].bounds.size.height;
    CGFloat H = [UIScreen mainScreen].bounds.size.width;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateOneDaySchedule:) name:@"oneDaySchedule" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scheduleCopyToAction:) name:@"copyToAction" object:nil];
    LCScheduleView *brokenlineView = [[LCScheduleView alloc]initWithFrame:CGRectMake(0, 64, W, H - 64)];
    
//    brokenlineView.DisplayMode = self.DisplayMode;
    brokenlineView.dataArray = self.dataArray;
       [self.view addSubview:brokenlineView];
    // Do any additional setup after loading the view from its nib.
}
- (void)updateOneDaySchedule:(NSNotification *)notifi{
    NSDictionary *dict = notifi.object;
    NSLog(@"%@",dict);
}
- (void)scheduleCopyToAction:(NSNotification *)notifi{
    NSDictionary *dict = notifi.object;
    LCCopyToSomeDayViewController *copyVC = [[LCCopyToSomeDayViewController alloc]init];
    copyVC.copyFromIndex = [dict[@"weekday"] integerValue];
    copyVC.ProgramTime = dict[@"ProgramTime"];
    [self presentViewController:copyVC animated:YES completion:nil];
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}
/**
 *  横屏
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)gotoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
@end
