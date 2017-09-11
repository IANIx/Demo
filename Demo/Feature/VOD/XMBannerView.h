//
//  XMBannerView.h
//  Demo
//
//  Created by 李勇杰 on 2017/9/7.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMBannerView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIView *blackView;

@property (nonatomic,weak) NSTimer *timer;

@property (nonatomic,copy) NSArray<XM_rContentModel *> *contentArray;
- (instancetype)initWithFrame:(CGRect)frame andMenu:(XM_MenuModel *)menu;
- (void)updateBannerImageWithArray:(NSArray<XM_rContentModel *> *)array;
@end
