//
//  XMLiveTableViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMLiveTableViewCell.h"

@interface XMLiveTableViewCell ()

@property (nonatomic, strong) UIImageView *imgPreview;
@property (nonatomic, strong) UILabel *lblTVName;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UILabel *lblMessage;

@end

@implementation XMLiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupSubViews];
    return self;
}
- (void)setupSubViews {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.imgPreview];
    [self addSubview:self.lblTVName];
    [self addSubview:self.lblTime];
    [self addSubview:self.lblMessage];
    
    self.lblTVName.text = @"CCTV-1";
    self.lblTime.text = @"09:00";
    self.lblMessage.text = @"National Memory";
    [self.imgPreview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(192/2, 108/2));
        make.left.mas_equalTo(30/2);
        make.centerY.equalTo(self);
    }];
    [self.lblTVName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(36/2);
        make.left.equalTo(self.imgPreview.mas_right).with.offset(30/2);
    }];
    [self.lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTVName);
        make.top.equalTo(self.lblTVName.mas_bottom).with.offset(5);
    }];
    [self.lblMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTime);
        make.left.equalTo(self.lblTime.mas_right).with.offset(10);
    }];
}
- (void)updateWithModel:(XM_ChannelModel *)model {
    self.lblTVName.text = model.channelName;
    self.lblMessage.text = model.message;
    [self.imgPreview sd_setImageWithURL:[NSURL URLWithString:model.logo]];
}

#pragma mark - lazy
- (UIImageView *)imgPreview {
    if (!_imgPreview) {
        _imgPreview = [[UIImageView alloc]init];
        _imgPreview.backgroundColor = [UIColor grayColor];
    }
    return _imgPreview;
}
- (UILabel *)lblTVName {
    if (!_lblTVName) {
        _lblTVName = [[UILabel alloc]init];
        _lblTVName.textColor = zkHexColor(0xffffff);
        _lblTVName.font = [UIFont systemFontOfSize:15.f];
    }
    return _lblTVName;
}
- (UILabel *)lblTime {
    if (!_lblTime) {
        _lblTime = [[UILabel alloc]init];
        _lblTime.textColor = zkHexColor(0x818fb2);
        _lblTime.font = [UIFont systemFontOfSize:12.f];
    }
    return _lblTime;
}
- (UILabel *)lblMessage {
    if (!_lblMessage) {
        _lblMessage = [[UILabel alloc]init];
        _lblMessage.textColor = zkHexColor(0x818fb2);
        _lblMessage.font = [UIFont systemFontOfSize:12.f];
    }
    return _lblMessage;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
