//
//  LCCopyToSomeDayViewController.h
//  SmartHome
//
//  Created by MoGo on 16/3/23.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LCCopyToSomeDayViewController : UIViewController
@property (nonatomic , strong) NSNumber *nodeId;
@property (nonatomic , assign) NSInteger copyFromIndex;
@property (nonatomic , strong) NSDictionary *ProgramTime;
@end
