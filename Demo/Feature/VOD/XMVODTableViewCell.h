//
//  XMVODTableViewCell.h
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMVODTableViewCell;

@interface XMVODCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgContent;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblIntroduction;

@end

@protocol XMVODCellActionDelegate <NSObject>

- (void)XMVODCell:(XMVODTableViewCell *)cell MorebtnDidClicked:(UIButton *)button;

@end

@interface XMVODTableViewCell : UITableViewCell

@property (nonatomic, weak) id<XMVODCellActionDelegate> delegate;
@end
