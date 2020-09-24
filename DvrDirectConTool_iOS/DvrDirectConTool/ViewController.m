//
//  ViewController.m
//  DvrDirectConTool
//
//  Created by 李治健 on 2020/9/9.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DeviceDebugViewController.h"
#import "RTSPVideoPlayerViewController.h"
#import "DeviceSettingViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *topDevicePreview;

@property (nonatomic, strong) UILabel *deviceNameLB;
@property (nonatomic, strong) UILabel *deviceImeiLB;
@property (nonatomic, strong) UIButton *refreshInfoBtn;

@property (nonatomic, strong) UILabel *deviceNetSignalLB;
@property (nonatomic, strong) UILabel *deviceStorageLB;
@property (nonatomic, strong) UILabel *deviceGpsSignalLB;
@property (nonatomic, strong) UILabel *deviceHardwareVersionLB;
@property (nonatomic, strong) UILabel *deviceSoftwareVersionLB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topDevicePreview];
    
    [self loadBottomFunBtnView];
    [self loadDeviceMainInfo];
}

- (UIImageView *)topDevicePreview
{
    if (!_topDevicePreview) {
        UIImage *img = [UIImage imageNamed:@"pic_homepage_device_bg"];
        _topDevicePreview = [[UIImageView alloc] initWithImage:img];
        _topDevicePreview.frame = CGRectMake(0, 0, JMScreenWidth(), img.size.height/img.size.width*JMScreenWidth());
    }
    
    return _topDevicePreview;
}

- (void)loadBottomFunBtnView
{
    UIButton *mediaFtpBtn = [[UIButton alloc] init];
    [mediaFtpBtn setBackgroundImage:@"pic_homepage_features_bg".jm_toImage forState:UIControlStateNormal];
    [mediaFtpBtn setImage:@"icon_homepage_synchronization".jm_toImage forState:UIControlStateNormal];
    [mediaFtpBtn setTitle:@"媒体同步".localized forState:UIControlStateNormal];
    mediaFtpBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [mediaFtpBtn addTarget:self action:@selector(clickedMediaFtpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mediaFtpBtn];
    
    UIButton *cameraBtn = [[UIButton alloc] init];
    [cameraBtn setBackgroundImage:@"pic_homepage_features_bg".jm_toImage forState:UIControlStateNormal];
    [cameraBtn setImage:@"icon_homepage_camera".jm_toImage forState:UIControlStateNormal];
    [cameraBtn setTitle:@"摄像头".localized forState:UIControlStateNormal];
    cameraBtn.titleLabel.font = mediaFtpBtn.titleLabel.font;
    [cameraBtn addTarget:self action:@selector(clickedCameraBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraBtn];
    
    UIButton *debugBtn = [[UIButton alloc] init];
    [debugBtn setBackgroundImage:@"pic_homepage_features_bg".jm_toImage forState:UIControlStateNormal];
    [debugBtn setImage:@"icon_homepage_debugging".jm_toImage forState:UIControlStateNormal];
    [debugBtn setTitle:@"调试".localized forState:UIControlStateNormal];
    debugBtn.titleLabel.font = mediaFtpBtn.titleLabel.font;
    [debugBtn addTarget:self action:@selector(clickedDebugBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:debugBtn];
    
    UIButton *settingBtn = [[UIButton alloc] init];
    [settingBtn setBackgroundImage:@"pic_homepage_features_bg".jm_toImage forState:UIControlStateNormal];
    [settingBtn setImage:@"icon_homepage_setting".jm_toImage forState:UIControlStateNormal];
    [settingBtn setTitle:@"设置".localized forState:UIControlStateNormal];
    settingBtn.titleLabel.font = mediaFtpBtn.titleLabel.font;
    [settingBtn addTarget:self action:@selector(clickedSettingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];

    NSMutableArray *distributeViewArray = [NSMutableArray arrayWithObjects:cameraBtn, mediaFtpBtn, debugBtn, settingBtn, nil];
    [distributeViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24.0 leadSpacing:24.0 tailSpacing:24.0];
    [distributeViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(89.0f);
        make.bottom.mas_equalTo(-24);
    }];
    
    [mediaFtpBtn jm_layoutWithEdgeInsetsStyle:JMButtonEdgeInsetsStyleTop imageTitleSpace:8.0];
    [cameraBtn jm_layoutWithEdgeInsetsStyle:JMButtonEdgeInsetsStyleTop imageTitleSpace:8.0];
    [debugBtn jm_layoutWithEdgeInsetsStyle:JMButtonEdgeInsetsStyleTop imageTitleSpace:8.0];
    [settingBtn jm_layoutWithEdgeInsetsStyle:JMButtonEdgeInsetsStyleTop imageTitleSpace:8.0];
}

- (void)loadDeviceMainInfo
{
    if (!_deviceNameLB) {
        self.deviceNameLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth()/3.0*2.0, 32.0)];
        self.deviceNameLB.font = [UIFont boldSystemFontOfSize:32.0f];
        self.deviceNameLB.textColor = JMColorFromHex(@"#181E28");
        self.deviceNameLB.jm_top = self.topDevicePreview.jm_bottom - 15.0f;
        self.deviceNameLB.jm_left = 24.0f;
        self.deviceNameLB.text = @"JC400";
        [self.view addSubview:self.deviceNameLB];
    }
    
    if (!_deviceImeiLB) {
        self.deviceImeiLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.deviceNameLB.jm_width, 14.0)];
        self.deviceImeiLB.font = [UIFont systemFontOfSize:12.0f];
        self.deviceImeiLB.textColor = JMColorFromHex(@"#5A6482");
        self.deviceImeiLB.jm_top = self.deviceNameLB.jm_bottom + 8.0f;
        self.deviceImeiLB.jm_left = self.deviceNameLB.jm_left;
        self.deviceImeiLB.text = @"IMEI：unknown";
        [self.view addSubview:self.deviceImeiLB];
    }
    
    if (!_refreshInfoBtn) {
        self.refreshInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
        [self.refreshInfoBtn setImage:@"icon_homepage_refresh".jm_toImage forState:UIControlStateNormal];
        self.refreshInfoBtn.jm_right = JMScreenWidth() - 24.0f;
        self.refreshInfoBtn.jm_top = self.deviceNameLB.jm_top + 7.0f;
        [self.refreshInfoBtn addTarget:self action:@selector(clickedRefreshInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.refreshInfoBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5f)];
        lineView.backgroundColor = JMColorFromHex(@"#E8ECF5");
        lineView.jm_top = self.deviceImeiLB.jm_bottom + 16.0f;
        lineView.jm_left = self.deviceNameLB.jm_left;
        lineView.jm_width = JMScreenWidth() - lineView.jm_left*2;
        [self.view addSubview:lineView];
    }
    
    [self loadDeviceDetailedInfo];
}

- (void)loadDeviceDetailedInfo
{
    if (!_deviceNetSignalLB) {
        self.deviceNetSignalLB = [self createSingleDetailedInfo:@"网络信号".localized infoStr:@"GPS 10" point:CGPointMake(self.deviceImeiLB.jm_left, self.deviceImeiLB.jm_bottom + 32.0f)];
    }
    if (!_deviceGpsSignalLB) {
        self.deviceGpsSignalLB = [self createSingleDetailedInfo:@"GPS信号".localized infoStr:@"-95db" point:CGPointMake(self.deviceNetSignalLB.jm_left, self.deviceNetSignalLB.jm_bottom + 15.0f)];
    }
    if (!_deviceSoftwareVersionLB) {
        self.deviceSoftwareVersionLB = [self createSingleDetailedInfo:@"软件版本".localized infoStr:@"202006KMSJC400" point:CGPointMake(self.deviceNetSignalLB.jm_left, self.deviceGpsSignalLB.jm_bottom + 15.0f)];
    }
    
    if (!_deviceStorageLB) {
        self.deviceStorageLB = [self createSingleDetailedInfo:@"内存卡容量".localized infoStr:@"59GB/119GB" point:CGPointMake(JMScreenWidth()/2.0, self.deviceImeiLB.jm_bottom + 32.0f)];
    }
    if (!_deviceHardwareVersionLB) {
        self.deviceHardwareVersionLB = [self createSingleDetailedInfo:@"硬件版本".localized infoStr:@"JMC28 V5.0" point:CGPointMake(self.deviceStorageLB.jm_left, self.deviceNetSignalLB.jm_bottom + 15.0f)];
    }
}

- (UILabel *)createSingleDetailedInfo:(NSString *)name infoStr:(NSString *)infoStr point:(CGPoint)point
{
    UILabel *nameLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth()/2.0, 17.0)];
    nameLB.font = [UIFont systemFontOfSize:12.0f];
    nameLB.textColor = JMColorFromHex(@"#8690A9");
    nameLB.jm_left = point.x;
    nameLB.jm_top = point.y;
    nameLB.text = name;
    [self.view addSubview:nameLB];
    
    UILabel *detailedLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.deviceNameLB.jm_width, 22.0)];
    detailedLB.font = [UIFont systemFontOfSize:16.0f];
    detailedLB.textColor = JMColorFromHex(@"#5A6482");
    detailedLB.jm_top = nameLB.jm_bottom + 4.0f;
    detailedLB.jm_left = nameLB.jm_left;
    detailedLB.text = infoStr;
    [self.view addSubview:detailedLB];
    
    return detailedLB;
}

#pragma mark - BtnAction

- (void)clickedCameraBtnAction:(UIButton *)btn
{
    RTSPVideoPlayerViewController *viewCtl = [[RTSPVideoPlayerViewController alloc] init];
    JMBaseNavigationController *navViewCtl = [[JMBaseNavigationController alloc] initWithRootViewController:viewCtl];
    viewCtl.isHideNavBar = YES;
    viewCtl.isShowNavBarView = YES;
    viewCtl.barTitleColor = JMColorFromHex(@"#181E28");
    viewCtl.barTitleFont = [UIFont boldSystemFontOfSize:16.0f];
    viewCtl.view.backgroundColor = JMColorFromHex(@"#E8ECF5");
    [viewCtl.navLeftBtn setImage:@"icon_navibar_back_dark".jm_toImage forState:UIControlStateNormal];
    
    [self presentViewController:navViewCtl animated:YES completion:nil];
}

- (void)clickedMediaFtpBtnAction:(UIButton *)btn
{
    
}

- (void)clickedDebugBtnAction:(UIButton *)btn
{
    DeviceDebugViewController *viewCtl = [[DeviceDebugViewController alloc] init];
    JMBaseNavigationController *navViewCtl = [[JMBaseNavigationController alloc] initWithRootViewController:viewCtl];
    viewCtl.isHideNavBar = YES;
    viewCtl.isShowNavBarView = YES;
    viewCtl.barTitleColor = [UIColor whiteColor];
    viewCtl.barTitleFont = [UIFont boldSystemFontOfSize:16.0f];
    viewCtl.view.backgroundColor = JMColorFromHex(@"#E8ECF5");
    [viewCtl.navLeftBtn setImage:@"icon_navibar_back_white".jm_toImage forState:UIControlStateNormal];
    
    [self presentViewController:navViewCtl animated:YES completion:nil];
}

- (void)clickedSettingBtnAction:(UIButton *)btn
{
    DeviceSettingViewController *viewCtl = [[DeviceSettingViewController alloc] init];
    JMBaseNavigationController *navViewCtl = [[JMBaseNavigationController alloc] initWithRootViewController:viewCtl];
    viewCtl.barTitleColor = JMColorFromHex(@"#181E28");
    viewCtl.barTitleFont = [UIFont boldSystemFontOfSize:16.0f];
    viewCtl.view.backgroundColor = JMColorFromHex(@"#E8ECF5");
    [viewCtl.navLeftBtn setImage:@"icon_navibar_back_dark".jm_toImage forState:UIControlStateNormal];
    
    [self presentViewController:navViewCtl animated:YES completion:nil];
}

- (void)clickedRefreshInfoBtnAction:(UIButton *)btn
{
    
}

@end
