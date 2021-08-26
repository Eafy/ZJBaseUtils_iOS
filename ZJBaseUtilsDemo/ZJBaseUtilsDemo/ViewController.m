//
//  ViewController.m
//  ZJBaseUtilsDemo
//
//  Created by eafy on 2021/2/24.
//

#import "ViewController.h"
#import <ZJBaseUtils/ZJBaseUtils.h>

@interface ViewController ()

@property (nonatomic,strong) UIButton *btn1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _btn1 = [[UIButton alloc] init];
    self.btn1.backgroundColor = UIColor.blueColor;
    [self.btn1 setTitle:@"测试" forState:UIControlStateNormal];
    self.btn1.frame = CGRectMake(40, self.view.zj_centerY - 20, ZJScreenWidth() - 80, 40);
    [self.btn1 addTarget:self action:@selector(clickedTestBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    
    CGFloat v1 = ZJStatusBarHeight();
    CGFloat v2 = ZJScreenWidth();
    NSLog(@"1----------->%f    %f", v1, v2);
}

- (void)clickedTestBtnAction:(UIButton *)btn
{
    ZJBaseNavigationController *navCtl = [[ZJBaseNavigationController alloc] initWithRootViewController:[[TestHorizontalViewController alloc] init]];
    [self presentViewController:navCtl animated:YES completion:nil];
}

@end
