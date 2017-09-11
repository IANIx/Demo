//
//  XMRouter.h
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMRouter : NSObject
/**
 设置控制器路由
 
 @param route 路由地址
 @param controllerClass 控制器Class
 */
+ (void)map:(NSString *)route toControllerClass:(Class)controllerClass;


/**
 获取控制器
 
 @param route 路由地址
 @return 生成的控制器
 */
+ (UIViewController *)matchController:(NSString *)route;


/**
 获取控制器并传入字典，字典会修改控制器相应的ivar属性
 
 @param route 路由地址
 @param dic 传入的字典
 @return 生成的控制器
 */
+ (UIViewController *)matchController:(NSString *)route withDic:(NSDictionary *)dic;


/**
 当前的ViewController
 
 @return UIViewController
 */
+ (UIViewController *)currentViewController;


@end
