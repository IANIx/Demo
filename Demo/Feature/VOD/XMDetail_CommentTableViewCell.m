//
//  XMDetail_CommentTableViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/9/4.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMDetail_CommentTableViewCell.h"

@implementation XMDetail_CommentTableViewCell

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
    [self addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-10);
    }];
    
    [self addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(self);
        make.right.equalTo(self.shareButton.mas_left).with.offset(-10);
    }];
}
- (UIButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setBackgroundImage:[UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    }
    return _likeButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    }
    return _shareButton;
}
@end
