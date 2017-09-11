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

@implementation XM_MenuModel


@end

@implementation XM_MenuListModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"message" : @"description",
             @"resultCode":@"resultCode",
             @"posterPrefix":@"posterPrefix",
             @"menus":@"menus"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"message" : @"description",
             @"resultCode":@"resultCode",
             @"posterPrefix":@"posterPrefix",
             @"menus":[XM_MenuModel class]};
}

@end

@implementation XM_ContentModel


@end
@implementation XM_ContentListModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"message" : @"description",
             @"resultCode":@"resultCode",
             @"categoryId":@"categoryId",
             @"categoryName":@"categoryName",
             @"pageCount":@"pageCount",
             @"contents":@"contents"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"message" : @"description",
             @"resultCode":@"resultCode",
             @"categoryId":@"categoryId",
             @"categoryName":@"categoryName",
             @"pageCount":@"pageCount",
             @"contents":[XM_ContentModel class]};
}

@end

@implementation XM_PlayauthModel


@end

@implementation XM_rContentModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"message" : @"description",
             @"duration":@"duration",
             @"episodeTotal":@"episodeTotal",
             @"episodeUpdated":@"episodeUpdated",
             @"markPosition":@"markPosition",
             @"markUrl":@"markUrl",
             @"poster":@"poster",
             @"productId":@"productId",
             @"resAssetId":@"resAssetId",
             @"sort":@"sort",
             @"title":@"title",
             @"type":@"type",
             @"url":@"url"};
}

@end

@implementation XM_RecommendModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"message" : @"description",
             @"poster":@"poster",
             @"rContent":@"rContent"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"message" : @"description",
             @"poster":@"poster",
             @"rContent":[XM_rContentModel class]};
}

@end

@implementation XM_BannerMenuModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"categoryId" : @"categoryId",
             @"icon":@"icon",
             @"menuId":@"menuId",
             @"menuName":@"menuName",
             @"poster":@"poster",
             @"sort":@"sort",
             @"style":@"style",
             @"type":@"type",
             @"recommend":@"recommend"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"categoryId" : @"categoryId",
             @"icon":@"icon",
             @"menuId":@"menuId",
             @"menuName":@"menuName",
             @"poster":@"poster",
             @"sort":@"sort",
             @"style":@"style",
             @"type":@"type",
             @"recommend":[XM_RecommendModel class]};
}


@end

@implementation XM_MenuRecommendModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"message" : @"description",
             @"resultCode":@"resultCode",
             @"menus":@"menus"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"message" : @"description",
             @"resultCode":@"resultCode",
             @"menus":[XM_BannerMenuModel class]};
}


@end
@implementation XM_Model


@end
