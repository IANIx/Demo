//
//  XMMoreCollectionViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/22.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMMoreCollectionViewCell.h"

@implementation XMMoreCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.imgContent];
    [self.contentView addSubview:self.lblName];
    [self.contentView addSubview:self.lblMsg];
    
    [self.lblMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(@18);
    }];
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.lblMsg.mas_top);
        make.height.mas_equalTo(@18);
    }];
    [self.imgContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.lblName.mas_top);
    }];
    
}
- (void)updatecontent:(XM_ContentModel *)model{
    self.lblName.text = model.name;
    [self.imgContent sd_setImageWithURL:[NSURL URLWithString:model.poster]];
}
- (UIImageView *)imgContent {
    if (!_imgContent) {
        _imgContent = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"p2457746352"]];
    }
    return _imgContent;
    
}
- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc]init];
        _lblName.text = @"Fast & Furiou";
        _lblName.font = [UIFont systemFontOfSize:15.f];
        _lblName.textColor = zkHexColor(0xffffff);
    }
    return _lblName;
}
- (UILabel *)lblMsg {
    if (!_lblMsg) {
        _lblMsg = [[UILabel alloc]init];
        _lblMsg.text = @"Children,big friend";
        _lblMsg.font = [UIFont systemFontOfSize:12.f];
        _lblMsg.textColor = zkHexColor(0x818fb2);
    }
    return _lblMsg;
}
@end
