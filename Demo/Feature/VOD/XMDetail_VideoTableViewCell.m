//
//  XMDetail_VideoTableViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/9/4.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMDetail_VideoTableViewCell.h"

@implementation XMDetail_VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}
- (void)setupViews {
    self.playView = [[XM_PlayView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 150)];
    self.playView.xm_superView = self;  
    [self addSubview:self.playView];
}
@end
