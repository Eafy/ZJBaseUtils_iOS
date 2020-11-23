//
//  ZJRatingStarView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJRatingStarView.h"
#import "ZJRatingView.h"

@interface ZJRatingStarView ()

@property (nonatomic,assign) ZJRatingStyle style;

/// 星星的个数
@property (nonatomic,assign) NSUInteger starCount;
/// 星星的间距
@property (nonatomic,assign) CGFloat starSpace;
/// 星星图标视图
@property (nonatomic,strong) NSMutableArray *starItemArray;

@end

@implementation ZJRatingStarView

- (instancetype)initWithStarCount:(NSInteger)starCount andSpace:(CGFloat)starSpace
{
    if (self = [super init]) {
        self.starCount = starCount;
        self.starSpace = starSpace;
        [self createStartItems];
    }
    return self;
}

- (NSMutableArray *)starItemArray
{
    if (!_starItemArray) {
        _starItemArray = [NSMutableArray array];
    }
    
    return _starItemArray;
}

- (void)createStartItems
{
    UIImageView *item = nil;
    for (int i =0; i<self.starCount; i++) {
        if (self.starImgName) {
            item = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.starImgName]];
        } else {
            item = [[UIImageView alloc] init];
        }
        item.contentMode = UIViewContentModeScaleAspectFit;
        [self.starItemArray addObject:item];
        [self addSubview:item];
    }
}

- (void)setStarImgName:(NSString *)starImgName
{
    _starImgName = starImgName;
    for (UIImageView *item in self.starItemArray) {
        item.image = [UIImage imageNamed:starImgName];
    }
}

- (void)updateViewConstrains
{
    if (self.starCount == 0) return;
    
    CGFloat width = (self.frame.size.width - (self.starCount -1) * self.starSpace) / self.starCount;
    if (width > 0) {
        CGFloat x = 0;
        for (UIImageView * view in self.starItemArray) {
            view.frame = CGRectMake(x, 0, width, self.frame.size.height);
            x += width + self.starSpace;
        }
    }
}

- (CGPoint)transformPointWithTouchPoint:(CGPoint)touchPoint completion:(void(^)(CGPoint transformPoint, NSInteger score))completion
{
    if (self.starCount == 0) return CGPointZero;
    
    CGFloat totolScore = 10.0f;
    NSInteger average = totolScore/[self.starItemArray count];  //平均分
    CGFloat x = touchPoint.x;   //触摸点
    CGFloat score = 0;  //得分

    for (NSInteger i = [self.starItemArray count]-1; i>=0; i--) {
        UIImageView *item = self.starItemArray[i];
        if (x > item.frame.origin.x) {
            switch (self.style) {
                case ZJRatingStyleStarFull:     //满星
                    score = (i + 1) * average;
                    x = item.frame.origin.x + item.frame.size.width;
                    break;
                case ZJRatingStyleStarHalf:    //半星
                    if (x > (item.frame.origin.x + item.frame.size.width/2)) {  //超过半星
                        score = (i + 1) * average;
                        x = item.frame.origin.x + item.frame.size.width;
                    } else {
                        score = (i + 1) * average - average/2;
                        x = item.frame.origin.x + item.frame.size.width/2;
                    }
                    break;
                default:
                    break;
            }
            break;
        }
    }
    
    CGPoint transformPoint = CGPointMake(x, touchPoint.y);
    if (completion) {
        completion(transformPoint, score);
    }
    return CGPointZero;
}

@end
