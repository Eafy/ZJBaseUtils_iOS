//
//  ZJBaseTabBar.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTabBar.h"
#import "ZJBaseTabBarButton.h"
#import "ZJScreen.h"
#import "ZJBaseTBConfig.h"
#import "UIView+ZJFrame.h"

@interface ZJBaseTabBar ()

@property (nonatomic,assign) NSUInteger totalItems;

@property (nonatomic,strong) NSMutableArray *tabBarBtnArray;

@end

@implementation ZJBaseTabBar
@dynamic delegate;

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ZJScreenWidth(), ZJTabarBarHeight())]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSMutableArray *tempArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[ZJBaseTabBarButton class]] || [tabBarButton isKindOfClass:[UIButton class]]) {
            [tempArray addObject:tabBarButton];
        }
    }
    
    for (int i = 0; i < tempArray.count; i++) {
        UIView *view = tempArray[i];
        if ([view isKindOfClass:[UIButton class]]) {
            [tempArray insertObject:view atIndex:view.tag];
            [tempArray removeLastObject];
            break;
        }
    }

    CGFloat viewW = self.zj_width / self.totalItems;
    CGFloat viewH = 49;
    CGFloat viewY = 0;
    for (int i = 0; i < tempArray.count; i++) {
        CGFloat viewX = i * viewW;
        UIView *view = tempArray[i];
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
    
    self.backgroundColor = self.config.backgroundColor;
    if (self.config.isClearTopLine) {
        [self clearTopLine:YES];
    } else {
        [self clearTopLine:NO];
    }
}

#pragma mark -

- (ZJBaseTBConfig *)config
{
    if (!_config) {
        _config = [[ZJBaseTBConfig alloc] init];
    }
    return _config;
}

- (NSMutableArray *)tabBarBtnArray {
    if (!_tabBarBtnArray) {
        _tabBarBtnArray = [NSMutableArray array];
    }
    return _tabBarBtnArray;
}

- (void)addItem:(ZJBaseTarbarItem * _Nullable)item
{
    ZJBaseTabBarButton *btn = [[ZJBaseTabBarButton alloc] init];
    btn.item = item;
    btn.tag = self.totalItems;
    self.totalItems ++;
    [self.tabBarBtnArray addObject:btn];
    
    [self addSubview:btn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedBtnTapAction:)];
    [btn addGestureRecognizer:tap];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    [self handleSelectedIndex:selectedIndex];
}

- (void)addCustomBtn:(UIButton *)btn atIndex:(NSInteger)index clickedBlock:(ZJBTBCustomBtnBlock)btnClickBlock
{
    btn.tag = index;
    [btn addTarget:self action:@selector(clickedCustomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.totalItems ++;
    
    [self addSubview:btn];
}

#pragma mark - 

- (void)clickedBtnTapAction:(UITapGestureRecognizer *)tap
{
    [self handleSelectedIndex:tap.view.tag];
    
    if ([self.delegate respondsToSelector:@selector(didTabBarSelectedFrom:to:)]) {
        [self.delegate didTabBarSelectedFrom:self.selectedIndex to:tap.view.tag];
    }
}

- (void)handleSelectedIndex:(NSInteger)selectedIndex
{
    for (int i = 0; i < self.tabBarBtnArray.count; i++) {
        ZJBaseTabBarButton *btn = self.tabBarBtnArray[i];
        if (i == selectedIndex) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)clearTopLine:(BOOL)isClear
{
    UIColor *color = [UIColor clearColor];
    if (!isClear) {
        color = self.config.topLineColor;
    }
    
    CGRect rect = CGRectMake(0, 0, self.zj_width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:img];
}

- (void)clickedCustomBtnAction:(UIButton *)sender
{
    
}

#pragma mark - 移除系统的UITabBarItem功能

- (NSArray<UITabBarItem *> *)items { return @[];}
- (void)setItems:(NSArray<UITabBarItem *> *)items {}
- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated {}

@end
