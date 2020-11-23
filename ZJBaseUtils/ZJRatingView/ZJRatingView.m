//
//  ZJRatingView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJRatingView.h"
#import "ZJRatingStarView.h"

@interface ZJRatingView ()

@property (nonatomic,assign) ZJRatingStyle style;

/// 星星的个数，默认5个
@property (nonatomic,assign) NSUInteger starCount;
/// 星星的间距
@property (nonatomic,assign) CGFloat starSpace;
/// 是否是图片模式
@property (nonatomic,assign) BOOL isImageMode;

/// 背景星星颜色（画布模式）
@property (nonatomic,strong) CAShapeLayer *backColorLayer;
///画布模式：遮罩层，图片模式：底视图
@property (nonatomic,strong) ZJRatingStarView *maskView;
/// 前置视图（图片模式）
@property (nonatomic,strong) ZJRatingStarView *frontStarView;
/// 不是点击触发的布局
@property (nonatomic,assign) BOOL isTouchLayout;

@end

@implementation ZJRatingView

- (instancetype)initWithStarCount:(NSInteger)starCount andSpace:(CGFloat)starSpace
{
    if (self = [super init]) {
        self.starCount = starCount;
        self.starSpace = starSpace;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setImgFrontName:(NSString *)imgFrontName
{
    _imgFrontName = imgFrontName;
    if (imgFrontName) {
        _isImageMode = YES;
    } else {
        _isImageMode = NO;
        [self.maskView removeFromSuperview];
        if (_frontStarView) {
            [self.frontStarView removeFromSuperview];
            _frontStarView = nil;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateLayers];
}

- (void)updateLayers
{
    if (!self.isTouchLayout) {
        self.maskView.frame = self.bounds;
        [self.maskView updateViewConstrains];
    }
    
    if (self.isImageMode) {
        if (!self.isTouchLayout) {
            self.frontStarView.frame = self.bounds;
            [self.frontStarView updateViewConstrains];
        }
    } else {
        self.backColorLayer.frame = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, self.frame.size.height/2)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
        self.backColorLayer.path = path.CGPath;
        self.backColorLayer.lineWidth = self.frame.size.height;
        self.backColorLayer.mask = self.maskView.layer;
        self.backColorLayer.strokeEnd = 0;
    }
    self.isTouchLayout = NO;
}

- (ZJRatingStarView *)maskView
{
    if (!_maskView) {
        _maskView = [[ZJRatingStarView alloc] initWithStarCount:self.starCount andSpace:self.starSpace];
        _maskView.starImgName = self.imgBackgroundName;
    }
    
    return _maskView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint newPoint = [self convertPoint:touchPoint toView:self.maskView];

    __block ZJRatingView *weakSelf = self;
    [self.maskView transformPointWithTouchPoint:newPoint completion:^(CGPoint transformPoint, CGFloat score) {
        [self strokeWithTransformPoint:transformPoint];
        if (weakSelf.scoreHandle) {
            weakSelf.scoreHandle(score);
        }
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint newPoint = [self convertPoint:touchPoint toView:self.maskView];

    __block ZJRatingView *weakSelf = self;
    [self.maskView transformPointWithTouchPoint:newPoint completion:^(CGPoint transformPoint, CGFloat score) {
        [self strokeWithTransformPoint:transformPoint];
        if (weakSelf.scoreHandle) {
            weakSelf.scoreHandle(score);
        }
    }];
}

- (void)strokeWithTransformPoint:(CGPoint)point
{
    CGPoint newPoint = [self convertPoint:point fromView:self.maskView];
    if (self.isImageMode) {
        self.isTouchLayout = YES;
        if (newPoint.x < 0)  newPoint.x = 0;
        self.frontStarView.frame = CGRectMake(0, 0, newPoint.x, self.frame.size.height);
        self.frontStarView.clipsToBounds = YES;
    } else {
        self.backColorLayer.strokeEnd = newPoint.x/self.frame.size.width;
    }
}

#pragma mark - 画布模式

- (CAShapeLayer *)backColorLayer
{
    if (!_backColorLayer) {
        _backColorLayer = [[CAShapeLayer alloc] init];
        _backColorLayer.fillColor = [UIColor clearColor].CGColor;       //填充色为透明（不设置为黑色）
        _backColorLayer.backgroundColor = self.brushBgColor ? self.brushBgColor.CGColor : [UIColor grayColor].CGColor;  //在这里是未填充的颜色
        _backColorLayer.strokeColor = self.brushColor ? self.brushColor.CGColor : [UIColor redColor].CGColor;       //路径颜色颜色（填充颜色）
        [self.layer addSublayer:_backColorLayer];
    }
    
    return _backColorLayer;
}

#pragma mark - 图片模式

- (ZJRatingStarView *)frontStarView
{
    if (!_frontStarView) {
        _frontStarView = [[ZJRatingStarView alloc] initWithStarCount:self.starCount andSpace:self.starSpace];
        _frontStarView.backgroundColor = [UIColor clearColor];
        _frontStarView.starImgName = self.imgFrontName;
        
        [self addSubview:self.maskView];
        [self addSubview:self.frontStarView];
    }
    
    return _frontStarView;
}

@end
