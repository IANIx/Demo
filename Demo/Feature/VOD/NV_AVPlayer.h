//
//  NV_AVPlayer.h
//  mynetvue
//
//  Created by 黄盼青 on 2017/3/29.
//  Copyright © 2017年 Netviewtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVAnimation.h>


//播放器状态
typedef NS_ENUM(NSInteger, NV_AVPlayerState) {
    
    NV_AVPlayerStateBuffering   = 1,   //缓冲中
    NV_AVPlayerStatePlaying     = 2,   //播放中
    NV_AVPlayerStateStopped     = 3,   //停止
    NV_AVPlayerStatePause       = 4    //暂停
    
};

@class NV_AVPlayer;

@protocol NV_AVPlayerDelegate <NSObject>

@optional


/**
 播放器状态改变

 @param player NV_AVPlayer
 @param state 播放器状态
 */
- (void)nv_avplayer:(NV_AVPlayer *)player didPlayStateChanged:(NV_AVPlayerState)state;


/**
 播放时间进度改变

 @param player NV_AVPlayer
 @param second 秒
 */
- (void)nv_avplayer:(NV_AVPlayer *)player didPlayProgressChanged:(CGFloat)second;


/**
 播放进度百分比改变

 @param player NV_AVPlayer
 @param percent 播放进度百分比(0-1)
 */
- (void)nv_avplayer:(NV_AVPlayer *)player didPlayProgressPercentChanged:(CGFloat)percent;


/**
 缓冲加载进度百分比改变

 @param player NV_AVPlayer
 @param percent 缓冲进度百分比(0-1)
 */
- (void)nv_avplayer:(NV_AVPlayer *)player didLoadedPercentChanged:(CGFloat)percent;



/**
 播放器播放结束

 @param player NV_AVPlayer
 */
- (void)didPlayerPlayToEnd:(NV_AVPlayer *)player;


@end

@interface NV_AVPlayer : NSObject

@property (nonatomic, readonly) NV_AVPlayerState state;                           //播放器状态
@property (nonatomic, readonly) CGFloat          loadedPercent;                   //缓冲进度(0-1)
@property (nonatomic, readonly) CGFloat          duration;                        //视频总时间(秒)
@property (nonatomic, readonly) CGFloat          current_progress;                //当前播放时间(秒)
@property (nonatomic, readonly) CGFloat          progress_percent;                //播放进度(0-1)
@property (nonatomic, readonly) NSURL            *play_url;                       //播放地址
@property (nonatomic, strong) UIView                   *v_render;                 //渲染视图
@property (nonatomic, strong) NSString           *resizeMode;                     //渲染模式


@property (nonatomic, weak    ) id<NV_AVPlayerDelegate> delegate;
/**
 *  @brief 获取单例
 *
 *  @return NVPlayer
 */
+ (instancetype)sharedInstance;

/**
 *  @brief 播放视频地址
 *
 *  @param url        视频地址
 *  @param renderView 渲染View
 */
- (void)playWithURL:(NSURL *)url
         renderView:(UIView *)renderView
           delegate:(id<NV_AVPlayerDelegate> )delegate;

/**
 *  @brief Seek进度
 *
 *  @param seconds 秒数
 */
- (void)seekToTime:(CGFloat)seconds;

/**
 *  @brief 恢复
 */
- (void)resume;

/**
 *  @brief 暂停
 */
- (void)pause;

/**
 *  @brief 停止
 */
- (void)stop;

/**
 *  @brief 重置播放器
 */
- (void)reset;


/**
 设置音量(0-1)

 @param volume 音量
 */
- (void)setAudioVolume:(CGFloat)volume;


/**
 静音
 */
- (void)mute;


/**
 解除静音
 */
- (void)unmute;


@end
