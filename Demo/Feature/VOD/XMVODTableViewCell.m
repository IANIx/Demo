//
//  XMVODTableViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMVODTableViewCell.h"

#define TITLEHEIGHT 30
#define cellWidth (MainScreenWidth - 30)/2

@implementation XMVODCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupSubViews];
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.imgContent];
    [self addSubview:self.lblName];
    [self addSubview:self.lblIntroduction];
    _imgContent.layer.cornerRadius = 8.f;
    _imgContent.layer.masksToBounds = YES;

    _lblName.text = @"Wonfer Woman";
    _lblIntroduction.text = @"children,big friend look here";
    [self.imgContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.bottom.equalTo(self).with.offset(-TITLEHEIGHT);
    }];
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.top.equalTo(self.imgContent.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    [self.lblIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.top.equalTo(self.lblName.mas_bottom);
        make.height.mas_equalTo(20);
    }];
}

- (UIImageView *)imgContent {
    if (!_imgContent) {
        _imgContent = [[UIImageView alloc]init];
        _imgContent.image = [UIImage imageNamed:@"p2461814579"];
    }
    return _imgContent;
}
- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc]init];
        _lblName.textColor = XM_COMMON_TITLE_COLOR;
        _lblName.font = [UIFont systemFontOfSize:15.f];
    }
    return _lblName;
}
- (UILabel *)lblIntroduction {
    if (!_lblIntroduction) {
        _lblIntroduction = [[UILabel alloc]init];
        _lblIntroduction.textColor = XM_COMMON_BGTITLE_COLOR;
        _lblIntroduction.font = [UIFont systemFontOfSize:12.f];
    }
    return _lblIntroduction;
}
@end

@interface XMVODTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UIButton  *btnMore;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation XMVODTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupSubViews];
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblTitle];
    [self addSubview:self.btnMore];
    [self addSubview:self.collection];
    
    _lblTitle.text = @"Selected Topics";
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).with.offset(TITLEHEIGHT);
        make.bottom.equalTo(self).with.offset(-20);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collection.mas_top);
        make.left.equalTo(self).with.offset(30);
    }];
    [self.btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collection.mas_top);
        make.right.equalTo(self).with.offset(-10);
    }];

}

#pragma mark - Action
- (void)MoreClicked:(UIButton *)button {
    [self.delegate XMVODCell:self MorebtnDidClicked:button];
}
#pragma mark - collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){cellWidth,(self.collection.frame.size.height-30)/2};
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMVODCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];

    return cell;
}

#pragma mark - GET/SET
- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collection registerClass:[XMVODCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.backgroundColor = [UIColor clearColor];
        _collection.delegate = self;
        _collection.dataSource = self;
    }
    return _collection;
}
- (UIButton *)btnMore {
    if (!_btnMore) {
        _btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnMore.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        [_btnMore setImage:[UIImage imageNamed:@"More"] forState:UIControlStateNormal];
        [_btnMore setTitle:@"MORE  " forState:UIControlStateNormal];
        [_btnMore setTitleColor:XM_COMMON_BGTITLE_COLOR forState:UIControlStateNormal];
        _btnMore.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnMore addTarget:self action:@selector(MoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMore;
}
- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc]init];
        _lblTitle.textColor = XM_COMMON_TITLE_COLOR;
        _lblTitle.font = [UIFont boldSystemFontOfSize:16.f];
    }
    return _lblTitle;
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
