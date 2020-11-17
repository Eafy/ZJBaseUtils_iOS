//
//  PHAsset+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "PHAsset+ZJExt.h"

@implementation PHAsset (ZJExt)

+ (PHAsset *)latestPhotoAsset
{
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
    return [assetsFetchResults firstObject];
}

+ (PHAsset *)latestVideoAsset
{
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:options];
    return [assetsFetchResults firstObject];
}

#pragma mark -

- (void)thumbnailImage:(CGSize)targetSize handler:(void(^)(UIImage * _Nullable img))imgHandler
{
    [[PHImageManager defaultManager] requestImageForAsset:self targetSize:targetSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (imgHandler) {
            imgHandler(result);
        }
    }];
}

- (void)originalImage:(void(^)(UIImage * _Nullable img))imgHandler
{
     [[PHImageManager defaultManager] requestImageForAsset:self targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
           if (imgHandler) {
               imgHandler(result);
           }
       }];
}

- (NSTimeInterval)createTimeInterval {
    return self.creationDate.timeIntervalSince1970;;
}

- (NSString * _Nullable)assetPath {
    return self.burstIdentifier;
}

@end
