//
//  XMMoreCollectionViewCell.h
//  Demo
//
//  Created by 薛佳妮 on 2017/8/22.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMMoreCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgContent;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblMsg;

- (void)updatecontent:(XM_ContentModel *)model;
@end
