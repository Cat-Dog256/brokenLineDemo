//
//  LCSubmitButton.m
//  SmartHome
//
//  Created by MoGo on 16/1/7.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "LCSubmitButton.h"

@implementation LCSubmitButton
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        [self setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"hightlight"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        [self setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        [self setBackgroundImage:[UIImage imageNamed:@"hightlight"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        [self setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"hightlight"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
