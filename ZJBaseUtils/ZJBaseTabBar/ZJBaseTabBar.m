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
//        UIImage *img = [UIImage zj_imageWithColor:[UIColor whiteColor] size:self.bounds.size];
//        UIImage *img = [UIImage imageNamed:@"img_bg_1"];
//        self.backgroundColor = [UIColor clearColor];
//        UIImage *bgImage = [img stretchableImageWithLeftCapWidth:0 topCapHeight:0];
//        UIImage *bgImage = [img resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 30, 60) resizingMode:UIImageResizingModeStretch];
    //    UIImageView *imgView = [[UIImageView alloc] initWithImage:bgImage];
        
//        UIImage *bgImage = [img resizableImageWithCapInsets:UIEdgeInsetsMake(20, self.bounds.size.width/2.0 - 10, 0, self.bounds.size.width/2.0 + 10) resizingMode:UIImageResizingModeStretch];
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
//        imgView.image = bgImage;
//        [self addSubview:imgView];
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
    
    for (ZJBaseTabBarButton *btn in self.tabBarBtnArray) {
        btn.config = config;
    }
    
    if (!_backgroundView) {
        self.backgroundColor = self.config.backgroundColor;
    }
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView) {
        [self.backgroundView removeFromSuperview];
    }
    _backgroundView = backgroundView;
    if (_backgroundView) {
        self.backgroundColor = [UIColor clearColor];
        [self insertSubview:_backgroundView atIndex:0];
    } else {
        self.backgroundColor = self.config.backgroundColor;
    }
}

#pragma mark - 

- (void)clickedBtnTapAction:(UIButton *)btn
{
    NSInteger selectedIndex = self.selectedIndex;
    [self handleSelectedIndex:btn.tag];
    
    if ([self.delegate respondsToSelector:@selector(didTabBarSelectedFrom:to:)]) {
        [self.delegate didTabBarSelectedFrom:selectedIndex to:btn.tag];
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
