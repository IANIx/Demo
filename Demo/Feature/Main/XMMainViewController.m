//
//  XMMainViewController.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMMainViewController.h"

@interface XMMainViewController ()

@end

@implementation XMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *v1 = [XMRouter matchController:@"main/vod"];
    UIViewController *v2 = [XMRouter matchController:@"main/live"];
    UIViewController *v3 = [XMRouter matchController:@"main/vip"];
    UIViewController *v4 = [XMRouter matchController:@"main/me"];
    v1.title = @"VOD";
    v2.title = @"Live";
    v3.title = @"VIP";
    v4.title = @"Me";
    v1.tabBarItem.selectedImage = [UIImage imageNamed:@"main_tabbar_Vod_select"];
    v1.tabBarItem.image = [UIImage imageNamed:@"main_tabbar_Vod_nomal"];
    v2.tabBarItem.selectedImage = [UIImage imageNamed:@"main_tabbar_live_select"];
    v2.tabBarItem.image = [UIImage imageNamed:@"main_tabbar_live_nomal"];
    v3.tabBarItem.selectedImage = [UIImage imageNamed:@"main_tabbar_vip_select"];
    v3.tabBarItem.image = [UIImage imageNamed:@"main_tabbar_vip_nomal"];
    v4.tabBarItem.selectedImage = [UIImage imageNamed:@"main_tabbar_me_select"];
    v4.tabBarItem.image = [UIImage imageNamed:@"main_tabbar_me_nomal"];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor purpleColor],
                                                       NSForegroundColorAttributeName,
                                                       [UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil] forState:UIControlStateSelected];

    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:v1];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:v2];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:v3];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:v4];
    self.viewControllers = @[nav1,nav2,nav3,nav4];
    
    self.tabBar.barTintColor = XM_COMMON_BG_COLOR;
    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
