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

@interface XM_AnimationModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;

@end

@interface XM_StartupAnimationModel : NSObject

@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, copy  ) NSString *message;
@property (nonatomic, strong) XM_AnimationModel *animation;

@end

@interface XM_MenuModel : NSObject

@property (nonatomic, copy  ) NSString *categoryId;
@property (nonatomic, copy  ) NSString *copyright_area;
@property (nonatomic, assign) NSInteger home;
@property (nonatomic, copy  ) NSString *icon;
@property (nonatomic, copy  ) NSString *menuId;
@property (nonatomic, copy  ) NSString *menuName;
@property (nonatomic, assign) NSInteger move;
@property (nonatomic, copy  ) NSString *poster;
@property (nonatomic, copy  ) NSString *recommendId;
@property (nonatomic, copy  ) NSString *sort;
@property (nonatomic, copy  ) NSString *style;
@property (nonatomic, copy  ) NSString *type;


@end

@interface XM_MenuListModel : NSObject

@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, copy  ) NSString *message;
@property (nonatomic, copy  ) NSString *posterPrefix;
@property (nonatomic, strong) NSArray<XM_MenuModel *> *menus;

@end

@interface XM_ContentModel : NSObject

@property (nonatomic, copy  ) NSString *mediaType;
@property (nonatomic, copy  ) NSString *contentId;
@property (nonatomic, copy  ) NSString *originalId;
@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, copy  ) NSString *type;
@property (nonatomic, copy  ) NSString *category;
@property (nonatomic, copy  ) NSString *productId;
@property (nonatomic, copy  ) NSString *score;
@property (nonatomic, copy  ) NSString *poster;
@property (nonatomic, copy  ) NSString *episodeTotal;
@property (nonatomic, copy  ) NSString *episodeUpdated;
@property (nonatomic, copy  ) NSString *hitCount;
@property (nonatomic, copy  ) NSString *markUrl;
@property (nonatomic, copy  ) NSString *quality;
@property (nonatomic, copy  ) NSString *duration;
@property (nonatomic, copy  ) NSString *markPosition;

@end

@interface XM_ContentListModel : NSObject

@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, copy  ) NSString *message;
@property (nonatomic, copy  ) NSString *categoryId;
@property (nonatomic, copy  ) NSString *categoryName;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSArray<XM_ContentModel *> *contents;

@end

@interface XM_PlayauthModel : NSObject

@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, copy  ) NSString  *message;
@property (nonatomic, copy  ) NSString  *contentId;
@property (nonatomic, copy  ) NSString  *playCode;
@property (nonatomic, copy  ) NSString  *playUrl;
@property (nonatomic, assign) NSInteger productId;

@end

@interface XM_rContentModel : NSObject

@property (nonatomic, copy  ) NSString *message;
@property (nonatomic, copy  ) NSString *duration;
@property (nonatomic, copy  ) NSString *episodeTotal;
@property (nonatomic, copy  ) NSString *episodeUpdated;
@property (nonatomic, copy  ) NSString *markPosition;
@property (nonatomic, copy  ) NSString *markUrl;
@property (nonatomic, copy  ) NSString *poster;
@property (nonatomic, copy  ) NSString *productId;
@property (nonatomic, copy  ) NSString *resAssetId;
@property (nonatomic, copy  ) NSString *sort;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *type;
@property (nonatomic, copy  ) NSString *url;

@end

@interface XM_RecommendModel : NSObject

@property (nonatomic, copy  ) NSString *message;
@property (nonatomic, copy  ) NSString *poster;
@property (nonatomic, copy  ) NSArray<XM_rContentModel *> *rContent;

@end

@interface XM_BannerMenuModel : NSObject

@property (nonatomic, copy  ) NSString *categoryId;
@property (nonatomic, copy  ) NSString *icon;
@property (nonatomic, copy  ) NSString *menuId;
@property (nonatomic, copy  ) NSString *menuName;
@property (nonatomic, copy  ) NSString *poster;
@property (nonatomic, copy  ) NSArray<XM_RecommendModel *> *recommend;
@property (nonatomic, copy  ) NSString *sort;
@property (nonatomic, copy  ) NSString *style;
@property (nonatomic, copy  ) NSString *type;

@end

@interface XM_MenuRecommendModel : NSObject

@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, copy  ) NSString  *message;
@property (nonatomic, copy  ) NSArray<XM_BannerMenuModel *>  *menus;

@end

@interface XM_Model : NSObject

@end
