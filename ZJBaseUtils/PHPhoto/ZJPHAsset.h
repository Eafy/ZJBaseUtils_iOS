//
//  ZJPHAsset.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "PHAsset+ZJExt.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJPHAsset : NSObject

/// 原始句柄对象
@property (nonatomic, strong) PHAsset *phAsset;

/// 播放句柄
@property (nonatomic, strong) AVPlayerItem *_Nullable playerItem;

/// 方向
@property (nonatomic, assign) CGImagePropertyOrientation imageOrientation;
/// 缩略图
@property (nonatomic, strong) UIImage * _Nullable image;
/// 信息字段
@property (nonatomic, strong) NSDictionary *infoDic;

@end

NS_ASSUME_NONNULL_END
