//
//  XM_MeActionTableViewCell.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/31.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XM_MeActionTableViewCell.h"
#define cellIdentifier @"CELL"
#define cellWidth (MainScreenWidth-1)/3

@interface XM_MeActionCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imgCenter;
@property (nonatomic, strong) UILabel     *lblText;
@end

@implementation XM_MeActionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    [self.contentView addSubview:self.imgCenter];
    [self.imgCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    [self.contentView addSubview:self.lblText];
    [self.lblText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.imgCenter.mas_bottom).with.offset(12);
    }];
}
- (void)reloadDetailWithDic:(NSDictionary *)dic {
    self.imgCenter.image = [UIImage imageNamed:dic[@"image"]];
    self.lblText.text = dic[@"text"];
}

- (UIImageView *)imgCenter {
    if (!_imgCenter) {
        _imgCenter = [[UIImageView alloc]init];
    }
    return _imgCenter;
}

- (UILabel *)lblText {
    if (!_lblText) {
        _lblText = [[UILabel alloc]init];
        _lblText.font = [UIFont systemFontOfSize:12.f];
        _lblText.textColor = zkHexColor(0x818fb2);
    }
    return _lblText;
}

@end



@interface XM_MeActionTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  *collection;
@property (nonatomic, strong) NSArray           *dataSourceArray;
@end
@implementation XM_MeActionTableViewCell

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
    self.dataSourceArray = @[@{@"image":@"vip",@"text":@"Upgrade to VIP"},
                             @{@"image":@"形状-73",@"text":@"Modify password"},
                             @{@"image":@"形状-74",@"text":@"Sign Out"}];
    [self setupSubViews];
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XM_MeActionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell reloadDetailWithDic:self.dataSourceArray[indexPath.row]];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.00001, 0.00001, 0.00001, 0.00001);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){cellWidth,100};
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.000001;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.000001;
}

- (UICollectionView *)collection {
    if (_collection == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collection = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:flowLayout];
        [_collection registerClass:[XM_MeActionCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        _collection.backgroundColor = [UIColor clearColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        
    }
    return _collection;
}
@end
