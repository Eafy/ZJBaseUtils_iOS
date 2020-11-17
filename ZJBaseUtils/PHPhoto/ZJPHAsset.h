//
//  ZJPHAsset.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJPHAsset : PHAsset

@property (nonatomic, strong) NSURL *_Nullable url;
@property (nonatomic, assign, readonly) NSTimeInterval creationTimeInterval;//创建时间戳
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) AVPlayerItem *_Nullable playerItem;
@property (nonatomic, strong) UIImage * _Nullable image;

- (instancetype)initWithPlayerItem:(AVPlayerItem * _Nullable)playerItem;

- (instancetype)initWithUrl:(NSURL *_Nullable)url;

@end

NS_ASSUME_NONNULL_END
