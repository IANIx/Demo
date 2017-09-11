//
//  XM_PlayView.m
//  XMediaTV
//
//  Created by 李勇杰 on 2017/9/9.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XM_PlayView.h"

@implementation XM_PlayToolsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5f];
    [self setpSubViews];
    return self;
}
- (void)setpSubViews {
    [self addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(15.f);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.playButton);
        make.left.equalTo(self.playButton.mas_right).with.offset(15);
    }];
    
    [self addSubview:self.fullScreenButton];
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.playButton);
        make.right.equalTo(self).with.offset(-15);
    }];
    
    [self addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playButton);
        make.left.equalTo(self.nextButton.mas_right).with.offset(15);
        make.right.equalTo(self.fullScreenButton.mas_left).with.offset(-10);
    }];
}
- (void)fullScreendidClicked {
    self.fullScreenButton.selected = !self.fullScreenButton.selected;
    if (self.fullScreenButton.selected) {
        [self.delegate toolsFullScreenDidClicked];
    } else {
        [self.delegate toolsSmallScreenDidClicked];
    }
}
- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    }
    return _playButton;
}
- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"下一集"] forState:UIControlStateNormal];
    }
    return _nextButton;
}
- (UIButton *)fullScreenButton {
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setBackgroundImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
        [_fullScreenButton addTarget:self action:@selector(fullScreendidClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}
- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc]init];
        _slider.tintColor = [UIColor cyanColor];
        UIImage *thumbImageNormal = [UIImage imageNamed:@"进度圆"];
        [_slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    }
    return _slider;
}
@end

@implementation XM_PlayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = XM_COMMON_BG_COLOR;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick)];
    [self addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    [self setupSubViews];
    return self;
}
- (void)setupSubViews {
    [self addSubview:self.toolsView];
    [self.toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@30.f);
    }];
    
}
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    UIDevice *device = [UIDevice currentDevice] ;
    
    switch (device.orientation) {
            
        case UIDeviceOrientationLandscapeLeft:
            [self toolsFullScreenDidClicked];
            break;
            
        case UIDeviceOrientationPortrait:

            [self toolsSmallScreenDidClicked];
            break;
            
        default:
            NSLog(@"无法辨识");
            break;
    }
    
}
- (void)TapClick {
    self.toolsView.hidden = !self.toolsView.hidden;
}
- (void)showToolsView {
    self.toolsView.hidden = NO;
}
- (void)hiddenToolsView {
    self.toolsView.hidden = YES;
}
- (void)toolsFullScreenDidClicked {
    if (self.superview == [UIApplication sharedApplication].keyWindow) {
        return;
    }
    [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft]forKey:@"orientation"];
    [self removeFromSuperview];
    self.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
    [NV_AVPlayer sharedInstance].v_render = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)toolsSmallScreenDidClicked {
    if (self.superview == self.xm_superView) {
        return;
    }
    [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait]forKey:@"orientation"];
    [self removeFromSuperview];
    self.frame = CGRectMake(0, 0, MainScreenWidth, 150);
    [NV_AVPlayer sharedInstance].v_render = self;
    [self.xm_superView addSubview:self];
}
#pragma mark - delegate
- (void)nv_avplayer:(NV_AVPlayer *)player didPlayStateChanged:(NV_AVPlayerState)state{

}
- (void)nv_avplayer:(NV_AVPlayer *)player didPlayProgressChanged:(CGFloat)second{

}
- (void)nv_avplayer:(NV_AVPlayer *)player didPlayProgressPercentChanged:(CGFloat)percent{

}
- (void)nv_avplayer:(NV_AVPlayer *)player didLoadedPercentChanged:(CGFloat)percent{

}- (void)didPlayerPlayToEnd:(NV_AVPlayer *)player {

}

- (void)setPlayURL:(NSString *)playURL {
    _playURL = playURL;
    [[NV_AVPlayer sharedInstance] playWithURL:[NSURL URLWithString:playURL] renderView:self delegate:self];
    [self performSelector:@selector(hiddenToolsView) withObject:self afterDelay:2.f];
}
- (XM_PlayToolsView *)toolsView {
    if (!_toolsView) {
        _toolsView = [[XM_PlayToolsView alloc]init];
        _toolsView.delegate = self;
    }
    return _toolsView;
}
@end
