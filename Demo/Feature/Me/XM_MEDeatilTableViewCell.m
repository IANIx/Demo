//
//  XM_MEDeatilTableViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/31.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XM_MEDeatilTableViewCell.h"

@implementation XM_MEDeatilTableViewCell

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
    [self addSubview:self.imgTitle];
    [self addSubview:self.lblText];
    [self.imgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(21);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [self.lblText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.imgTitle.mas_right).with.offset(12);
    }];
}

- (void)updateCellWithDic:(NSDictionary *)dic {
    self.imgTitle.image = [UIImage imageNamed:dic[@"image"]];
    self.lblText.text = dic[@"text"];
}
- (UIImageView *)imgTitle {
    if (!_imgTitle) {
        _imgTitle = [[UIImageView alloc]init];
    }
    return _imgTitle;
}

- (UILabel *)lblText {
    if (!_lblText) {
        _lblText = [[UILabel alloc]init];
        _lblText.font = [UIFont systemFontOfSize:14.f];
        _lblText.textColor = [UIColor whiteColor];
    }
    return _lblText;
}
@end
