//
//  ZJPhoto.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import "ZJSingleton.h"
#import "ZJPHAsset.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZJAssetHandler)(ZJPHAsset *_Nullable asset);
typedef void (^ZJAlbumSaveHandler)(NSString *_Nullable assetStr, NSError *_Nullable error);
typedef void (^ZJAlbumReadImageHandler)(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info);
typedef void (^ZJAlbumReadVideoHandler)(AVAsset * _Nullable asset, UIImage * _Nullable image, CMTimeValue time);
typedef void (^ZJAlbumReadVideoPlayerItemHandler)(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info);
typedef void (^ZJAlbumOperateHandler)(BOOL success, id _Nullable dataObj, NSError *_Nullable erro);

@interface ZJPhoto : NSObject
singleton_h();

//是否有访问相册权限
+ (BOOL)isAuthorized;

/// 获取所有图片(无权限或无数据回调nil)
+ (void)allPhotoAssets:(void (^)(PHAsset *_Nullable asset))completion;

/// 获取所有视频(无权限或无数据回调nil)
+ (void)allVideoAssets:(void (^)(PHAsset *_Nullable asset))completion;

/// 获取最后一张图片
+ (void)latestPhotoAsset:(ZJAssetHandler _Nullable)callBack;

/// 获取最后一个视频
+ (void)latestVideoAsset:(ZJAssetHandler _Nullable)callBack;

/// 删除最后一张图片
+ (void)deleteLatestPhoto:(nullable void (^)(BOOL success))completion;

/// 删除最后一个视频
+ (void)deleteLatestVideo:(nullable void (^)(BOOL success))completion;

/// 获取本地沙盒视频长度（秒）
/// @param filePath 路径
/// @param options 视频参数
+ (CGFloat)videoTimeWithPath:(NSString *_Nonnull)filePath options:(NSDictionary * _Nullable)options;

#pragma mark -

/// 通过路径查找PHAsset
/// @param path localIdentifier或assets-library
- (PHAsset * _Nullable)findAssetFromPath:(NSString *)path;

/// 获取视频的首帧图片
/// @param asset AVAsset对象
- (UIImage * _Nullable)firstFrameWithVideoAsset:(AVAsset * _Nonnull)asset;

/// 获取视频的首帧图片
/// @param url 地址
/// @param options 视频参数
- (UIImage * _Nullable)firstFrameWithVideoURL:(NSURL *_Nonnull)url options:(NSDictionary * _Nullable)options;

/// 保存图片到系统相册
/// @param image 需要写入的图片
/// @param album 相册名称，如果相册不存在，则新建相册
/// @param handler 回调
- (void)saveImage:(UIImage *_Nonnull)image toAlbum:(NSString *_Nullable)album handler:(ZJAlbumSaveHandler _Nullable)handler;

/// 读取系统相册图片
/// @param url localIdentifier或assets-library
/// @param handler 回调
- (void)readImage:(NSString *_Nonnull)url handler:(ZJAlbumReadImageHandler _Nonnull)handler;

/// 保存视频到系统相册
/// @param filePath 沙盒视频文件路径
/// @param album 相册名称
/// @param handler 回调
- (void)saveVideo:(NSString *_Nonnull)filePath toAlbum:(NSString *_Nullable)album handler:(ZJAlbumSaveHandler _Nullable)handler;

/// 读取系统相册视频文件缩略图及时长
/// @param url localIdentifier或assets-library
/// @param handler 回调
- (void)readVideoInfo:(NSString *_Nonnull)url handler:(ZJAlbumReadVideoHandler _Nonnull)handler;

/// 读取系统视频播放句柄
/// @param url localIdentifier或assets-library
/// @param handler 回调
- (void)readVideoPlayerItem:(NSString *_Nonnull)url handler:(ZJAlbumReadVideoPlayerItemHandler _Nonnull)handler;

/// 删除系统图片或视频
/// @param urlArray localIdentifier或assets-library数组，同时仅支持一种类型
/// @param handler 回调，dataObj为沙盒存入的数组
- (void)deletePhotoOrVideo:(NSArray<NSString *> *_Nonnull)urlArray handler:(ZJAlbumOperateHandler _Nullable)handler;

/// 删除相册最后一张图片/视频
/// @param asset ZJPHAsset
- (void)deletePhotoOrVideoAsset:(ZJPHAsset * _Nonnull)asset completion:(nullable void (^)(BOOL success))completion;

/// 删除系统图片或视频
/// @param assetArray ZJPHAsset数组
/// @param handler 回调
- (void)deletePhotoOrVideoAssets:(NSArray<ZJPHAsset *> *_Nonnull)assetArray handler:(ZJAlbumOperateHandler _Nullable)handler;

/// 拷贝系统图片或视频
/// @param url localIdentifier或assets-library
/// @param savePath 保存到沙盒路径
/// @param handler 回调，dataObj为沙盒保存路径
- (void)copyPhotoOrVideo:(NSString *_Nonnull)url savePath:(NSString *_Nonnull)savePath handler:(ZJAlbumOperateHandler _Nullable)handler;

@end

NS_ASSUME_NONNULL_END
