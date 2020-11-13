//
//  ZJBaseTabBar.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTabBar.h"
#import "ZJBaseTabBarButton.h"

@interface ZJBaseTabBar ()
/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation ZJBaseTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width/self.subviews.count;
    //设置frame
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake((width*i), 0, width, self.frame.size.height);
        //设置按键标识
        btn.tag = i;
    }
}

- (void)addTabBarButtonWithNormalImageName:(NSString *)norName andDisableImageName:(NSString *)disName
{
    ZJBaseTabBarButton *btn = [[ZJBaseTabBarButton alloc] init];
    //设置按键背景图片
//    [btn setBackgroundImage:[UIImage imageNamed:norName] forState:UIControlStateNormal];
    //设置选中状态(本身应该是不可用状态，因点击之后设置不可再点击
//    [btn setBackgroundImage:[UIImage imageNamed:disName] forState:UIControlStateDisabled];
    [btn setImage:[UIImage imageNamed:norName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:disName] forState:UIControlStateSelected];
    //设置高亮状态不调整图片
    btn.adjustsImageWhenHighlighted = NO;
    //添加按键到自定义TabBar
    [self addSubview:btn];
    //监听按键点击事件
    [btn addTarget:self action:@selector(tabBarClicked:) forControlEvents:UIControlEventTouchDown];
    
    //设置默认按键(当前添加的第一个按键）
    if (self.subviews.count == 1){
        [self tabBarClicked:btn];
    }
}

/**
 *  自定义TabBar的按钮点击事件
 */
- (void)tabBarClicked:(UIButton *)button {
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    
    //却换视图控制器的事情,应该交给controller来做
    //最好这样写, 先判断该代理方法是否实现
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
    
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    //self.selectedIndex = button.tag;
}

@end
