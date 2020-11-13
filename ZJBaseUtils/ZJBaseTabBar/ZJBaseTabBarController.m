//
//  ZJBaseTabBarController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTabBarController.h"
#import "ZJBaseTabBar.h"
#import "ZJBaseTabBarButton.h"

@interface ZJBaseTabBarController () <ZJBaseTabBarDelegate>

@end

@implementation ZJBaseTabBarController

- (instancetype)initWithSubViewControllers:(NSArray *)array
{
    self.viewControllers = array;
    self = [super init];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom;     //视图上下扩展
    
    //删除现有的tabBar
//    [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条
//    self.tabBar.hidden = YES ; //隐藏原先的tarbar
    
    //测试添加自己的视图
    ZJBaseTabBar *mainTabBar = [[ZJBaseTabBar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    mainTabBar.delegate = self; //设置代理
    mainTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:mainTabBar]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    
    //为控制器添加按钮
    for (int i=0; i<self.viewControllers.count; i++) { //根据有多少个子视图控制器来进行添加按钮
        [mainTabBar addTabBarButtonWithNormalImageName:[NSString stringWithFormat:@"TabBar%d",i+1] andDisableImageName:[NSString stringWithFormat:@"TabBar%dSel",i+1]];
    }
}

#pragma mark - BaseTabBarDelegate

/**永远别忘记设置代理*/
- (void)tabBar:(ZJBaseTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    //跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = to;
}


@end
