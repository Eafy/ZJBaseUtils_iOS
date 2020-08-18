//
//  UIView+ZJGesture.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "UIView+ZJGesture.h"
#import <objc/runtime.h>

@interface UIView()

@property (nonatomic, weak) void(^zj_viewSingleTapAction)(id);

@property (nonatomic, weak) void(^zj_viewDoubleTapAction)(id);

@property (nonatomic, weak) void(^zj_viewManyTimesTapAction)(id);

@property (nonatomic, weak) void(^zj_viewLongPressAction)(id);

@property (nonatomic, strong) UIGestureRecognizer *zj_viewSingleTap;

@property (nonatomic, strong) UIGestureRecognizer *zj_viewDoubleTap;

@end

@implementation UIView (ZJGesture)

#pragma mark - setter

- (void)setZj_viewSingleTapAction:(void (^)(id))zj_viewSingleTapAction {
    objc_setAssociatedObject(self, @"zj_viewSingleTapAction", zj_viewSingleTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewDoubleTapAction:(void (^)(id))zj_viewDoubleTapAction {
    objc_setAssociatedObject(self, @"zj_viewDoubleTapAction", zj_viewDoubleTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewManyTimesTapAction:(void (^)(id))zj_viewManyTimesTapAction {
    objc_setAssociatedObject(self, @"zj_viewManyTimesTapAction", zj_viewManyTimesTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewLongPressAction:(void (^)(id))zj_viewLongPressAction {
    objc_setAssociatedObject(self, @"zj_viewLongPressAction", zj_viewLongPressAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewSingleTap:(UIGestureRecognizer *)zj_viewSingleTap {
    objc_setAssociatedObject(self, @"zj_viewSingleTap", zj_viewSingleTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setZj_viewDoubleTap:(UIGestureRecognizer *)zj_viewDoubleTap {
    objc_setAssociatedObject(self, @"zj_viewDoubleTap", zj_viewDoubleTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (void (^)(id))zj_viewSingleTapAction {
    return objc_getAssociatedObject(self, @"zj_viewSingleTapAction");
}

- (void (^)(id))zj_viewDoubleTapAction {
    return objc_getAssociatedObject(self, @"zj_viewDoubleTapAction");
}

- (void (^)(id))zj_viewManyTimesTapAction {
    return objc_getAssociatedObject(self, @"zj_viewManyTimesTapAction");
}

- (void (^)(id))zj_viewLongPressAction {
    return objc_getAssociatedObject(self, @"zj_viewLongPressAction");
}

- (UIGestureRecognizer *)zj_viewSingleTap {
    return objc_getAssociatedObject(self, @"zj_viewSingleTap");
}

- (UIGestureRecognizer *)zj_viewDoubleTap {
    return objc_getAssociatedObject(self, @"zj_viewDoubleTap");
}

#pragma mark -

- (void)zj_addSingleTap:(void(^)(id obj))tapAction
{
    self.zj_viewSingleTapAction = tapAction;
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zj_singleTapAction:)];
    [self addGestureRecognizer:tap];
    self.zj_viewSingleTap = tap;
}

- (void)zj_addDoubleTap:(void(^)(id obj))tapAction
{
    self.zj_viewDoubleTapAction = tapAction;
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zj_doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    if (self.zj_viewSingleTapAction) {
        [self.zj_viewSingleTapAction requireGestureRecognizerToFail:doubleTap];
    }
    self.zj_viewDoubleTap = doubleTap;
}

- (void)zj_addManyTimesTap:(NSInteger)clickCount completion:(void(^)(id obj))tapAction
{
    self.zj_viewManyTimesTapAction = tapAction;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *manyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zj_manyTimesTapAticon:)];
    manyTap.numberOfTapsRequired = clickCount;
    [self addGestureRecognizer:manyTap];
    
    if (self.zj_viewSingleTapAction) {
        [self.zj_viewSingleTapAction requireGestureRecognizerToFail:manyTap];
    }
    if (self.zj_viewDoubleTapAction) {
        [self.zj_viewDoubleTapAction requireGestureRecognizerToFail:manyTap];
    }
}

- (void)zj_addlongPressTap:(void(^)(id obj))longPressAction
{
    self.zj_viewLongPressAction = longPressAction;
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(zj_longPressTapAction:)];
    [self addGestureRecognizer:longGesture];
    if (self.zj_viewSingleTapAction) {
        [self.zj_viewSingleTapAction requireGestureRecognizerToFail:longGesture];
    }
}

#pragma mark - Action

- (void)zj_singleTapAction:(UITapGestureRecognizer *)gesture
{
    if (self.zj_viewSingleTapAction) {
        self.zj_viewSingleTapAction(gesture);
    }
}

- (void)zj_doubleTapAction:(UITapGestureRecognizer *)gesture
{
    if (self.zj_viewDoubleTapAction) {
        self.zj_viewDoubleTapAction(gesture);
    }
}

- (void)zj_manyTimesTapAticon:(UITapGestureRecognizer *)gesture
{
    if (self.zj_viewManyTimesTapAction) {
        self.zj_viewManyTimesTapAction(gesture);
    }
}

- (void)zj_longPressTapAction:(UILongPressGestureRecognizer *)gesture
{
    if (self.zj_viewLongPressAction) {
        self.zj_viewLongPressAction(gesture);
    }
}

@end
