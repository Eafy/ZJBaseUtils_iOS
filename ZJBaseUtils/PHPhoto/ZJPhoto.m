//
//  ZJPhoto.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJPhoto.h>
#import <ZJBaseUtils/PHAsset+ZJExt.h>
#import <ZJBaseUtils/NSFileManager+ZJExt.h>
#import <AVFoundation/AVFoundation.h>
#import <ZJBaseUtils/ZJSystem.h>

@interface ZJPhoto ()

@property (nonatomic,strong) AVAssetExportSession *saveSession;

@end

@implementation ZJPhoto
singleton_m();

- (void)initData {
}

+ (BOOL)isAuthorized
{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    return (authStatus == PHAuthorizationStatusAuthorized);
}

+ (void)allPhotoAssets:(void (^)(PHAsset *_Nullable asset))completion
{
    [ZJSystem requestPhotoPermission:^(BOOL success) {
        if (success) {
            PHFetchOptions *options = [[PHFetchOptions alloc] init];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
            if (assetsFetchResults) {
                for (PHAsset *asset in assetsFetchResults) {
                    if (asset && completion) completion(asset);
                }
            } else {
                if (completion) completion(nil);
            }
        } else {
            if (completion) completion(nil);
        }
    }];
}

+ (void)allVideoAssets:(void (^)(PHAsset *_Nullable asset))completion
{
    [ZJSystem requestPhotoPermission:^(BOOL success) {
        if (success) {
            PHFetchOptions *options = [[PHFetchOptions alloc] init];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:options];
            if (assetsFetchResults) {
                for (PHAsset *asset in assetsFetchResults) {
                    if (asset && completion) completion(asset);
                }
            } else {
                if (completion) completion(nil);
            }
        } else {
            if (completion) completion(nil);
        }
    }];
}

+ (void)latestPhotoAsset:(ZJAssetHandler _Nullable)callBack
{
    [ZJSystem requestPhotoPermission:^(BOOL success) {
        if (success) {
            __block PHAsset *phAsset = [PHAsset latestPhotoAsset];
            if (phAsset) {
                if (@available(iOS 13, *)) {
                    [[PHImageManager defaultManager] requestImageDataAndOrientationForAsset:phAsset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, CGImagePropertyOrientation orientation, NSDictionary * _Nullable info) {
                        ZJPHAsset *asset = [[ZJPHAsset alloc] init];
                        asset.phAsset = phAsset;
                        asset.imageOrientation = orientation;
                        asset.infoDic = info.copy;
                        if (imageData) {
                            asset.image = [UIImage imageWithData:imageData];
                        }
                        if (callBack) {
                            callBack(asset);
                        }
                    }];
                } else {
                    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
                    [imageManager requestImageDataForAsset:phAsset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                        ZJPHAsset *asset = [[ZJPHAsset alloc] init];
                        asset.phAsset = phAsset;
                        asset.imageOrientation = (CGImagePropertyOrientation)orientation;
                        asset.infoDic = info.copy;
                        
                        if (imageData) {
                            asset.image = [UIImage imageWithData:imageData];
                        }
                        if ([info objectForKey:@"PHImageFileURLKey"]) {
                            asset.fileURL = [info objectForKey:@"PHImageFileURLKey"];
                        }
                        
                        if (callBack) {
                            callBack(asset);
                        }
                    }];
                }
            } else {
                if (callBack) {
                    callBack(nil);
                }
            }
        } else {
            if (callBack) {
                callBack(nil);
            }
        }
    }];
}

+ (void)latestVideoAsset:(ZJAssetHandler _Nullable)callBack
{
    [ZJSystem requestPhotoPermission:^(BOOL success) {
        if (success) {
            PHAsset *phAsset = [PHAsset latestVideoAsset];
            if (phAsset) {
                PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
                [imageManager requestPlayerItemForVideo:phAsset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
                    ZJPHAsset *asset = [[ZJPHAsset alloc] init];
                    asset.phAsset = phAsset;
                    if (playerItem) {
                        asset.playerItem = playerItem;
                    }
                    
                    NSString *filePath = [info objectForKey:@"PHImageFileSandboxExtensionTokenKey"];
                    if (filePath) {
                        NSArray *strArr = [filePath componentsSeparatedByString:@";"];     //分割
                        asset.fileURL = [strArr lastObject];
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
            if (callBack) {
                callBack(nil);
            }
        }
    }];
}

+ (void)deleteLatestPhoto:(nullable void (^)(BOOL success))completion
{
    [ZJPhoto latestPhotoAsset:^(ZJPHAsset * _Nullable asset) {
        if (asset) {
            [[ZJPhoto shared] deletePhotoOrVideoAsset:asset completion:^(BOOL success) {
                if (completion) completion(success);
            }];
        } else if (completion) {
            completion(YES);
        }
    }];
}

+ (void)deleteLatestVideo:(nullable void (^)(BOOL success))completion
{
    [ZJPhoto latestVideoAsset:^(ZJPHAsset * _Nullable asset) {
        if (asset) {
            [[ZJPhoto shared] deletePhotoOrVideoAsset:asset completion:^(BOOL success) {
                if (completion) completion(success);
            }];
        } else if (completion) {
            completion(YES);
        }
    }];
}

+ (CGFloat)videoTimeWithPath:(NSString *_Nonnull)filePath options:(NSDictionary *)options
{
    if (!filePath) return 0;
    NSMutableDictionary *opts = NULL;
    if (options) {
        opts = [NSMutableDictionary dictionaryWithDictionary:options];
    } else {
        opts = [NSMutableDictionary dictionary];
    }
    [opts setValue:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    
    NSURL *url = nil;
    if ([filePath hasPrefix:@"http://"] || [filePath hasPrefix:@"https://"]) {
        url = [NSURL URLWithString:filePath];
    } else {
        url = [NSURL fileURLWithPath:filePath];
    }

    if (url) {
        AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:opts];
        return round(asset.duration.value/(asset.duration.timescale*1.0)); //获取视频时长，单位：秒
    }
    return 0;
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

- (UIImage *)firstFrameWithVideoURL:(NSURL *)url options:(NSDictionary *)options
{
    if (!url) return nil;
    NSMutableDictionary *opts = NULL;
    if (options) {
        opts = [NSMutableDictionary dictionaryWithDictionary:options];
    } else {
        opts = [NSMutableDictionary dictionary];
    }
    [opts setObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:opts];
    return [self firstFrameWithVideoAsset:asset];
}

- (void)saveImage:(UIImage *_Nonnull)image toAlbum:(NSString *_Nullable)album handler:(ZJAlbumSaveHandler _Nullable)handler
{
    __block NSString *localIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        localIdentifier = assetChangeRequest.placeholderForCreatedAsset.localIdentifier;
        
        if (album && ![album isEqualToString:@""]) {
            PHAssetCollection *assetCollection = [self fetchAssetColletion:album];
            PHAssetCollectionChangeRequest *assetCollectionChangeRequest = nil;
            if (assetCollection) {
                assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            } else {
                assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:album];
            }
            PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
            if (placeholder != nil) {
                [assetCollectionChangeRequest addAssets:@[placeholder]];
            }
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
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL URLWithString:filePath]];
        localIdentifier = assetChangeRequest.placeholderForCreatedAsset.localIdentifier;
        
        if (album && ![album isEqualToString:@""]) {
            PHAssetCollection *assetCollection = [self fetchAssetColletion:album];
            PHAssetCollectionChangeRequest *assetCollectionChangeRequest = nil;
            if (assetCollection) {
                assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            } else {
                assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:album];
            }
            PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
            if (placeholder != nil ) {
                [assetCollectionChangeRequest addAssets:@[placeholder]];
            }
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

- (void)deletePhotoOrVideoAsset:(ZJPHAsset * _Nonnull)asset completion:(void (^)(BOOL finished))completion
{
    PHFetchResult *assetResult = nil;
    if (asset.phAsset) {
        assetResult = [PHAsset fetchAssetsWithLocalIdentifiers:@[asset.phAsset.localIdentifier] options:nil];
    } else if (asset.fileURL) {
        assetResult = [PHAsset fetchAssetsWithLocalIdentifiers:@[asset.fileURL] options:nil];
    }
    
    if (assetResult) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetChangeRequest deleteAssets:assetResult];
        } completionHandler:^(BOOL success, NSError *error) {
            if (completion) {
                completion(success);
            }
        }];
    } else {
        if (completion) {
            completion(NO);
        }
    }
}

- (void)deletePhotoOrVideoAssets:(NSArray<ZJPHAsset *> *_Nonnull)assetArray handler:(ZJAlbumOperateHandler _Nullable)handler
{
    NSMutableArray *array = [NSMutableArray array];
    for (ZJPHAsset *asset in assetArray) {
        if (asset.phAsset) {
            [array addObject:asset.phAsset.localIdentifier];
        } else if (asset.fileURL) {
            [array addObject:asset.fileURL];
        }
    }
    
    if (array.count > 0) {
        PHFetchResult *assetResult = [PHAsset fetchAssetsWithLocalIdentifiers:array options:nil];
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetChangeRequest deleteAssets:assetResult];
        } completionHandler:^(BOOL success, NSError *error) {
            if (handler) {
                handler(success, array, error);
            }
        }];
    } else {
        if (handler) {
            handler(YES, array, nil);
        }
    }
}

- (void)copyPhotoOrVideo:(NSString *_Nonnull)url savePath:(NSString *_Nonnull)savePath handler:(ZJAlbumOperateHandler _Nullable)handler
{
    if (url && ![url isEqualToString:@""] && savePath && ![savePath isEqualToString:@""]) {
        NSString *outDir = [savePath stringByDeletingLastPathComponent];
        [NSFileManager zj_createDirectory:outDir];
        NSLog(@"Save file path: %@", url);
        NSLog(@"Out file path: %@", savePath);
        
        if ([url hasPrefix:@"file:///"]) {
            [self copyPhotoOrVideoUseSession:url savePath:savePath handler:handler];
        } else {
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
        }
    } else if (handler) {
        handler(NO, savePath, nil);
    }
}

#pragma mark -

- (void)copyPhotoOrVideoUseSession:(NSString *_Nonnull)url savePath:(NSString *_Nonnull)savePath handler:(ZJAlbumOperateHandler _Nullable)handler
{
    NSURL *readUrl = [NSURL fileURLWithPath:url];
    NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
    if (ZJSystem.isSimulator) {
        handler(YES, url, nil);
        return;
    }
    
    if (_saveSession) {
        [self.saveSession cancelExport];
        _saveSession = nil;
    }
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:readUrl options:nil];
    AVFileType fileType = AVFileTypeMPEG4;
    
    NSString *mimeType = [NSFileManager zj_mimeType:url];
    if ([mimeType containsString:@"image"]) {
        if (@available(iOS 11.0, *)) {
            fileType = AVFileTypeJPEG;
        } else {
            BOOL ret = false;
            UIImage *img = [UIImage imageWithContentsOfFile:url];
            if (img) {
                ret = [UIImagePNGRepresentation(img) writeToFile:savePath atomically:YES];
            }
            if (handler) {
                handler(ret, ret ? savePath : nil, nil);
            }
            return;
        }
    } else {
        AVMutableComposition *mainComposition = [[AVMutableComposition alloc] init];
        AVMutableCompositionTrack *compositionVideoTrack = [mainComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
                    
        int timeScale = 100000;
        Float64 seconds = CMTimeGetSeconds([urlAsset duration]) - 0.001;
        NSUInteger videoDurationI = (NSUInteger) (seconds * timeScale);
        CMTime videoDuration = CMTimeMake(videoDurationI, timeScale);
        CMTimeRange videoTimeRange = CMTimeRangeMake(kCMTimeZero, videoDuration);
                    
        NSArray<AVAssetTrack *> *videoTracks = [urlAsset tracksWithMediaType:AVMediaTypeVideo];
        if (videoTracks.count == 0) {
            if (handler) {
                handler(NO, nil, nil);
            }
            return;
        }
        AVAssetTrack *videoTrack = [videoTracks objectAtIndex:0];

        [compositionVideoTrack insertTimeRange:videoTimeRange ofTrack:videoTrack atTime:kCMTimeZero error:nil];
        urlAsset = (AVURLAsset *)mainComposition;
    }
    
    self.saveSession = [AVAssetExportSession exportSessionWithAsset:urlAsset presetName:AVAssetExportPresetHighestQuality];
    self.saveSession.outputURL = saveUrl;
    self.saveSession.outputFileType = fileType;
    self.saveSession.shouldOptimizeForNetworkUse = YES;
    
    __weak ZJPhoto *weakSelf = self;
    [self.saveSession exportAsynchronouslyWithCompletionHandler:^(void) {
        if (weakSelf.saveSession.status == AVAssetExportSessionStatusCancelled) {
            return;
        }
        
        BOOL ret = weakSelf.saveSession.status == AVAssetExportSessionStatusCompleted;
        if (ret) {
            NSLog(@"Save file to sandbox success:%ld path:%@", (long)weakSelf.saveSession.status, savePath);
        } else {
            NSLog(@"Save file to sandbox error:%@ path:%@", weakSelf.saveSession.error, savePath);
        }
        if (handler) {
            handler(ret, ret ? savePath : nil, weakSelf.saveSession.error);
        }
        weakSelf.saveSession = nil;
    }];
}

@end
