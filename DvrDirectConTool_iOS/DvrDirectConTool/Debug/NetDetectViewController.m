//
//  NetDetectViewController.m
//  DvrDirectConTool
//
//  Created by 李治健 on 2020/9/17.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NetDetectViewController.h"

@interface NetDetectViewController ()

@property (nonatomic,strong) UIImageView *displayImgView;
@property (nonatomic,strong) UILabel *checkStatusLB;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *tcpServerLB;
@property (nonatomic,strong) UILabel *httpServerLB;
@property (nonatomic,strong) UILabel *rtmpServerLB;
@property (nonatomic,strong) UILabel *cloudVideoServerLB;
@property (nonatomic,strong) UIButton *netCheckBtn;

@property (nonatomic,strong) UIImageView *tcpServerImgView;
@property (nonatomic,strong) UIImageView *httpServerImgView;
@property (nonatomic,strong) UIImageView *rtmpServerImgView;
@property (nonatomic,strong) UIImageView *cloudVideoServerImgView;

@end

@implementation NetDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.displayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(24.0f);
        make.width.mas_equalTo(JMScreenWidth() - 32.0*2);
        make.height.mas_equalTo(self.displayImgView.image.size.width/(JMScreenWidth() - 32.0*2)*self.displayImgView.image.size.height);
        make.centerX.equalTo(self.view);
    }];
    [self.checkStatusLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.displayImgView.mas_bottom).offset(27.0f);
        make.right.left.equalTo(self.displayImgView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkStatusLB.mas_bottom).offset(11.0f);
        make.left.equalTo(self.displayImgView);
        make.right.equalTo(self.view).offset(-22.0f);
        make.height.mas_equalTo(0.5f);
    }];
    [self.tcpServerLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-100.0f);
    }];
    [self.httpServerLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tcpServerLB);
    }];
    [self.rtmpServerLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tcpServerLB);
    }];
    [self.cloudVideoServerLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tcpServerLB);
    }];
    
    [self.netCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cloudVideoServerLB.mas_bottom).offset(64.0f);
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

- (UILabel *)checkStatusLB
{
    if (!_checkStatusLB) {
        _checkStatusLB = [[UILabel alloc] init];
        _checkStatusLB.font = [UIFont boldSystemFontOfSize:14.0f];
        _checkStatusLB.textColor = JMColorFromHex(@"#181E28");
        _checkStatusLB.text = @"待测试".localized;
        [self.view addSubview:_checkStatusLB];
    }
    
    return _checkStatusLB;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = JMColorFromHex(@"#E8ECF5");
        [self.view addSubview:_lineView];
    }
    
    return _lineView;
}

- (UILabel *)tcpServerLB
{
    if (!_tcpServerLB) {
        UILabel *serverNameLB = [[UILabel alloc] init];
        serverNameLB.font = [UIFont systemFontOfSize:12.0f];
        serverNameLB.textColor = JMColorFromHex(@"#5A6482");
        serverNameLB.text = @"TCP服务器：".localized;
        [self.view addSubview:serverNameLB];
        [serverNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView);
            make.top.equalTo(self.lineView).offset(24.0f);
            make.height.mas_offset(16.0f);
        }];
        
        _tcpServerLB = [[UILabel alloc] init];
        _tcpServerLB.font = [UIFont boldSystemFontOfSize:12.0f];
        _tcpServerLB.textColor = JMColorFromHex(@"#181E28");
        _tcpServerLB.text = @"- -".localized;
        [self.view addSubview:_tcpServerLB];
        
        [_tcpServerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serverNameLB.mas_right);
            make.top.equalTo(serverNameLB);
            make.height.equalTo(serverNameLB);
            make.centerY.equalTo(serverNameLB);
        }];
    }
    
    return _tcpServerLB;
}

- (UILabel *)httpServerLB
{
    if (!_httpServerLB) {
        UILabel *serverNameLB = [[UILabel alloc] init];
        serverNameLB.font = [UIFont systemFontOfSize:12.0f];
        serverNameLB.textColor = JMColorFromHex(@"#5A6482");
        serverNameLB.text = @"HTTP服务器：".localized;
        [self.view addSubview:serverNameLB];
        [serverNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView);
            make.top.equalTo(self.tcpServerLB.mas_bottom).offset(24.0f);
            make.height.equalTo(self.tcpServerLB);
        }];
        
        _httpServerLB = [[UILabel alloc] init];
        _httpServerLB.font = self.tcpServerLB.font;
        _httpServerLB.textColor = self.tcpServerLB.textColor;
        _httpServerLB.text = @"- -".localized;
        [self.view addSubview:_httpServerLB];
        
        [_httpServerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serverNameLB.mas_right);
            make.top.equalTo(serverNameLB);
            make.centerY.equalTo(serverNameLB);
        }];
    }
    
    return _httpServerLB;
}

- (UILabel *)rtmpServerLB
{
    if (!_rtmpServerLB) {
        UILabel *serverNameLB = [[UILabel alloc] init];
        serverNameLB.font = [UIFont systemFontOfSize:12.0f];
        serverNameLB.textColor = JMColorFromHex(@"#5A6482");
        serverNameLB.text = @"RTMP服务器：".localized;
        [self.view addSubview:serverNameLB];
        [serverNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView);
            make.top.equalTo(self.httpServerLB.mas_bottom).offset(24.0f);
            make.height.equalTo(self.httpServerLB);
        }];
        
        _rtmpServerLB = [[UILabel alloc] init];
        _rtmpServerLB.font = self.tcpServerLB.font;
        _rtmpServerLB.textColor = self.tcpServerLB.textColor;
        _rtmpServerLB.text = @"- -".localized;
        [self.view addSubview:_rtmpServerLB];
        
        [_rtmpServerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serverNameLB.mas_right);
            make.top.equalTo(serverNameLB);
            make.centerY.equalTo(serverNameLB);
        }];
    }
    
    return _rtmpServerLB;
}

- (UILabel *)cloudVideoServerLB
{
    if (!_cloudVideoServerLB) {
        UILabel *serverNameLB = [[UILabel alloc] init];
        serverNameLB.font = [UIFont systemFontOfSize:12.0f];
        serverNameLB.textColor = JMColorFromHex(@"#5A6482");
        serverNameLB.text = @"RTMP服务器：".localized;
        [self.view addSubview:serverNameLB];
        [serverNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView);
            make.top.equalTo(self.rtmpServerLB.mas_bottom).offset(24.0f);
            make.height.equalTo(self.rtmpServerLB);
        }];
        
        _cloudVideoServerLB = [[UILabel alloc] init];
        _cloudVideoServerLB.font = self.tcpServerLB.font;
        _cloudVideoServerLB.textColor = self.tcpServerLB.textColor;
        _cloudVideoServerLB.text = @"- -".localized;
        [self.view addSubview:_cloudVideoServerLB];
        
        [_cloudVideoServerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(serverNameLB.mas_right);
            make.top.equalTo(serverNameLB);
            make.centerY.equalTo(serverNameLB);
        }];
    }
    
    return _cloudVideoServerLB;
}

- (UIButton *)netCheckBtn
{
    if (!_netCheckBtn) {
        _netCheckBtn = [[JMPublicButton alloc] init];
        [_netCheckBtn setTitle:@"测试".localized forState:UIControlStateNormal];
        [_netCheckBtn addTarget:self action:@selector(clickedNetCheckBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_netCheckBtn];
    }
    
    return _netCheckBtn;
}

- (UIImageView *)tcpServerImgView
{
    if (!_tcpServerImgView) {
        _tcpServerImgView = [[UIImageView alloc] initWithImage:[self imgCheckStatus:0]];
        _tcpServerImgView.jm_centerY = self.tcpServerLB.jm_centerY;
        _tcpServerImgView.jm_right = JMScreenWidth() - 22.0f;
        [self.view addSubview:_tcpServerImgView];
    }
    
    return _tcpServerImgView;
}

- (UIImageView *)httpServerImgView
{
    if (!_httpServerImgView) {
        _httpServerImgView = [[UIImageView alloc] initWithImage:[self imgCheckStatus:0]];
        _httpServerImgView.jm_centerY = self.httpServerLB.jm_centerY;
        _httpServerImgView.jm_right = self.tcpServerImgView.jm_right;
        [self.view addSubview:_httpServerImgView];
    }
    
    return _httpServerImgView;
}

- (UIImageView *)rtmpServerImgView
{
    if (!_rtmpServerImgView) {
        _rtmpServerImgView = [[UIImageView alloc] initWithImage:[self imgCheckStatus:0]];
        _rtmpServerImgView.jm_centerY = self.rtmpServerLB.jm_centerY;
        _rtmpServerImgView.jm_right = self.tcpServerImgView.jm_right;
        [self.view addSubview:_rtmpServerImgView];
    }
    
    return _rtmpServerImgView;
}

- (UIImageView *)cloudVideoServerImgView
{
    if (!_cloudVideoServerImgView) {
        _cloudVideoServerImgView = [[UIImageView alloc] initWithImage:[self imgCheckStatus:0]];
        _cloudVideoServerImgView.jm_centerY = self.cloudVideoServerLB.jm_centerY;
        _cloudVideoServerImgView.jm_right = self.tcpServerImgView.jm_right;
        [self.view addSubview:_cloudVideoServerImgView];
    }
    
    return _cloudVideoServerImgView;
}

- (UIImage *)imgCheckStatus:(NSInteger)status
{
    if (status == 0) {  //加载
        return @"icon_debugging_loading".jm_toImage;
    } else if (status == 1) {   //成功
        return @"icon_debugging_success".jm_toImage;
    } else {    //失败
        return @"icon_debugging_fail".jm_toImage;
    }
}

#pragma mark -

- (void)clickedNetCheckBtnAction:(UIButton *)btn
{
    [self jm_showAlertController:@"提示".localized message:@"测试将消耗设备1MB流程".localized firstBtnName:@"取消".localized handler:^(UIAlertAction * _Nullable action) {
    } secondBtnName:@"确定".localized handler:^(UIAlertAction * _Nullable action) {
        btn.hidden = YES;
        self.checkStatusLB.text = @"数据检测中...".localized;
        [self.tcpServerImgView jm_addLoopRotateAnimation];
        [self.httpServerImgView jm_addLoopRotateAnimation];
        [self.rtmpServerImgView jm_addLoopRotateAnimation];
        [self.cloudVideoServerImgView jm_addLoopRotateAnimation];
    } isShow:YES];
}

@end
