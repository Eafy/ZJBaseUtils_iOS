//
//  DMSVideoDetectViewController.m
//  DvrDirectConTool
//
//  Created by 李治健 on 2020/9/17.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "DMSVideoDetectViewController.h"
#import <JMMonitorView/JMMonitorView.h>

@interface DMSVideoDetectViewController ()

@property (nonatomic,strong) JMMonitor *monitor;
@property (nonatomic,strong) UIImageView *scanCropImgView;
@property (nonatomic,strong) UILabel *hintLB;
@property (nonatomic,strong) UIButton *dmsCheckBtn;


@end

@implementation DMSVideoDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.monitor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.jm_width * 375.0 / 400.0);
    }];
    [self.hintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.monitor.mas_bottom).offset(16.0f);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(20.0f);
    }];
    [self.dmsCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom).offset(-58.0f);
        make.left.equalTo(self.view).offset(32.0);
        make.right.equalTo(self.view).offset(-32.0);
        make.height.mas_equalTo(48.0);
    }];
    [self.scanCropImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(68.0f);
        make.right.equalTo(self.view).offset(-68.0f);
        make.centerX.centerY.equalTo(self.monitor);
        make.height.equalTo(self.monitor.mas_width).offset(-68.0f * 2);
    }];
}

- (JMMonitor *)monitor
{
    if (!_monitor) {
        _monitor = [[JMMonitor alloc] init];
        _monitor.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_monitor];
    }
    
    return _monitor;
}

- (UILabel *)hintLB
{
    if (!_hintLB) {
        _hintLB = [[UILabel alloc] init];
        _hintLB.text = @"请将人脸位于摄像头并对准画面参考框".localized;
        _hintLB.font = [UIFont systemFontOfSize:14.0f];
        _hintLB.textColor = JMColorFromHex(@"#5A6482");
        _hintLB.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_hintLB];
    }
    
    return _hintLB;
}

- (UIButton *)dmsCheckBtn
{
    if (!_dmsCheckBtn) {
        _dmsCheckBtn = [[JMPublicButton alloc] init];
        [_dmsCheckBtn setTitle:@"开始标定".localized forState:UIControlStateNormal];
        [_dmsCheckBtn addTarget:self action:@selector(clickedDMSCheckBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_dmsCheckBtn];
    }
    
    return _dmsCheckBtn;
}

- (UIImageView *)scanCropImgView
{
    if (!_scanCropImgView) {
        _scanCropImgView = [[UIImageView alloc] initWithImage:@"pic_debugging_dms_frame".jm_toImage];
        [self.view addSubview:_scanCropImgView];
    }
    
    return _scanCropImgView;
}

#pragma mark -

- (void)clickedDMSCheckBtnAction:(UIButton *)btn
{
    
}

@end
