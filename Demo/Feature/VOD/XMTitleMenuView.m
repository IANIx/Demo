//
//  XMTitleMenuView.m
//  XMediaTV
//
//  Created by 李勇杰 on 2017/9/9.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMTitleMenuView.h"

@implementation XMTitleMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupSubViews];
    return self;
}
- (void)setupSubViews {
    [self addSubview:self.scrollView];
}
- (void)setMenuList:(NSArray<XM_MenuModel *> *)menuList {
    _menuList = menuList;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    __block NSInteger x = 0;
    [menuList enumerateObjectsUsingBlock:^(XM_MenuModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:zkHexColor(0x818fb2) forState:UIControlStateNormal];
        [button setTitleColor:zkHexColor(0x9138ea) forState:UIControlStateSelected];
        [button setTitle:obj.menuName forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
        CGSize size=[obj.menuName sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.f]}];
        button.frame = CGRectMake(x, 0, size.width, self.scrollView.frame.size.height);
        x = x + size.width + 10;
        self.scrollView.contentSize = CGSizeMake(x, self.frame.size.height);
        if (idx == 0) {
            button.selected = YES;
        }
        [self.scrollView addSubview:button];
    }];
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
@end
