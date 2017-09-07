//
//  XM_HttpURL.h
//  Demo
//
//  Created by 薛佳妮 on 2017/9/6.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#ifndef XM_HttpURL_h
#define XM_HttpURL_h


#define IP @"http://m.xmediatv.com:8888"

//#define IP @"http://10.10.122.23:8080"

#define XM_CATEGORY_URL         [NSString stringWithFormat:@"%@/v1/content/category",IP]
#define XM_CONTENTLIST_URL      [NSString stringWithFormat:@"%@/v1/content/list",IP]
#define XM_CHANELLIST_URL       [NSString stringWithFormat:@"%@/v1/channel/list",IP]

// 获取节目单
#define XM_CHANNELSCEDULES_URL  [NSString stringWithFormat:@"%@/v1/channel/schedules",IP]
#define XM_SPECIALLIST_URL      [NSString stringWithFormat:@"%@/v1/special/list",IP]

//查播放列表
#define XM_MENULIST_URL         [NSString stringWithFormat:@"%@/v1/menu/list",IP]
// 获取媒体内容详情
#define XM_CONTENTDETAIL_URL    [NSString stringWithFormat:@"%@/v1/content/detail",IP]
// 播放鉴权
#define XM_Play_URL              [NSString stringWithFormat:@"%@/v1/play/auth",IP]
// 获取节目单

#endif /* XM_HttpURL_h */
