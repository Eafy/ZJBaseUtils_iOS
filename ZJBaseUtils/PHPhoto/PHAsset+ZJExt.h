//
//  PHAsset+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Photos/Photos.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (ZJExt)

/// 获取最后一张图片
+ (PHAsset *)latestPhotoAsset;

/// 获取最后一个视频
+ (PHAsset *)latestVideoAsset;

#pragma mark -

/// 获取缩略图
- (void)thumbnailImage:(CGSize)targetSize handler:(void(^)(UIImage * _Nullable img))imgHandler;

/// 获取完整图
- (void)originalImage:(void(^)(UIImage * _Nullable img))imgHandler;

/// 获取创建的时间戳
- (NSTimeInterval)createTimeInterval;

/// 获取路径
- (NSString * _Nullable)assetPath;

#pragma mark -

/// 是否是GIF图片
- (BOOL)isGIF;

@end

NS_ASSUME_NONNULL_END
