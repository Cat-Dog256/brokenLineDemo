//
//  LCSelectedBoxCell.m
//  SmartHome
//
//  Created by MoGo on 16/3/30.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import "LCSelectedBoxCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface LCSelectedBoxCell ()

@property (nonatomic , strong) UILabel *messageLabel;
@property (nonatomic , strong) UIButton *boxButton;
@property (nonatomic , strong) UIButton *imageButton;
@end

@implementation LCSelectedBoxCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
  self =  [super initWithCoder:aDecoder];
    if (self) {
          }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
        
        
        _messageLabel  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0 , 50 , 50)];
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_messageLabel];
        _boxButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 5, 40, 40)];

        [_boxButton setImage:[UIImage imageNamed:@"check_unchecked"] forState:UIControlStateNormal];
        [_boxButton setImage:[UIImage imageNamed:@"lcheck_checked"] forState:UIControlStateSelected];
        [_boxButton addTarget:self action:@selector(selectedThisBox:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_boxButton];
        
        
        _imageButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 180, 0, 160, 50)];
        _imageButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_imageButton setTitle:@"Copy to other day" forState:UIControlStateNormal];
        [_imageButton setImage:[UIImage imageNamed:@"lan_icon_copyto"] forState:UIControlStateNormal];
        [_imageButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _imageButton.hidden = YES;
        _imageButton.userInteractionEnabled = NO;
        [self.contentView addSubview:_imageButton];
        }
    return self;
}

- (void)setModel:(LCSelectedBoxModel *)model{
    _model = model;
    if (model.copyFrom) {
        _boxButton.hidden = YES;
        _imageButton.hidden = NO;
    }else{
        _boxButton.hidden = NO;
        _imageButton.hidden = YES;
    }
    _messageLabel.text = model.messageString;
}

- (void)selectedThisBox:(UIButton *)button{
    button.selected = !button.selected;
    
    if ([self.delegate respondsToSelector:@selector(selectedBoxTableViewDidSelectRowAtIndexPath:andButtonState:)]) {
        [self.delegate selectedBoxTableViewDidSelectRowAtIndexPath:self.indexpath andButtonState:button.selected];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
