//
//  NV_AVPlayer.m
//  mynetvue
//
//  Created by 黄盼青 on 2017/3/29.
//  Copyright © 2017年 Netviewtech. All rights reserved.
//

#import "NV_AVPlayer.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>


@interface NV_AVPlayer ()


@property (nonatomic        ) NV_AVPlayerState         state;               //播放器状态
@property (nonatomic        ) CGFloat                  loadedPercent;       //缓冲进度
@property (nonatomic        ) CGFloat                  duration;            //视频总时间
@property (nonatomic        ) CGFloat                  current_progress;    //当前播放时间
@property (nonatomic        ) CGFloat                  progress_percent;    //播放进度(0~1)
@property (nonatomic        ) BOOL                     isPauseByUser;       //是否用户暂停


@property (nonatomic, strong) AVPlayer                 *player;             //播放器
@property (nonatomic, strong) AVPlayerLayer            *currentPlayerLayer; //播放图层
@property (nonatomic, strong) AVPlayerItem             *currentPlayerItem;  //当前的播放Item
@property (nonatomic, strong) NSObject                 *playbackTimeObserver;


@property (nonatomic, strong) UIView                   *v_player;           //播放器视图


@property (nonatomic, strong) UIActivityIndicatorView  *v_loadingIndicator; //加载菊花转
@property (nonatomic, strong) NSURL                    *play_url;           //播放地址
@property (nonatomic, assign) CGFloat                  volume;              //音量

@end

@implementation NV_AVPlayer

#pragma mark - LifeCycle

+ (instancetype)sharedInstance {
    
    static NV_AVPlayer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[NV_AVPlayer alloc] init];
        
    });
    
    return instance;
    
}

- (instancetype)init {
    
    self = [super init];
    if(self) {
        
        _state = NV_AVPlayerStateStopped;
        self.volume = 1.0f;
        
        
    }
    
    return self;
    
}

- (void)addObserverAndNotification
{
    
    [self monitoringPlayback:self.currentPlayerItem];// 监听播放状态
    
    [self.currentPlayerItem addObserver:self
                             forKeyPath:@"status"
                                options:NSKeyValueObservingOptionNew
                                context:nil];
    
    [self.currentPlayerItem addObserver:self
                             forKeyPath:@"loadedTimeRanges"
                                options:NSKeyValueObservingOptionNew
                                context:nil];
    
    [self.currentPlayerItem addObserver:self
                             forKeyPath:@"playbackBufferEmpty"
                                options:NSKeyValueObservingOptionNew
                                context:nil];
    
    [self.currentPlayerItem addObserver:self
                             forKeyPath:@"playbackLikelyToKeepUp"
                                options:NSKeyValueObservingOptionNew
                                context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackground)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterForeground)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidPlayToEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.currentPlayerItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidPlayToEnd:)
                                                 name:AVPlayerItemFailedToPlayToEndTimeNotification
                                               object:self.currentPlayerItem];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemPlaybackStalled:)
                                                 name:AVPlayerItemPlaybackStalledNotification
                                               object:self.currentPlayerItem];
    
}


- (void)removeObserverAndNotification
{
    
    if (self.currentPlayerItem) {
        
        [self.currentPlayerItem removeObserver:self forKeyPath:@"status"];
        [self.currentPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [self.currentPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [self.currentPlayerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        [self.player removeTimeObserver:self.playbackTimeObserver];
        self.playbackTimeObserver = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        [self.player replaceCurrentItemWithPlayerItem:nil];
        
    }
}


#pragma mark - 播放控制 - Private

/**
 *  @brief 释放播放器监听属性
 */
- (void)releasePlayer {
    
    //如果没有播放过，就不用释放了
    if (!self.currentPlayerItem) return;
    
    [self removeObserverAndNotification];
    
    [self.currentPlayerLayer removeFromSuperlayer];
    self.player = nil;
    self.currentPlayerLayer = nil;
    self.currentPlayerItem = nil;
    
    self.isPauseByUser = NO;
    
    self.loadedPercent = 0;
    self.duration = 0;
    self.current_progress = 0;
    
    
    self.v_player.backgroundColor = [UIColor clearColor];
    
}

/**
 *  @brief 暂停几秒钟用于缓冲
 */
- (void)bufferingSomeSecond {
    
    // playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
    static BOOL isBuffering = NO;
    if (isBuffering) {
        return;
    }
    isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self.player pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 如果此时用户已经暂停了，则不再需要开启播放了
        if (self.isPauseByUser) {
            isBuffering = NO;
            return;
        }
        
        [self.player play];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.currentPlayerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }else {
            [self.v_loadingIndicator stopAnimating];
        }
    });
    
}


/**
 计算缓冲加载进度

 @param playerItem AVPlayerItem
 */
- (void)calculateLoadedPercent:(AVPlayerItem *)playerItem {
    
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
    CMTime duration = playerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration);
    
    self.loadedPercent = timeInterval / totalDuration;
    
}


#pragma mark - 播放控制 - Public
/**
 *  @brief 播放视频地址
 *
 *  @param url        视频地址
 *  @param renderView 渲染视图
 */
- (void)playWithURL:(NSURL *)url
         renderView:(UIView *)renderView
           delegate:(id<NV_AVPlayerDelegate>)delegate {
    
    _v_render = renderView;
    self.play_url = url;
    self.delegate = delegate;
    
    [self releasePlayer];
    
    self.currentPlayerItem = [[AVPlayerItem alloc ]initWithURL:url];
    
    if (!self.player) {
        self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
    } else {
        [self.player replaceCurrentItemWithPlayerItem:self.currentPlayerItem];
    }
    
    self.player.volume = self.volume;
    
    self.currentPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.currentPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.currentPlayerLayer.frame = CGRectMake(0.0f,
                                               0.0f,
                                               self.v_render.bounds.size.width,
                                               self.v_render.bounds.size.height);
    

    self.v_player.frame = renderView.bounds;
    [self.v_player.layer insertSublayer:self.currentPlayerLayer atIndex:0];
    
    
    [self.v_render insertSubview:self.v_player atIndex:0];
    
    
    
    [self addObserverAndNotification];
    
}


/**
 停止播放
 */
-(void)stop {
    
    if(!self.currentPlayerItem) return;
    
    self.isPauseByUser = YES;
    self.duration = 0;
    self.current_progress = 0;
    [self.player pause];
    self.state = NV_AVPlayerStateStopped;
    
    [self releasePlayer];
    
}


/**
 Seek播放进度
 
 @param seconds 秒
 */
-(void)seekToTime:(CGFloat)seconds {
    
    if (self.state == NV_AVPlayerStateStopped) return;
    
    seconds = MAX(0, seconds);
    seconds = MIN(seconds, self.duration);
    
    [self.player pause];
    [self.player seekToTime:CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        
        if(!_isPauseByUser) {
            [self.player play];
        }
        
        if (!self.currentPlayerItem.isPlaybackLikelyToKeepUp) {
            self.state = NV_AVPlayerStateBuffering;
            [self.v_loadingIndicator startAnimating];
            self.v_loadingIndicator.hidden = NO;
        }
        
    }];
    
    [self.player seekToTime:CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC)
            toleranceBefore:kCMTimeZero
             toleranceAfter:kCMTimeZero];
    
    if(!_isPauseByUser) {
        [self.player play];
    }
    
    if (!self.currentPlayerItem.isPlaybackLikelyToKeepUp) {
        self.state = NV_AVPlayerStateBuffering;
        [self.v_loadingIndicator startAnimating];
        self.v_loadingIndicator.hidden = NO;
    }
    
}


/**
 恢复播放
 */
-(void)resume {
    
    if(!self.currentPlayerItem) return;
    
    self.isPauseByUser = NO;
    self.state = NV_AVPlayerStatePlaying;
    [self.player play];
}


/**
 暂停播放
 */
-(void)pause {
    
    if(!self.currentPlayerItem) return;
    
    self.isPauseByUser = YES;
    self.state = NV_AVPlayerStatePause;
    [self.player pause];
    
}


/**
 重置播放器
 */
- (void)reset {
    
    [self stop];
    self.play_url = nil;
    
    [self releasePlayer];
    
    [self.v_player removeFromSuperview];
    
}

- (void)setAudioVolume:(CGFloat)volume {
    
    if (!self.currentPlayerItem) return;
    
    self.player.volume = volume;
    
}

- (void)mute {
    
    self.volume = 0.0f;
    
    if (self.state != NV_AVPlayerStateStopped) {
        self.player.volume = self.volume;
    }
    
}

- (void)unmute {
    
    self.volume = 1.0f;
    
    if (self.state != NV_AVPlayerStateStopped) {
        self.player.volume = self.volume;
    }
    
}


#pragma mark - Key Value Observe

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    //监听播放器状态
    if ([keyPath isEqualToString:@"status"]) {
        
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            
            self.state = NV_AVPlayerStatePlaying;
            
            // 给播放器添加计时器
            [self monitoringPlayback:playerItem];
            
        } else if([playerItem status] == AVPlayerStatusFailed
                  || [playerItem status] == AVPlayerStatusUnknown) {
            [self stop];
            
        }
        
        return;
    }
    
    //监听播放器的缓冲进度
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        //TODO: 计算缓缓冲进度
        [self calculateLoadedPercent:playerItem];
        return;
    }
    
    
    //监听播放器的缓冲Empty状态
    if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        
        if (playerItem.isPlaybackBufferEmpty) {
            self.state = NV_AVPlayerStateBuffering;
            
            //显示菊花转
            [self.v_loadingIndicator startAnimating];
            self.v_loadingIndicator.hidden = NO;
            
            //暂停几秒钟用于缓冲
            [self bufferingSomeSecond];
            
        }
        
        
        return;
    }
    
}



#pragma mark - 监听事件

/**
 *  @brief 应用退到后台
 */
- (void)appDidEnterBackground {
    
    if (self.state != NV_AVPlayerStateStopped) {
        [self pause];
        self.isPauseByUser = NO;
    }
    
}

/**
 *  @brief 应用恢复运行
 */
- (void)appDidEnterForeground {
    
    if(!self.isPauseByUser && self.state == NV_AVPlayerStatePause) {
        [self resume];
    }
    
}

/**
 *  @brief 当前视频播放完了
 *
 *  @param notification Notification
 */
- (void)playerItemDidPlayToEnd:(NSNotification *)notification {
    [self stop];
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(didPlayerPlayToEnd:)]) {
            
            [self.delegate didPlayerPlayToEnd:self];
            
        }
        
    });
    
}

/**
 *  @brief 视频太卡，进入缓冲状态了
 *
 *  @param notification Notification
 */
- (void)playerItemPlaybackStalled:(NSNotification *)notification {
//    NVLogDebug(@"Video Buffering...");
}


/**
 *  @brief 监听播放进度
 *
 *  @param playerItem AVPlayerItem
 */
- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    
    //视频总时间
    self.duration = (double)playerItem.duration.value / playerItem.duration.timescale;
    
    [self.player play];
    
    //更新时间
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        // 计算当前在第几秒
        float currentPlayTime = (double)playerItem.currentTime.value/playerItem.currentTime.timescale;
        weakSelf.current_progress = currentPlayTime;
        weakSelf.progress_percent = currentPlayTime / weakSelf.duration;
        
    }];
}


#pragma mark - GET/SET

- (void)setCurrent_progress:(CGFloat)current_progress {
    
    _current_progress = current_progress;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(nv_avplayer:didPlayProgressChanged:)]) {
            
            [self.delegate nv_avplayer:self didPlayProgressChanged:self.current_progress];
        }
        
    });
    
}

- (void)setProgress_percent:(CGFloat)progress_percent {
    
    _progress_percent = progress_percent;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(nv_avplayer:didPlayProgressPercentChanged:)]) {
            
            [self.delegate nv_avplayer:self didPlayProgressPercentChanged:self.progress_percent];
            
        }
        
    });
    
    
}

- (void)setState:(NV_AVPlayerState)state {
    
    if (_state != state) {
        
        _state = state;
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if ([self.delegate respondsToSelector:@selector(nv_avplayer:didPlayStateChanged:)]) {
                
                [self.delegate nv_avplayer:self didPlayStateChanged:self.state];
                
            }
            
            
        });
        
    }
    
}

- (void)setLoadedPercent:(CGFloat)loadedPercent {
    
    _loadedPercent = loadedPercent;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(nv_avplayer:didLoadedPercentChanged:)]) {
            
            [self.delegate nv_avplayer:self didLoadedPercentChanged:self.loadedPercent];
            
        }
        
        
    });
    
}


/**
 *  @brief 菊花转
 *
 *  @return UIActivityIndicatorView
 */
- (UIActivityIndicatorView *)v_loadingIndicator {
    
    if (!_v_loadingIndicator) {
        
        _v_loadingIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _v_loadingIndicator.hidesWhenStopped = YES;
        [_v_loadingIndicator stopAnimating];
        
        
    }
    
    return _v_loadingIndicator;
    
}

- (UIView *)v_player {
    
    if (!_v_player) {
        
        _v_player = [[UIView alloc] init];
        
        [_v_player addSubview:self.v_loadingIndicator];
        [self.v_loadingIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_v_player);
        }];
        
    }
    
    return _v_player;
}

- (void)setResizeMode:(NSString *)resizeMode {
    
    _resizeMode = resizeMode;
    
    if (self.currentPlayerLayer) {
        
        self.currentPlayerLayer.videoGravity = resizeMode;
    }
    
}

- (void)setV_render:(UIView *)v_render {
    
    _v_render = v_render;
    
    if (self.currentPlayerLayer) {
        
        self.currentPlayerLayer.frame = CGRectMake(0.0f,
                                                   0.0f,
                                                   self.v_render.bounds.size.width,
                                                   self.v_render.bounds.size.height);
        
    }
    
}

@end
