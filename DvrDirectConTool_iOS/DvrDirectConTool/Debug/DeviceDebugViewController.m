//
//  DeviceDebugViewController.m
//  DvrDirectConTool
//
//  Created by 李治健 on 2020/9/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "DeviceDebugViewController.h"
#import "DMSVideoDetectViewController.h"
#import "GSensorDetectViewController.h"
#import "NetDetectViewController.h"

@interface DeviceDebugViewController ()

@property (nonatomic,strong) UIButton *dmsBtn;
@property (nonatomic,strong) UIButton *adasBtn;
@property (nonatomic,strong) UIButton *gSensorBtn;
@property (nonatomic,strong) UIButton *netCheckBtn;

@end

@implementation DeviceDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"调试".localized;

    [self loadSubView];
}

- (void)loadSubView
{
    UIImage *img = @"pic_debugging_navibar_bg".jm_toImage;
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(0, 0, JMScreenWidth(), img.size.height/img.size.width*JMScreenWidth());
    [self.view addSubview:imgView];
    
    NSMutableArray *distributeViewArray1 = [NSMutableArray array];
    [distributeViewArray1 addObject:self.dmsBtn];
    [distributeViewArray1 addObject:self.adasBtn];
    [distributeViewArray1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:16.0 leadSpacing:16.0 tailSpacing:16.0];
    [distributeViewArray1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(70 + JMStatusBarHeight() + JMNavBarHeight());
        make.height.mas_offset(132);
    }];
    
    NSMutableArray *distributeViewArray2 = [NSMutableArray array];
    [distributeViewArray2 addObject:self.gSensorBtn];
    [distributeViewArray2 addObject:self.netCheckBtn];
    [distributeViewArray2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:16.0 leadSpacing:16.0 tailSpacing:16.0];
    [distributeViewArray2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dmsBtn.mas_bottom).offset(16.0);
        make.height.equalTo(self.dmsBtn.mas_height);
    }];
    
    [self.dmsBtn layoutIfNeeded];
    [self.adasBtn layoutIfNeeded];
    [self.gSensorBtn layoutIfNeeded];
    [self.netCheckBtn layoutIfNeeded];
    [self.dmsBtn jm_layoutWithEdgeInsets:CGPointMake(16.0f, self.dmsBtn.jm_height/2.0 - self.dmsBtn.imageView.jm_height) labelPoint:CGPointMake(16.0f, self.dmsBtn.jm_height/2.0 + 16.0f)];
    [self.adasBtn jm_layoutWithEdgeInsets:CGPointMake(16.0f, self.adasBtn.jm_height/2.0 - self.adasBtn.imageView.jm_height) labelPoint:CGPointMake(16.0f, self.adasBtn.jm_height/2.0 + 16.0f)];
    [self.gSensorBtn jm_layoutWithEdgeInsets:CGPointMake(16.0f, self.gSensorBtn.jm_height/2.0 - self.gSensorBtn.imageView.jm_height) labelPoint:CGPointMake(16.0f, self.gSensorBtn.jm_height/2.0 + 16.0f)];
    [self.netCheckBtn jm_layoutWithEdgeInsets:CGPointMake(16.0f, self.netCheckBtn.jm_height/2.0 - self.netCheckBtn.imageView.jm_height) labelPoint:CGPointMake(16.0f, self.netCheckBtn.jm_height/2.0 + 16.0f)];
}

- (UIButton *)dmsBtn
{
    if (!_dmsBtn) {
        _dmsBtn = [[UIButton alloc] init];
        _dmsBtn.layer.cornerRadius = 4.0;
        _dmsBtn.backgroundColor = [UIColor whiteColor];
        [_dmsBtn setImage:@"icon_debugging_dms".jm_toImage forState:UIControlStateNormal];
        [_dmsBtn setTitle:@"DMS标定".localized forState:UIControlStateNormal];
        [_dmsBtn setTitleColor:JMColorFromHex(@"#5A6482") forState:UIControlStateNormal];
        _dmsBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_dmsBtn addTarget:self action:@selector(clickedDMSBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_dmsBtn];
    }
    
    return _dmsBtn;
}

- (UIButton *)adasBtn
{
    if (!_adasBtn) {
        _adasBtn = [[UIButton alloc] init];
        _adasBtn.layer.cornerRadius = self.dmsBtn.layer.cornerRadius;
        _adasBtn.backgroundColor = self.dmsBtn.backgroundColor;
        _adasBtn.titleLabel.font = self.dmsBtn.titleLabel.font;
        [_adasBtn setImage:@"icon_debugging_adas".jm_toImage forState:UIControlStateNormal];
        [_adasBtn setTitle:@"ADAS标定".localized forState:UIControlStateNormal];
        [_adasBtn setTitleColor:JMColorFromHex(@"#5A6482") forState:UIControlStateNormal];
        [_adasBtn addTarget:self action:@selector(clickedADASBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_adasBtn];
    }
    
    return _adasBtn;
}

- (UIButton *)gSensorBtn
{
    if (!_gSensorBtn) {
        _gSensorBtn = [[UIButton alloc] init];
        _gSensorBtn.layer.cornerRadius = self.dmsBtn.layer.cornerRadius;
        _gSensorBtn.backgroundColor = self.dmsBtn.backgroundColor;
        _gSensorBtn.titleLabel.font = self.dmsBtn.titleLabel.font;
        [_gSensorBtn setImage:@"icon_debugging_gsenso".jm_toImage forState:UIControlStateNormal];
        [_gSensorBtn setTitle:@"G-Sensor校准".localized forState:UIControlStateNormal];
        [_gSensorBtn setTitleColor:JMColorFromHex(@"#5A6482") forState:UIControlStateNormal];
        [_gSensorBtn addTarget:self action:@selector(clickedGSensorBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_gSensorBtn];
    }
    
    return _gSensorBtn;
}

- (UIButton *)netCheckBtn
{
    if (!_netCheckBtn) {
        _netCheckBtn = [[UIButton alloc] init];
        _netCheckBtn.layer.cornerRadius = self.dmsBtn.layer.cornerRadius;
        _netCheckBtn.backgroundColor = self.dmsBtn.backgroundColor;
        _netCheckBtn.titleLabel.font = self.dmsBtn.titleLabel.font;
        [_netCheckBtn setImage:@"icon_debugging_internet".jm_toImage forState:UIControlStateNormal];
        [_netCheckBtn setTitle:@"网络连接性".localized forState:UIControlStateNormal];
        [_netCheckBtn setTitleColor:JMColorFromHex(@"#5A6482") forState:UIControlStateNormal];
        [_netCheckBtn addTarget:self action:@selector(clickedNetCheckBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_netCheckBtn];
    }
    
    return _netCheckBtn;
}

#pragma mark -

- (void)clickedDMSBtnAction:(UIButton *)btn
{
    DMSVideoDetectViewController *viewCtl = [[DMSVideoDetectViewController alloc] init];
    [viewCtl.navLeftBtn setImage:@"icon_navibar_back_dark".jm_toImage forState:UIControlStateNormal];
    viewCtl.barTintColor = [UIColor whiteColor];
    viewCtl.barTitleColor = JMColorFromHex(@"#181E28");
    viewCtl.title = btn.titleLabel.text;
    
    [self.navigationController pushViewController:viewCtl animated:YES];
}

- (void)clickedADASBtnAction:(UIButton *)btn
{
    
}

- (void)clickedGSensorBtnAction:(UIButton *)btn
{
    GSensorDetectViewController *viewCtl = [[GSensorDetectViewController alloc] init];
    [viewCtl.navLeftBtn setImage:@"icon_navibar_back_dark".jm_toImage forState:UIControlStateNormal];
    viewCtl.barTintColor = [UIColor whiteColor];
    viewCtl.barTitleColor = JMColorFromHex(@"#181E28");
    viewCtl.title = btn.titleLabel.text;
    
    [self.navigationController pushViewController:viewCtl animated:YES];
}

- (void)clickedNetCheckBtnAction:(UIButton *)btn
{
    NetDetectViewController *viewCtl = [[NetDetectViewController alloc] init];
    [viewCtl.navLeftBtn setImage:@"icon_navibar_back_dark".jm_toImage forState:UIControlStateNormal];
    viewCtl.barTintColor = [UIColor whiteColor];
    viewCtl.barTitleColor = JMColorFromHex(@"#181E28");
    viewCtl.title = btn.titleLabel.text;
    
    [self.navigationController pushViewController:viewCtl animated:YES];
}

@end
