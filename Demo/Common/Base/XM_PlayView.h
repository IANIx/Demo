//
//  XM_PlayView.h
//  XMediaTV
//
//  Created by 李勇杰 on 2017/9/9.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NV_AVPlayer.h"

@protocol ToolsDelegate <NSObject>

- (void)toolsFullScreenDidClicked;
- (void)toolsSmallScreenDidClicked;

@end
@interface XM_PlayToolsView : UIView

@property (nonatomic, strong) UIButton  *playButton;
@property (nonatomic, strong) UIButton  *nextButton;
@property (nonatomic, strong) UISlider  *slider;
@property (nonatomic, strong) UIButton  *fullScreenButton;

@property (nonatomic, weak  ) id<ToolsDelegate> delegate;

@end

@interface XM_PlayView : UIView<NV_AVPlayerDelegate,ToolsDelegate>

@property (nonatomic, strong) NV_AVPlayer *player;
@property (nonatomic, strong) XM_PlayToolsView *toolsView;
@property (nonatomic, strong) UIView  *xm_superView;
@property (nonatomic, copy  ) NSString *playURL;
@end
