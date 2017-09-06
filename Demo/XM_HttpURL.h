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

#define XM_CATEGORY_URL         [NSString stringWithFormat:@"%@/v1/content/category",IP]
#define XM_CONTENTLIST_URL      [NSString stringWithFormat:@"%@/v1/content/list",IP]
#define XM_CHANELLIST_URL       [NSString stringWithFormat:@"%@/v1/channel/list",IP]
#define XM_CHANNELSCEDULES_URL  [NSString stringWithFormat:@"%@/v1/channel/schedules",IP]
#endif /* XM_HttpURL_h */
