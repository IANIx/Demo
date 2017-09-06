//
//  XM_MeInfoTableViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/31.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XM_MeInfoTableViewCell.h"

@implementation XM_MeInfoTableViewCell

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
    self.backgroundColor = [UIColor clearColor];
    [self setupSubViews];
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.btnAvatar];
    [self.btnAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(23);
        make.size.mas_equalTo(CGSizeMake(74, 74));
    }];
    
    [self addSubview:self.lblNickName];
    [self.lblNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.btnAvatar.mas_right).with.offset(15);
    }];
    
    self.btnAvatar.layer.masksToBounds = YES;
    self.btnAvatar.layer.cornerRadius = 74/2.f;
    
    [self.btnAvatar setBackgroundImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateNormal];
    self.lblNickName.text = @"Merry";
}

- (UIButton *)btnAvatar {
    if (!_btnAvatar) {
        _btnAvatar = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnAvatar;
}

- (UILabel *)lblNickName {
    if (!_lblNickName) {
        _lblNickName = [[UILabel alloc]init];
        _lblNickName.textColor = [UIColor whiteColor];
        _lblNickName.font = [UIFont systemFontOfSize:20.f];
    }
    return _lblNickName;
}
@end
