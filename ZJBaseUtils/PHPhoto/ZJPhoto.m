//
//  ZJPhoto.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJPhoto.h"
#import "PHAsset+ZJExt.h"

@implementation ZJPhoto
singleton_m();

- (void)initData {
}

+ (BOOL)isAuthorized
{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    return (authStatus == PHAuthorizationStatusAuthorized);
}

+ (void)latestPhotoAsset:(ZJAssetHandler _Nullable)callBack
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            PHAsset *asset = [PHAsset latestPhotoAsset];
            if (asset) {
                PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
                [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                    ZJPHAsset *asset = nil;
                    if (imageData) {
                        asset = [[ZJPHAsset alloc] init];
                        asset.image = [UIImage imageWithData:imageData];
                        if ([info objectForKey:@"PHImageFileURLKey"]) {
                            asset.url = [info objectForKey:@"PHImageFileURLKey"];
                        }
                    }
                    if (callBack) {
                        callBack(asset);
                    }
                }];
            } else {
                if (callBack) {
                    callBack(nil);
                }
            }
        } else {
            NSLog(@"PHAuthorization Status: %ld",(long)status);
            if (callBack) {
                callBack(nil);
            }
        }
    }];
}

+ (void)latestVideoAsset:(ZJAssetHandler _Nullable)callBack
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            PHAsset *asset = [PHAsset latestVideoAsset];
            if (asset) {
                PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
                [imageManager requestPlayerItemForVideo:asset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
                    
                    ZJPHAsset *asset = nil;
                    if (playerItem) {
                        asset = [[ZJPHAsset alloc] init];
                        asset.playerItem = playerItem;
                        if ([info objectForKey:@"PHImageFileSandboxExtensionTokenKey"]) {
                            NSString *videoStr = [info objectForKey:@"PHImageFileSandboxExtensionTokenKey"];
                            NSArray *strArr = [videoStr componentsSeparatedByString:@";"];     //分割
                            asset.url = [NSURL URLWithString:[strArr lastObject]];
                        }
                    }
                    if (callBack) {
                        callBack(asset);
                    }
                }];
            } else {
                if (callBack) {
                    callBack(nil);
                }
            }
        } else {
            NSLog(@"PHAuthorization Status: %ld",(long)status);
            if (callBack) {
                callBack(nil);
            }
        }
    }];
}

+ (CGFloat)videoTimeWithLocalPath:(NSString *_Nonnull)filePath
{
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:options];//
    return round(urlAsset.duration.value/(urlAsset.duration.timescale*1.0)); //获取视频时长，单位：秒
}

#pragma mark -

- (PHAssetCollection *)fetchAssetColletion:(NSString *)albumTitle
{
    if (!albumTitle || [albumTitle isEqualToString:@""]) return nil;
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    
    return nil;
}

- (PHAsset *)findAssetFromPath:(NSString *)path
{
    PHAsset *asset = nil;
    if ([path containsString:@"assets-library"]) {
        asset = [PHAsset fetchAssetsWithALAssetURLs:[NSArray arrayWithObject:[NSURL URLWithString:path]] options:nil].firstObject;
    } else {
        asset = [PHAsset fetchAssetsWithLocalIdentifiers:[NSArray arrayWithObject:path] options:nil].firstObject;
    }
    return asset;
}

- (UIImage *)firstFrameWithVideoAsset:(AVAsset *)asset
{
    if (!asset) return nil;
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 60) actualTime:NULL error:&error];
    if (!error && img && img!=0x0) {
        UIImage *image = [UIImage imageWithCGImage:img];
        CGImageRelease(img);
        return image;
    }
    
    return nil;
}

- (UIImage *)firstFrameWithVideoURL:(NSURL *)url
{
    if (!url) return nil;
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:opts];
    return [self firstFrameWithVideoAsset:asset];
}

- (void)saveImage:(UIImage *_Nonnull)image toAlbum:(NSString *_Nullable)album handler:(ZJAlbumSaveHandler _Nullable)handler
{
    __block NSString *localIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollection *assetCollection = [self fetchAssetColletion:album];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = nil;
        if (assetCollection) {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:album];
        }
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        localIdentifier = assetChangeRequest.placeholderForCreatedAsset.localIdentifier;
        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
        if (placeholder != nil ) {
            [assetCollectionChangeRequest addAssets:@[placeholder]];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (handler) {
            if (success) {
                handler(localIdentifier, error);
            } else {
                handler(nil, error);
            }
        }
    }];
}

- (void)readImage:(NSString *_Nonnull)url handler:(ZJAlbumReadImageHandler _Nonnull)handler
{
    if (url && ![url isEqualToString:@""]) {
        PHAsset *asset = [self findAssetFromPath:url];
        
        if (asset) {
            [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                if (imageData) {
                    handler(imageData, dataUTI, orientation, info);
                } else {
                    handler(nil, nil, UIImageOrientationUp, nil);
                }
            }];
        } else {
            handler(nil, nil, UIImageOrientationUp, nil);
        }
    } else {
        handler(nil, nil, UIImageOrientationUp, nil);
    }
}

- (void)saveVideo:(NSString *_Nonnull)filePath toAlbum:(NSString *_Nullable)album handler:(ZJAlbumSaveHandler _Nullable)handler
{
    __block NSString *localIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollection *assetCollection = [self fetchAssetColletion:album];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = nil;
        if (assetCollection) {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:album];
        }
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL URLWithString:filePath]];
        localIdentifier = assetChangeRequest.placeholderForCreatedAsset.localIdentifier;
        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
        if (placeholder != nil ) {
            [assetCollectionChangeRequest addAssets:@[placeholder]];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (handler) {
            if (success) {
                handler(localIdentifier, error);
            } else {
                handler(nil, error);
            }
        }
    }];
}

- (void)readVideoInfo:(NSString *_Nonnull)url handler:(ZJAlbumReadVideoHandler _Nonnull)handler
{
    if (url && ![url isEqualToString:@""]) {
        PHAsset *asset = [self findAssetFromPath:url];
        
        if (asset) {
            [[PHCachingImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                if (asset) {
                    UIImage *image = [self firstFrameWithVideoAsset:asset];
                    CMTimeValue time = asset.duration.value/asset.duration.timescale;
                    handler(asset, image, time);
                } else {
                    handler(nil, nil, 0);
                }
            }];
        } else {
            handler(nil, nil, 0);
        }
    } else {
        handler(nil, nil, 0);
    }
}

- (void)readVideoPlayerItem:(NSString *_Nonnull)url handler:(ZJAlbumReadVideoPlayerItemHandler _Nonnull)handler
{
    if (url && ![url isEqualToString:@""]) {
        PHAsset *asset = [self findAssetFromPath:url];
        
        if (asset) {
            [[PHCachingImageManager defaultManager] requestPlayerItemForVideo:asset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
                if (playerItem) {
                    handler(playerItem, info);
                } else {
                    handler(nil, nil);
                }
            }];
        } else {
            handler(nil, nil);
        }
    } else {
        handler(nil, nil);
    }
}

- (void)deletePhotoOrVideo:(NSArray<NSString *> *_Nonnull)urlArray handler:(ZJAlbumOperateHandler _Nullable)handler
{
    if (urlArray.count > 0) {
        BOOL isExistAsset = NO;
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *urlStr in urlArray) {
            if (!isExistAsset && [urlStr containsString:@"assets-library"]) {
                isExistAsset = YES;
            }
            [array addObject:[NSURL URLWithString:urlStr]];
        }
        
        PHFetchResult *assetResult = nil;
        if (isExistAsset) {
            assetResult = [PHAsset fetchAssetsWithALAssetURLs:array options:nil];
        } else {
            assetResult = [PHAsset fetchAssetsWithLocalIdentifiers:urlArray options:nil];
        }
        
        if (assetResult) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [PHAssetChangeRequest deleteAssets:assetResult];
            } completionHandler:^(BOOL success, NSError *error) {
                if (handler) {
                    handler(success, urlArray, error);
                }
            }];
        } else {
            if (handler) {
                handler(YES, urlArray, nil);
            }
        }
    } else {
        if (handler) {
            handler(YES, urlArray, nil);
        }
    }
}

- (void)copyPhotoOrVideo:(NSString *_Nonnull)url savePath:(NSString *_Nonnull)savePath handler:(ZJAlbumOperateHandler _Nullable)handler
{
    if (url && ![url isEqualToString:@""]) {
        PHAsset *asset = [self findAssetFromPath:url];
        
        if (asset) {
            [[PHCachingImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                if (asset) {
                    NSError *error;
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    NSURL *fileURL = [NSURL fileURLWithPath:savePath];
                    if ([[NSFileManager defaultManager] copyItemAtURL:urlAsset.URL toURL:fileURL error:&error]) {
                        if (handler) {
                            handler(YES, savePath, error);
                        }
                    } else if (handler){
                        handler(NO, savePath, error);
                    }
                }
            }];
        } else if (handler){
            handler(NO, savePath, nil);
        }
    } else if (handler) {
        handler(NO, savePath, nil);
    }
}


@end
