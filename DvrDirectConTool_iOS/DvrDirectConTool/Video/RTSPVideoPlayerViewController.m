//
//  RTSPVideoPlayerViewController.m
//  DvrDirectConTool
//
//  Created by 李治健 on 2020/9/21.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "RTSPVideoPlayerViewController.h"
#import <JMMonitorView/JMMonitorView.h>
#import <JMSmartMediaPlayer/JMSmartMediaPlayer.h>

@interface RTSPVideoPlayerViewController () <JMMediaNetworkPlayerDelegate>

@property (nonatomic,strong) JMMonitor *monitor;
@property (nonatomic,strong) JMMediaNetworkPlayer *mediaPlayer;
@property (nonatomic,strong) UIView *verticalToolView;
@property (nonatomic,strong) UIButton *switchHorizontalBtn;
@property (nonatomic,strong) UIButton *flipBtn;
@property (nonatomic,strong) UIButton *switchCameraBtn;

@property (nonatomic,assign) BOOL isFullScreen;

@end

@implementation RTSPVideoPlayerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mediaPlayer.sniffStreamEnable = YES;
    [self.mediaPlayer play:@"rtmp://58.200.131.2:1935/livetv/cctv15"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mediaPlayer deattachMonitor];
    self.mediaPlayer.delegate = nil;
    [self.mediaPlayer stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"摄像头".localized;
    
    [self.mediaPlayer attachMonitor:self.monitor];
    
    self.isFullScreen = YES;
    [self clickedSwitchHorizontalBtnAction:nil];
    
    [self.view addSubview:self.monitor];
    [self.view addSubview:self.verticalToolView];
}

- (JMMonitor *)monitor
{
    if (!_monitor) {
        _monitor = [[JMMonitor alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth(), 0)];
        _monitor.backgroundColor = [UIColor blackColor];
        _monitor.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _monitor;
}

- (JMMediaNetworkPlayer *)mediaPlayer
{
    if (!_mediaPlayer) {
        _mediaPlayer = [[JMMediaNetworkPlayer alloc] init];
        _mediaPlayer.delegate = self;
    }
    
    return _mediaPlayer;
}

- (UIView *)verticalToolView
{
    if (!_verticalToolView) {
        _verticalToolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth(), 48.0f)];
        _verticalToolView.backgroundColor = JMColorFromHex(@"#181E28");
        _verticalToolView.jm_top = self.monitor.jm_bottom;
        _verticalToolView.jm_centerX = self.view.jm_centerX;
        
        UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24.0f, 24.0f)];
        [playBtn setImage:@"icon_camera_pause".jm_toImage forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(clickedPlayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        playBtn.jm_left = 16.0f;
        playBtn.jm_centerY = _verticalToolView.jm_height/2.0;
        playBtn.tag = 1;
        [_verticalToolView addSubview:playBtn];
      
        _switchHorizontalBtn = [[UIButton alloc] initWithFrame:playBtn.bounds];
        [_switchHorizontalBtn setImage:@"icon_camera_enlarge".jm_toImage forState:UIControlStateNormal];
        [_switchHorizontalBtn addTarget:self action:@selector(clickedSwitchHorizontalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _switchHorizontalBtn.jm_right = _verticalToolView.jm_width - 16.0f;
        _switchHorizontalBtn.jm_centerY = playBtn.jm_centerY;
        [_verticalToolView addSubview:_switchHorizontalBtn];
        
        _flipBtn = [[UIButton alloc] initWithFrame:playBtn.bounds];
        [_flipBtn setImage:@"icon_camera_cutover".jm_toImage forState:UIControlStateNormal];
        [_flipBtn addTarget:self action:@selector(clickedFlipBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _flipBtn.jm_right = _switchHorizontalBtn.jm_left - 16.0f;
        _flipBtn.jm_centerY = playBtn.jm_centerY;
        [_verticalToolView addSubview:_flipBtn];
        
        _switchCameraBtn = [[UIButton alloc] initWithFrame:playBtn.bounds];
        [_switchCameraBtn setImage:@"icon_camera_flip".jm_toImage forState:UIControlStateNormal];
        [_switchCameraBtn addTarget:self action:@selector(clickedSwitchCameraBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _switchCameraBtn.jm_right = _flipBtn.jm_left - 16.0f;
        _switchCameraBtn.jm_centerY = playBtn.jm_centerY;
        [_verticalToolView addSubview:_switchCameraBtn];
    }
    
    return _verticalToolView;
}

- (void)switchSubViewLayout
{
    if (self.isFullScreen) {
        [UIView animateWithDuration:0.3 animations:^{
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
            self.isShowNavBarView = YES;
            
            self.monitor.transform = CGAffineTransformIdentity;
            self.monitor.jm_top = JMStatusBarHeight() + JMNavBarHeight();
            self.monitor.jm_left = 0;
            self.monitor.jm_width = JMScreenWidth();
            self.monitor.jm_height = self.monitor.jm_width / 640.0 * 480.0;
            [self.view sendSubviewToBack:self.monitor];
            
            self.verticalToolView.transform = CGAffineTransformIdentity;
            self.verticalToolView.backgroundColor = JMColorFromHex(@"#181E28");
            self.verticalToolView.jm_width = JMScreenWidth();
            self.verticalToolView.jm_height = 48.0f;
            self.verticalToolView.jm_top = self.monitor.jm_bottom;
            self.verticalToolView.jm_centerX = self.view.jm_centerX;
            
            self.switchHorizontalBtn.jm_right = self.verticalToolView.jm_width - 16.0f;
            [self.switchHorizontalBtn setImage:@"icon_camera_enlarge".jm_toImage forState:UIControlStateNormal];
            self.flipBtn.jm_right = self.switchHorizontalBtn.jm_left - 16.0f;
            self.switchCameraBtn.jm_right = self.flipBtn.jm_left - 16.0f;
        } completion:^(BOOL finished) {
            self.isFullScreen = false;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
            self.isShowNavBarView = NO;
            
            self.monitor.jm_height = JMScreenWidth();
            self.monitor.jm_width = JMScreenHeight();
            self.monitor.center = self.view.center;
            self.monitor.transform = CGAffineTransformMakeRotation(M_PI_2);
            
            self.verticalToolView.backgroundColor = JMColorFromHex(@"#66181E28");
            self.verticalToolView.jm_width = JMScreenHeight();
            self.verticalToolView.jm_centerY = self.view.jm_centerY;
            self.verticalToolView.jm_centerX = self.verticalToolView.jm_height/2.0;
            self.verticalToolView.transform = CGAffineTransformMakeRotation(M_PI_2);
            
            self.switchHorizontalBtn.jm_right = self.verticalToolView.jm_height - 16.0f;
            [self.switchHorizontalBtn setImage:@"icon_camera_shrink".jm_toImage forState:UIControlStateNormal];
            self.flipBtn.jm_right = self.switchHorizontalBtn.jm_left - 16.0f;
            self.switchCameraBtn.jm_right = self.flipBtn.jm_left - 16.0f;
        } completion:^(BOOL finished) {
            self.isFullScreen = true;
        }];
    }
}

#pragma mark -

- (void)clickedPlayBtnAction:(UIButton *)btn
{
    if (btn.tag == 1) {
        [self.mediaPlayer stop];
        btn.tag = 0;
        [btn setImage:@"icon_camera_play".jm_toImage forState:UIControlStateNormal];
    } else {
        [self.mediaPlayer play:@"rtmp://58.200.131.2:1935/livetv/cctv15"];
        btn.tag = 1;
        [btn setImage:@"icon_camera_pause".jm_toImage forState:UIControlStateNormal];
    }
}

- (void)clickedSwitchHorizontalBtnAction:(UIButton *)btn
{
    [self switchSubViewLayout];
}

- (void)clickedFlipBtnAction:(UIButton *)btn
{
    
}

- (void)clickedSwitchCameraBtnAction:(UIButton *)btn
{
    
}

#pragma mark - JMMediaNetworkPlayerDelegate

- (void)didJMMediaNetworkPlayerPlay:(JMMediaNetworkPlayer *_Nonnull)player status:(enum JM_MEDIA_PLAY_STATUS)status error:(JMError *_Nullable)error
{
    NSLog(@"didJMMediaNetworkPlayerPlay:%d", status);
}

- (void)didJMMediaNetworkPlayerRecord:(JMMediaNetworkPlayer *_Nonnull)player status:(enum JM_MEDIA_RECORD_STATUS)status path:(NSString *_Nullable)filePath error:(JMError *_Nullable)error
{
    
}

- (void)didJMMediaNetworkPlayerPlayInfo:(JMMediaNetworkPlayer *_Nonnull)player playInfo:(JMMediaPlayInfo *)playInfo
{
    
}

@end
