//
//  ZJRatingView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJRatingView.h>
#import <ZJBaseUtils/ZJRatingStarView.h>
#import <ZJBaseUtils/ZJBundleRes.h>

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
@property (nonatomic,strong) ZJRatingStarView *maskInsideView;
/// 前置视图（图片模式）
@property (nonatomic,strong) ZJRatingStarView *frontStarView;
/// 不是点击触发的布局
@property (nonatomic,assign) BOOL isTouchLayout;

/// 初始评分：10.0
@property (nonatomic,assign) CGFloat firstScore;

@end

@implementation ZJRatingView

- (instancetype)initWithStarCount:(NSInteger)starCount andSpace:(CGFloat)starSpace
{
    if (self = [super init]) {
        self.starCount = starCount;
        self.starSpace = starSpace;
        self.defaultImage = [ZJBundleRes imageNamed:@"icon_rating_star_normal"];
        self.frontImage = [ZJBundleRes imageNamed:@"icon_rating_star_highlighted"];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setFrontImage:(UIImage *)frontImage
{
    _frontImage = frontImage;
    if (frontImage) {
        _isImageMode = YES;
    } else {
        _isImageMode = NO;
        [self.maskInsideView removeFromSuperview];
        if (_frontStarView) {
            [self.frontStarView removeFromSuperview];
            _frontStarView = nil;
        }
    }
}

- (void)setDefaultImage:(UIImage *)defaultImage
{
    _defaultImage = defaultImage;
    if (_maskInsideView) {
        self.maskInsideView.defaultImage = defaultImage;
    }
}

- (void)setScore:(CGFloat)score
{
    if (score < 0) {
        _score = 0;
    } else if (score > 10) {
        _score = 10.0;
    } else {
        _score = score;
    }
    self.firstScore = score;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateLayers];
}

- (void)updateLayers
{
    if (!self.isTouchLayout) {
        self.maskInsideView.frame = self.bounds;
        [self.maskInsideView updateViewConstrains];
    }
    
    if (self.isImageMode) {
        if (!self.isTouchLayout) {
            self.frontStarView.frame = self.bounds;
            [self.frontStarView updateViewConstrains];
            
            //初始评分
            [self strokeWithTransformPoint:CGPointMake(self.frame.size.width * self.firstScore/10.0, self.frame.size.height) score:self.firstScore];
        }
    } else {
        self.backColorLayer.frame = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, self.frame.size.height/2)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
        self.backColorLayer.path = path.CGPath;
        self.backColorLayer.lineWidth = self.frame.size.height;
        self.backColorLayer.mask = self.maskInsideView.layer;
        self.backColorLayer.strokeEnd = self.firstScore / 10.0;
    }
    self.isTouchLayout = NO;
}

- (ZJRatingStarView *)maskInsideView
{
    if (!_maskInsideView) {
        _maskInsideView = [[ZJRatingStarView alloc] initWithStarCount:self.starCount andSpace:self.starSpace];
        _maskInsideView.defaultImage = self.defaultImage;
    }
    
    return _maskInsideView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint newPoint = [self convertPoint:touchPoint toView:self.maskInsideView];

    [self.maskInsideView transformPointWithTouchPoint:newPoint completion:^(CGPoint transformPoint, CGFloat score) {
        [self strokeWithTransformPoint:transformPoint score:score];
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint newPoint = [self convertPoint:touchPoint toView:self.maskInsideView];

    [self.maskInsideView transformPointWithTouchPoint:newPoint completion:^(CGPoint transformPoint, CGFloat score) {
        [self strokeWithTransformPoint:transformPoint score:score];
    }];
}

- (void)strokeWithTransformPoint:(CGPoint)point score:(CGFloat)score
{
    CGPoint newPoint = [self convertPoint:point fromView:self.maskInsideView];
    if (self.isImageMode) {
        self.isTouchLayout = YES;
        if (newPoint.x < 0)  newPoint.x = 0;
        self.frontStarView.frame = CGRectMake(0, 0, newPoint.x, self.frame.size.height);
        self.frontStarView.clipsToBounds = YES;
    } else {
        self.backColorLayer.strokeEnd = newPoint.x/self.frame.size.width;
    }
    
    if (_score != score && _scoreHandle) {
        _score = score;
        self.scoreHandle(score);
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
        _frontStarView.defaultImage = self.frontImage;
        
        [self addSubview:self.maskInsideView];
        [self addSubview:self.frontStarView];
    }
    
    return _frontStarView;
}

@end
