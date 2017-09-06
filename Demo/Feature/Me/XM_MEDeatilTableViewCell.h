//
//  XM_MEDeatilTableViewCell.h
//  Demo
//
//  Created by 薛佳妮 on 2017/8/31.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XM_MEDeatilTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgTitle;
@property (nonatomic, strong) UILabel     *lblText;

- (void)updateCellWithDic:(NSDictionary *)dic;
@end
