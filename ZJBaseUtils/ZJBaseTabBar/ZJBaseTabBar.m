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
#import "UIView+ZJFrame.h"
#import "UIImage+ZJExt.h"

@interface ZJBaseTabBar ()

/// 按钮总数
@property (nonatomic, assign) NSUInteger totalItems;

@property (nonatomic, strong) NSMutableArray *tabBarBtnArray;

@end

@implementation ZJBaseTabBar
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ZJScreenWidth(), ZJTabarBarHeight())]) {
//        UIImage *img = [UIImage zj_imageWithColor:self.backgroundColor size:self.bounds.size];
        UIImage *img = [UIImage imageNamed:@"img_bg_1"];
//        UIImage *bgImage = [img stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        UIImage *bgImage = [img resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    //    UIImageView *imgView = [[UIImageView alloc] initWithImage:bgImage];
        self.backgroundImage = bgImage;
        self.backgroundColor = [UIColor clearColor];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
        imgView.image = bgImage;
        [self addSubview:imgView];
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
}

#pragma mark -

- (NSMutableArray *)tabBarBtnArray {
    if (!_tabBarBtnArray) {
        _tabBarBtnArray = [NSMutableArray array];
    }
    return _tabBarBtnArray;
}

- (NSArray *)tabBarButtonArray {
    return self.tabBarBtnArray;
}

- (void)addItem:(ZJBaseTarbarItem * _Nullable)item
{
    ZJBaseTabBarButton *btn = [[ZJBaseTabBarButton alloc] init];
    btn.item = item;
    btn.tag = self.totalItems;
    btn.config = self.config;
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

- (void)setConfig:(ZJBaseTabBarConfig *)config
{
    if (_config.isClearTopLine != config.isClearTopLine) {
        _config = config;
        if (self.config.isClearTopLine) {
            [self clearTopLine:YES];
        } else {
            [self clearTopLine:NO];
        }
    } else {
        _config = config;
    }
    
//    self.backgroundColor = self.config.backgroundColor;
    for (ZJBaseTabBarButton *btn in self.tabBarBtnArray) {
        btn.config = config;
    }
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
