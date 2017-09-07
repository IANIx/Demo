//
//  XM_Model.m
//  Demo
//
//  Created by 薛佳妮 on 2017/9/7.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XM_Model.h"

@implementation XM_ChannelModel

@end

@implementation XM_ChannelListModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"message" : @"description",
             @"pageCount" : @"pageCount",
             @"resultCode":@"resultCode",
             @"channels":@"channels"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"message" : @"description",
             @"pageCount" : @"pageCount",
             @"resultCode":@"resultCode",
             @"channels":[XM_ChannelModel class]};
}
@end

@implementation XM_AnimationModel


@end
@implementation XM_StartupAnimationModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"message" : @"description",
             @"resultCode":@"resultCode",
             @"animation":@"animation"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"message" : @"description",
             @"resultCode":@"resultCode",
             @"animation":[XM_AnimationModel class]};
}

@end
@implementation XM_Model


@end
