//
//  ZJPHAsset.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <ZJBaseUtils/PHAsset+ZJExt.h>

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
/// 文件链接地址
@property (nonatomic, strong) NSString *fileURL NS_DEPRECATED(2_0, 2_0, 8_0, 13_0, "iOS 13已无效");

@end

NS_ASSUME_NONNULL_END
