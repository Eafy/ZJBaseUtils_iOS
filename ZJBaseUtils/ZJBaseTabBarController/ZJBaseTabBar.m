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
#import "UIColor+ZJExt.h"

@interface ZJBaseTabBar ()

/// 按钮总数
@property (nonatomic, assign) NSInteger totalItems;
/// 中心按钮Tag
@property (nonatomic, assign) NSInteger centerTag;
@property (nonatomic, strong) NSMutableArray *tabBarBtnArray;

@property (nonatomic, copy) ZJBTBCustomBtnBlock customBtnClickBlock;

@end

@implementation ZJBaseTabBar
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ZJScreenWidth(), ZJTabarBarHeight())]) {
        _centerTag = -1;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.totalItems % 2 == 1) {
        self.centerTag = self.totalItems / 2;
    }

    NSMutableArray *tempArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[ZJBaseTabBarButton class]]) {
            [tempArray addObject:tabBarButton];
            
            if (self.config.effectType == ZJBTBConfigSelectEffectTypeRaised) {
                ZJBaseTabBarButton *btn = (ZJBaseTabBarButton *)tabBarButton;
                if (tabBarButton.tag == self.centerTag) {
                    btn.isCenter = YES;
                } else {
                    btn.isCenter = NO;
                }
            }
        } else if ([tabBarButton isKindOfClass:[UIButton class]]) {
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
    
    //隐藏顶部线条
    if (self.config.topLineConfig.type == ZJBTBConfigTopLineTypeShadow ||
        self.config.topLineConfig.type == ZJBTBConfigTopLineTypeClear) {
        if (@available(iOS 13.0, *)) {
            [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                    obj.hidden = YES;
                }
            }];
        }
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
    [btn addTarget:self action:@selector(clickedBtnTapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBarBtnArray addObject:btn];
    [self addSubview:btn];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self handleSelectedIndex:selectedIndex];
}

- (void)addCustomBtn:(UIButton *)btn atIndex:(NSInteger)index clickedBlock:(ZJBTBCustomBtnBlock)btnClickBlock
{
    btn.tag = index;
    [btn addTarget:self action:@selector(clickedCustomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.totalItems ++;
    _customBtnClickBlock = btnClickBlock;
    
    [self addSubview:btn];
}

- (void)setConfig:(ZJBaseTabBarConfig *)config
{
    _config = config;
    
    for (ZJBaseTabBarButton *btn in self.tabBarBtnArray) {
        btn.config = config;
    }
    
    if (!_backgroundView) {
        self.backgroundColor = self.config.backgroundColor;
    }
    
    [self handleTopLine];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView) {
        [self.backgroundView removeFromSuperview];
    }
    _backgroundView = backgroundView;
    if (_backgroundView) {
        self.backgroundImage = [UIImage new];
        self.backgroundColor = [UIColor clearColor];

        _backgroundView.frame = CGRectMake(0, 0, self.zj_width, ZJTabarBarHeight());
        _backgroundView.contentMode = UIViewContentModeTop;
        
        //适配不同的屏幕，导致图片大小和背景不一致
        if ([backgroundView isKindOfClass:[UIImageView class]]) {
            CGFloat width = _backgroundView.bounds.size.width - ((UIImageView *)backgroundView).image.size.width;
            if (width > 0) {
                width += 50;    //防止图片切了圆角
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width/2, _backgroundView.zj_height)];
                view.backgroundColor = self.config.backgroundColor;
                [_backgroundView addSubview:view];
                view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width/2, _backgroundView.zj_height)];
                view.zj_right = _backgroundView.zj_width;
                view.backgroundColor = self.config.backgroundColor;
                [_backgroundView addSubview:view];
            }
        }
        [self insertSubview:backgroundView atIndex:0];
    } else {
        self.backgroundColor = self.config.backgroundColor;
        [self handleTopLine];
    }
}

#pragma mark - 

- (void)clickedBtnTapAction:(UIButton *)btn
{
    NSInteger selectedIndex = self.selectedIndex;
    
    BOOL ret = YES;
    if ([self.delegate respondsToSelector:@selector(willTabBarSelectedFrom:to:)]) {
        ret = [self.delegate willTabBarSelectedFrom:selectedIndex to:btn.tag];
    }
    
    if (ret) {
        [self handleSelectedIndex:btn.tag];
        
        if ([self.delegate respondsToSelector:@selector(didTabBarSelectedFrom:to:)]) {
            [self.delegate didTabBarSelectedFrom:selectedIndex to:btn.tag];
        }
    }
}

- (void)handleSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    for (int i = 0; i < self.tabBarBtnArray.count; i++) {
        ZJBaseTabBarButton *btn = self.tabBarBtnArray[i];
        if (i == selectedIndex) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)handleTopLine
{
    if (self.config.topLineConfig.type == ZJBTBConfigTopLineTypeColor) {
        UIColor *color = [UIColor clearColor];
        if (self.config.topLineConfig.shadowColor) {
            color = self.config.topLineConfig.shadowColor;
        }
        if (@available(iOS 13.0, *)) {
            self.standardAppearance.shadowImage = [UIImage zj_imageWithColor:color size:CGSizeMake(self.zj_width, self.config.topLineConfig.lineWidth)];
        } else {
            self.shadowImage = [UIImage zj_imageWithColor:color size:CGSizeMake(self.zj_width, self.config.topLineConfig.lineWidth)];
        }
    } else if (self.config.topLineConfig.type == ZJBTBConfigTopLineTypeShadow) {
        self.shadowImage = [UIImage new];
        
        self.layer.shadowColor = self.config.topLineConfig.shadowColor.CGColor;
        self.layer.shadowOffset = self.config.topLineConfig.shadowOffset;
        self.layer.shadowOpacity = self.config.topLineConfig.shadowOpacity;
        self.layer.shadowRadius = self.config.topLineConfig.shadowRadius;
        self.layer.shadowPath = self.config.topLineConfig.shadowPath;
        if (!self.layer.shadowPath) {
            self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        }
    } else if (self.config.topLineConfig.type == ZJBTBConfigTopLineTypeClear) {
        self.shadowImage = [UIImage new];
    }
}

- (void)clickedCustomBtnAction:(UIButton *)sender
{
    if (_customBtnClickBlock) {
        self.customBtnClickBlock(sender, sender.tag);
    }
}

#pragma mark - 移除系统的UITabBarItem功能

- (NSArray<UITabBarItem *> *)items { return @[];}
- (void)setItems:(NSArray<UITabBarItem *> *)items {}
- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated {}


/// 判断点击是否在中心凸起的地方
/// @param point 点击点
/// @param event 事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.hidden && self.config.effectType == ZJBTBConfigSelectEffectTypeRaised) {
        UIView *view = [self viewWithTag:self.centerTag];
        if (view) {
            CGRect frame = view.frame;
            frame.origin.y += self.config.centerImageOffset;
            if (CGRectContainsPoint(frame, point)) {
                return view;
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
