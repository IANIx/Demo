//
//  XMDetail_BriefIntroductionTableViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/9/4.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMDetail_BriefIntroductionTableViewCell.h"

@implementation XMDetail_BriefIntroductionTableViewCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupSubViews];
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).with.offset(8);
    }];
    
    [self addSubview:self.directorLabel];
    [self.directorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
    }];
    
    [self addSubview:self.scoreLabel];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.directorLabel);
        make.top.equalTo(self.directorLabel.mas_bottom).with.offset(5);
    }];
    
    [self addSubview:self.starringLabel];
    [self.starringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.scoreLabel.mas_bottom).with.offset(5);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)directorLabel {
    if (!_directorLabel) {
        _directorLabel = [[UILabel alloc]init];
        _directorLabel.font = [UIFont systemFontOfSize:15.f];
        _directorLabel.textColor = zkHexColor(0x818fb2);
        _directorLabel.text = @"director:Nick Stariano";
    }
    return _directorLabel;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.font = [UIFont systemFontOfSize:15.f];
        _scoreLabel.textColor = zkHexColor(0x818fb2);
        _scoreLabel.text = @"score:";
    }
    return _scoreLabel;
}

- (UILabel *)starringLabel {
    if (!_starringLabel) {
        _starringLabel = [[UILabel alloc]init];
        _starringLabel.font = [UIFont systemFontOfSize:15.f];
        _starringLabel.textColor = zkHexColor(0x818fb2);
        _starringLabel.text = @"starring:Vin Diesel/Dwayne Johnson";
    }
    return _starringLabel;
}
@end
