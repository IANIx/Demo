//
//  XM_Model.h
//  Demo
//
//  Created by 薛佳妮 on 2017/9/7.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XM_ChannelModel : NSObject

@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *channelName;
@property (nonatomic, copy) NSString *channelNumer;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *playUrl;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *quality;
@property (nonatomic, copy) NSString *scheduleId;
@end

@interface XM_ChannelListModel : NSObject

@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, copy  ) NSString *message;
@property (nonatomic, assign  ) NSInteger pageCount;
@property (nonatomic, copy  ) NSArray *channels;
@end

@interface XM_Model : NSObject

@end
