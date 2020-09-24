//
//  GSensorDetectViewController.m
//  DvrDirectConTool
//
//  Created by 李治健 on 2020/9/17.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "GSensorDetectViewController.h"

@interface GSensorDetectViewController ()

@property (nonatomic,strong) UIImageView *displayImgView;
@property (nonatomic,strong) UILabel *gSensorHintLB;
@property (nonatomic,strong) UIButton *gSensorCheckBtn;

@end

@implementation GSensorDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.displayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(24.0f);
        make.width.mas_equalTo(JMScreenWidth() - 32.0*2);
        make.height.mas_equalTo(self.displayImgView.image.size.width/(JMScreenWidth() - 32.0*2)*self.displayImgView.image.size.height);
        make.centerX.equalTo(self.view);
    }];
    [self.gSensorHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.displayImgView.mas_bottom).offset(24.0f);
        make.right.left.equalTo(self.displayImgView);
    }];
    [self.gSensorCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gSensorHintLB.mas_bottom).offset(64.0f);
        make.left.equalTo(self.view).offset(32.0);
        make.right.equalTo(self.view).offset(-32.0);
        make.height.mas_equalTo(48.0);
    }];
}

- (UIImageView *)displayImgView
{
    if (!_displayImgView) {
        _displayImgView = [[UIImageView alloc] initWithImage:@"pic_debugging_gsensor_plate".jm_toImage];
        [self.view addSubview:_displayImgView];
    }
    
    return _displayImgView;
}

- (UILabel *)gSensorHintLB
{
    if (!_gSensorHintLB) {
        _gSensorHintLB = [[UILabel alloc] init];
        _gSensorHintLB.attributedText = [@"1. 请将设备安装完成；\n2. 请将车辆停放在平整路面；\n3. 将车辆发动机关闭，保存车辆静止；\n4. 点击校准；".localized jm_toColor:JMColorFromHex(@"#5A6482") specialColor:nil specialStrings:nil lineSpacing:8.0f fontSize:14.0f alignment:NSTextAlignmentLeft];
        _gSensorHintLB.numberOfLines = 0;
        [self.view addSubview:_gSensorHintLB];
    }
    
    return _gSensorHintLB;
}

- (UIButton *)gSensorCheckBtn
{
    if (!_gSensorCheckBtn) {
        _gSensorCheckBtn = [[JMPublicButton alloc] init];
        [_gSensorCheckBtn setTitle:@"校准".localized forState:UIControlStateNormal];
        [_gSensorCheckBtn addTarget:self action:@selector(clickedGSensorCheckBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_gSensorCheckBtn];
    }
    
    return _gSensorCheckBtn;
}

#pragma mark -

- (void)clickedGSensorCheckBtnAction:(UIButton *)btn
{
    
}

@end
