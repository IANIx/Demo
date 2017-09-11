//
//  VipBannerView.m
//  XMediaTV
//
//  Created by 李勇杰 on 2017/9/8.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "VipBannerView.h"

@implementation VipBannerView

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
    [self requesthome];
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.scrollView];
    [self addSubview:self.blackView];
    [self addSubview:self.pageControl];
    [self addSubview:self.label];
    
    //    [self performSelector:@selector(changeImage) withObject:self afterDelay:2.f];
}

-(void)requesthome{
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_MENULIST_URL
                                     WithParams:@{@"mac":@"C:D5:D9:02:F6:1A",
                                                  @"menuId":@"87",
                                                  @"menuId":@"CN_zh"}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   NSLog(@"success --> %@",dic);
                               } WithFailurBlock:^(NSError *error) {
                                   NSLog(@"failed -->error == %@",error.description);
                               }];
}


#pragma mark - ScrollView
-(void)changeImage
{
    //获得当先scrollView滚动到的点（俗称偏移量）
    CGFloat offSetX = self.scrollView.contentOffset.x;//获取当前滚动视图的contentOffSet的x值
    
    //让scrollView向右滚动一个屏幕宽的距离
    offSetX += self.scrollView.bounds.size.width;
    
    [self.scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];//开始偏移并伴有动画效果
    //    [self performSelector:@selector(changeImage) withObject:self afterDelay:2.f];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int pageNumber = self.scrollView.contentOffset.x/self.frame.size.width;//自定义方法，根据偏移量设置当前页码
    self.pageControl.currentPage = pageNumber;
    
    //    //获得偏移量
    //    CGPoint point = self.scrollView.contentOffset;
    //    //获得当前的最大x值(在可见区域内，最大的x轴上的值)
    //    CGFloat manX = self.scrollView.bounds.size.width * (4 - 1);
    //
    //    //如果当前点已经到了最前边的一张，即坐标为0,0
    //    if (point.x == 0)
    //    {
    //        CGFloat x = self.scrollView.bounds.size.width * (4 - 2);
    //        [self.scrollView setContentOffset:CGPointMake(x , 0)];//立马跳到倒数第二张(因为最后一张是为了往后滚动做的铺垫视图)
    //    }
    //
    //    //如果当前点已经达到最后一张图，即坐标为
    //    else if (point.x == manX)
    //    {
    //        [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0)];//立马跳到整数第二张，第一张同理，利用人的视觉差
    //    }
    //
    //
    //改变标签
    //    int index = pageNumber + 1;
    //    self.label.text = [self.items[index] objectForKey:@"title"];
    
}
/**
 *  获取当前属于第几页，用于改变pageControl
 *
 *  @param contentOffSet scrollView的左上角的点
 *
 *  @return 返回属于第几张
 */
-(int)imageIndexWithContentOffset:(CGPoint)contentOffSet
{
    return (contentOffSet.x - self.scrollView.bounds.size.width) / self.frame.size.width;
}
/**
 *  滚动视图将要开始拖动滚动的时候的委托回调方法(自动调用偏移的时候不会回调这个方法，需外力作用，下面依旧是)
 *
 *  @param scrollView 将要开始的滚动视图
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];//取消计时器
    self.timer = nil;//避免野指针
}
/**
 *  滚动视图拖动滚动结束时候的委托回调方法(手拖动离开屏幕的时候)
 *
 *  @param scrollView 停止的滚动视图
 *  @param decelerate 是否减速
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
#pragma mark - GET/SET
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width*4, self.frame.size.height);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i < 4; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width*i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
            //            imageView.backgroundColor = RGBCOLOR(arc4random()%255, arc4random()%255, arc4random()%255);
            if (i == 0) {
                imageView.backgroundColor = [UIColor yellowColor];
            } else if (i == 1) {
                imageView.backgroundColor = [UIColor greenColor];
            } else if (i == 2) {
                imageView.backgroundColor = [UIColor cyanColor];
            } else {
                imageView.backgroundColor = [UIColor orangeColor];
            }
            [_scrollView addSubview:imageView];
        }
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-28, self.frame.size.width, 28)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.6f;
    }
    return _blackView;
}
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width-100, self.frame.size.height-28, 100, 28)];
        _pageControl.numberOfPages = 4;
    }
    return _pageControl;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-28, self.frame.size.width, 28)];
    }
    return _label;
}
@end


