//
//  XMTitleMenuView.h
//  XMediaTV
//
//  Created by 李勇杰 on 2017/9/9.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTitleMenuView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSArray <XM_MenuModel *> *menuList;

@end
