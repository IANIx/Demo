//
//  AppDelegate+Router.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "AppDelegate+Router.h"
#import "XMMeViewController.h"
#import "XMVipViewController.h"
#import "XMVODViewController.h"
#import "XMLiveViewController.h"
#import "XMMainViewController.h"
#import "XMMoreViewController.h"
#import "XMDeatilViewController.h"
#import "XMChannelPlayViewController.h"

@implementation AppDelegate (Router)

- (void)registerRouter {
    
    [XMRouter map:@"main" toControllerClass:[XMMainViewController class]];
    
    /**主页面四个页面*/
    [XMRouter map:@"main/me" toControllerClass:[XMMeViewController class]];
    [XMRouter map:@"main/vip" toControllerClass:[XMVipViewController class]];
    [XMRouter map:@"main/vod" toControllerClass:[XMVODViewController class]];
    [XMRouter map:@"main/live" toControllerClass:[XMLiveViewController class]];
    
    /**vod点击进去的页面*/
    [XMRouter map:@"vod/more" toControllerClass:[XMMoreViewController class]];
    [XMRouter map:@"vod/detail" toControllerClass:[XMDeatilViewController class]];
    
    [XMRouter map:@"live/play" toControllerClass:[XMChannelPlayViewController class]];
    
    
}
@end
