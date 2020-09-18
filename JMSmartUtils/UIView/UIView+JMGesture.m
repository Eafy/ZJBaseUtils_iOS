//
//  UIView+JMGesture.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "UIView+JMGesture.h"
#import <objc/runtime.h>

@interface UIView()

@property (nonatomic, weak) void(^jm_viewSingleTapAction)(id);

@property (nonatomic, weak) void(^jm_viewDoubleTapAction)(id);

@property (nonatomic, weak) void(^jm_viewManyTimesTapAction)(id);

@property (nonatomic, weak) void(^jm_viewLongPressAction)(id);

@property (nonatomic, strong) UIGestureRecognizer *jm_viewSingleTap;

@property (nonatomic, strong) UIGestureRecognizer *jm_viewDoubleTap;

@end

@implementation UIView (JMGesture)

#pragma mark - setter

- (void)setJm_viewSingleTapAction:(void (^)(id))jm_viewSingleTapAction {
    objc_setAssociatedObject(self, @"JM_viewSingleTapAction", jm_viewSingleTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setJm_viewDoubleTapAction:(void (^)(id))jm_viewDoubleTapAction {
    objc_setAssociatedObject(self, @"JM_viewDoubleTapAction", jm_viewDoubleTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setJm_viewManyTimesTapAction:(void (^)(id))jm_viewManyTimesTapAction {
    objc_setAssociatedObject(self, @"JM_viewManyTimesTapAction", jm_viewManyTimesTapAction, OBJC_ASSOCIATION_COPY);
}

- (void)setJm_viewLongPressAction:(void (^)(id))jm_viewLongPressAction {
    objc_setAssociatedObject(self, @"JM_viewLongPressAction", jm_viewLongPressAction, OBJC_ASSOCIATION_COPY);
}

- (void)setJm_viewSingleTap:(UIGestureRecognizer *)jm_viewSingleTap {
    objc_setAssociatedObject(self, @"JM_viewSingleTap", jm_viewSingleTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setJm_viewDoubleTap:(UIGestureRecognizer *)jm_viewDoubleTap {
    objc_setAssociatedObject(self, @"JM_viewDoubleTap", jm_viewDoubleTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (void (^)(id))jm_viewSingleTapAction {
    return objc_getAssociatedObject(self, @"JM_viewSingleTapAction");
}

- (void (^)(id))jm_viewDoubleTapAction {
    return objc_getAssociatedObject(self, @"JM_viewDoubleTapAction");
}

- (void (^)(id))jm_viewManyTimesTapAction {
    return objc_getAssociatedObject(self, @"JM_viewManyTimesTapAction");
}

- (void (^)(id))jm_viewLongPressAction {
    return objc_getAssociatedObject(self, @"JM_viewLongPressAction");
}

- (UIGestureRecognizer *)jm_viewSingleTap {
    return objc_getAssociatedObject(self, @"JM_viewSingleTap");
}

- (UIGestureRecognizer *)jm_viewDoubleTap {
    return objc_getAssociatedObject(self, @"JM_viewDoubleTap");
}

#pragma mark -

- (void)jm_addSingleTap:(void(^)(id obj))tapAction
{
    self.jm_viewSingleTapAction = tapAction;
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jm_singleTapAction:)];
    [self addGestureRecognizer:tap];
    self.jm_viewSingleTap = tap;
}

- (void)jm_addDoubleTap:(void(^)(id obj))tapAction
{
    self.jm_viewDoubleTapAction = tapAction;
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jm_doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    if (self.jm_viewSingleTapAction) {
        [self.jm_viewSingleTapAction requireGestureRecognizerToFail:doubleTap];
    }
    self.jm_viewDoubleTap = doubleTap;
}

- (void)jm_addManyTimesTap:(NSInteger)clickCount completion:(void(^)(id obj))tapAction
{
    self.jm_viewManyTimesTapAction = tapAction;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *manyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jm_manyTimesTapAticon:)];
    manyTap.numberOfTapsRequired = clickCount;
    [self addGestureRecognizer:manyTap];
    
    if (self.jm_viewSingleTapAction) {
        [self.jm_viewSingleTapAction requireGestureRecognizerToFail:manyTap];
    }
    if (self.jm_viewDoubleTapAction) {
        [self.jm_viewDoubleTapAction requireGestureRecognizerToFail:manyTap];
    }
}

- (void)jm_addlongPressTap:(void(^)(id obj))longPressAction
{
    self.jm_viewLongPressAction = longPressAction;
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(jm_longPressTapAction:)];
    [self addGestureRecognizer:longGesture];
    if (self.jm_viewSingleTapAction) {
        [self.jm_viewSingleTapAction requireGestureRecognizerToFail:longGesture];
    }
}

#pragma mark - Action

- (void)jm_singleTapAction:(UITapGestureRecognizer *)gesture
{
    if (self.jm_viewSingleTapAction) {
        self.jm_viewSingleTapAction(gesture);
    }
}

- (void)jm_doubleTapAction:(UITapGestureRecognizer *)gesture
{
    if (self.jm_viewDoubleTapAction) {
        self.jm_viewDoubleTapAction(gesture);
    }
}

- (void)jm_manyTimesTapAticon:(UITapGestureRecognizer *)gesture
{
    if (self.jm_viewManyTimesTapAction) {
        self.jm_viewManyTimesTapAction(gesture);
    }
}

- (void)jm_longPressTapAction:(UILongPressGestureRecognizer *)gesture
{
    if (self.jm_viewLongPressAction) {
        self.jm_viewLongPressAction(gesture);
    }
}

@end
