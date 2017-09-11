//
//  VipBannerView.h
//  XMediaTV
//
//  Created by 李勇杰 on 2017/9/8.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipBannerView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIView *blackView;

@property (nonatomic,weak) NSTimer *timer;
@end
