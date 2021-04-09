//
//  UIView+ZJGesture.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIView+ZJGesture.h"
#import <objc/runtime.h>

@interface UIView()

@end

@implementation UIView (ZJGesture)

#pragma mark - setter

- (void)setZj_viewSingleTap:(UITapGestureRecognizer *)zj_viewSingleTap {
    objc_setAssociatedObject(self, @"zj_viewSingleTap", zj_viewSingleTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setZj_viewDoubleTap:(UITapGestureRecognizer *)zj_viewDoubleTap {
    objc_setAssociatedObject(self, @"zj_viewDoubleTap", zj_viewDoubleTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setZj_viewLongPress:(UILongPressGestureRecognizer *)zj_viewLongPress {
    objc_setAssociatedObject(self, @"zj_viewLongPress", zj_viewLongPress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setZj_viewLeftSwip:(UISwipeGestureRecognizer *)zj_viewLeftSwip {
    objc_setAssociatedObject(self, @"zj_viewLeftSwip", zj_viewLeftSwip, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setZj_viewRightSwip:(UISwipeGestureRecognizer *)zj_viewRightSwip {
    objc_setAssociatedObject(self, @"zj_viewRightSwip", zj_viewRightSwip, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setZj_viewSingleTapAction:(void (^)(UITapGestureRecognizer *))zj_viewSingleTapAction {
    objc_setAssociatedObject(self, @"zj_viewSingleTapAction", zj_viewSingleTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewDoubleTapAction:(void (^)(UITapGestureRecognizer *))zj_viewDoubleTapAction {
    objc_setAssociatedObject(self, @"zj_viewDoubleTapAction", zj_viewDoubleTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewManyTimesTapAction:(void (^)(UITapGestureRecognizer *))zj_viewManyTimesTapAction {
    objc_setAssociatedObject(self, @"zj_viewManyTimesTapAction", zj_viewManyTimesTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewLongPressAction:(void (^)(UILongPressGestureRecognizer *))zj_viewLongPressAction {
    objc_setAssociatedObject(self, @"zj_viewLongPressAction", zj_viewLongPressAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewLeftSwipAction:(void (^)(UISwipeGestureRecognizer *))zj_viewLeftSwipAction {
    objc_setAssociatedObject(self, @"zj_viewLeftSwipAction", zj_viewLeftSwipAction, OBJC_ASSOCIATION_COPY);
}

- (void)setZj_viewRightSwipAction:(void (^)(UISwipeGestureRecognizer *))zj_viewRightSwipAction {
    objc_setAssociatedObject(self, @"zj_viewRightSwipAction", zj_viewRightSwipAction, OBJC_ASSOCIATION_COPY);
}

#pragma mark - getter

- (UITapGestureRecognizer *)zj_viewSingleTap {
    return objc_getAssociatedObject(self, @"zj_viewSingleTap");
}

- (UITapGestureRecognizer *)zj_viewDoubleTap {
    return objc_getAssociatedObject(self, @"zj_viewDoubleTap");
}

- (UILongPressGestureRecognizer *)zj_viewLongPress {
    return objc_getAssociatedObject(self, @"zj_viewLongPress");
}

- (UISwipeGestureRecognizer *)zj_viewLeftSwip {
    return objc_getAssociatedObject(self, @"zj_viewLeftSwip");
}

- (UISwipeGestureRecognizer *)zj_viewRightSwip {
    return objc_getAssociatedObject(self, @"zj_viewRightSwip");
}

- (void (^)(UITapGestureRecognizer *))zj_viewSingleTapAction {
    return objc_getAssociatedObject(self, @"zj_viewSingleTapAction");
}

- (void (^)(UITapGestureRecognizer *))zj_viewDoubleTapAction {
    return objc_getAssociatedObject(self, @"zj_viewDoubleTapAction");
}

- (void (^)(UITapGestureRecognizer *))zj_viewManyTimesTapAction {
    return objc_getAssociatedObject(self, @"zj_viewManyTimesTapAction");
}

- (void (^)(UILongPressGestureRecognizer *))zj_viewLongPressAction {
    return objc_getAssociatedObject(self, @"zj_viewLongPressAction");
}

- (void (^)(UISwipeGestureRecognizer *))zj_viewLeftSwipAction {
    return objc_getAssociatedObject(self, @"zj_viewLeftSwipAction");
}

- (void (^)(UISwipeGestureRecognizer *))zj_viewRightSwipAction {
    return objc_getAssociatedObject(self, @"zj_viewRightSwipAction");
}

#pragma mark -

- (void)zj_addSingleTap:(void(^)(UITapGestureRecognizer *obj))tapAction
{
    self.zj_viewSingleTapAction = tapAction;
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zj_singleTapAction:)];
    [self addGestureRecognizer:tap];
    self.zj_viewSingleTap = tap;
}

- (void)zj_addDoubleTap:(void(^)(UITapGestureRecognizer *obj))tapAction
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

- (void)zj_addManyTimesTap:(NSInteger)clickCount completion:(void(^)(UITapGestureRecognizer *obj))tapAction
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

- (void)zj_addLongPressTap:(void(^)(UILongPressGestureRecognizer *obj))longPressAction
{
    self.zj_viewLongPressAction = longPressAction;
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(zj_longPressTapAction:)];
    [self addGestureRecognizer:longGesture];
    if (self.zj_viewSingleTapAction) {
        [self.zj_viewSingleTapAction requireGestureRecognizerToFail:longGesture];
    }
    self.zj_viewLongPress = longGesture;
}

- (void)zj_addLeftSwip:(void(^)(UISwipeGestureRecognizer *obj))leftSwipAction
{
    self.zj_viewLeftSwipAction = leftSwipAction;
    UISwipeGestureRecognizer *leftSwipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(zj_leftSwipAction:)];
    leftSwipGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipGesture];
    self.zj_viewLeftSwip = leftSwipGesture;
}

- (void)zj_addRightSwip:(void(^)(UISwipeGestureRecognizer *obj))rightSwipAction
{
    self.zj_viewRightSwipAction = rightSwipAction;
    UISwipeGestureRecognizer *rightSwipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(zj_rightSwipAction:)];
    rightSwipGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipGesture];
    self.zj_viewRightSwip = rightSwipGesture;
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

- (void)zj_leftSwipAction:(UISwipeGestureRecognizer *)gesture
{
    if (self.zj_viewLeftSwipAction) {
        self.zj_viewLeftSwipAction(gesture);
    }
}

- (void)zj_rightSwipAction:(UISwipeGestureRecognizer *)gesture
{
    if (self.zj_viewRightSwipAction) {
        self.zj_viewRightSwipAction(gesture);
    }
}

@end
