//
//  AppDelegate.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Router.h"
//#import "AppDelegate+launchImage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerRouter];

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *tabbar = [XMRouter matchController:@"main"];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    [self showLaunchView];
    return YES;
}
- (void)showLaunchView {
    [self getStartupAnimation];
    self.LaunchView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.LaunchView.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:self.LaunchView];
    [self.window bringSubviewToFront:self.LaunchView];
}
- (void)getStartupAnimation {
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_STARTUPANIMATION_URL
                                     WithParams:@{@"mac":@"FC:D5:D9:02:F6:1A"}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   XM_StartupAnimationModel *model = [XM_StartupAnimationModel yy_modelWithDictionary:dic];
                                   if (model.resultCode == 0) {
                                       [self.LaunchView sd_setImageWithURL:[NSURL URLWithString:model.animation.url]];
                                       [self performSelector:@selector(removeLaunchView) withObject:self afterDelay:[model.animation.duration integerValue]];
                                   }
                               } WithFailurBlock:^(NSError *error) {
                                   if (error) {
                                       [self removeLaunchView];
                                   }
                               }];
}
- (void)removeLaunchView {
    [self.LaunchView removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
