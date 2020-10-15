//
//  NSFileManager+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "NSFileManager+ZJExt.h"
#import <CoreServices/CoreServices.h>

@implementation NSFileManager (ZJExt)

#pragma mark - StaticAPI

+ (NSString *)zj_documentsPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)zj_documentsPath:(NSString *)fileName isCreate:(BOOL)isCreate
{
    NSString *path = [self zj_documentsPath];
    path = [path stringByAppendingPathComponent:fileName];
    if (isCreate && ![NSFileManager zj_isExist:path]) {
        if ([NSFileManager zj_create:path data:nil]) {
            return path;
        } else {
            return @"";
        }
    }
    return path;
}

+ (NSString *)zj_cachesPath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)zj_cachesPath:(NSString *)fileName isCreate:(BOOL)isCreate
{
    NSString *path = [self zj_cachesPath];
    path = [path stringByAppendingPathComponent:fileName];
    if (isCreate && ![NSFileManager zj_isExist:path]) {
        if ([NSFileManager zj_create:path data:nil]) {
            return path;
        } else {
            return @"";
        }
    }
    return path;
}

+ (BOOL)zj_isExist:(NSString *)filePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)zj_isExistDirectory:(NSString *)path
{
    BOOL isDirectory = NO;
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return result && isDirectory;
}

+ (NSArray<NSString *> *)zj_fileLists:(NSString *)path
{
    NSArray<NSString *> *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    return array;
}

+ (BOOL)zj_create:(NSString *)path data:(NSData *)data
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return [fileManager createFileAtPath:path contents:data attributes:nil];
    }

    return NO;
}

+ (BOOL)zj_createDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return [fileManager createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
    } else {
        return [self zj_isExistDirectory:path];
    }
}

+ (BOOL)zj_delete:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return [fileManager removeItemAtPath:path error:NULL];
    }
    
    return NO;
}

+ (BOOL)zj_move:(NSString *)path toPath:(NSString *)toPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return [fileManager moveItemAtPath:path toPath:toPath error:nil];
    }

    return NO;
}

+ (BOOL)zj_write:(NSString *)path data:(NSData *)data isAppend:(Boolean)isAppend
{
    if (!path || !data) return NO;
    if (!isAppend) {
        [self zj_delete:path];
    }
    if (![self zj_create:path data:nil]) return NO;

    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    if (fileHandle) {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
        return YES;
    }

    return NO;
}

+ (BOOL)zj_copy:(NSString *)path toPath:(NSString *)toPath
{
    if (!toPath) return NO;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return [fileManager copyItemAtPath:path toPath:toPath error:nil];
    }

    return NO;
}

+ (NSString *)zj_find:(NSString *)path fileName:(NSString *)fileName isTraversing:(BOOL)isTraversing
{
    NSMutableArray *traversingDic = [NSMutableArray array];
    NSArray<NSString *> *array = [self zj_fileLists:path];
    for (NSString *subName in array) {
        if ([subName isEqualToString:fileName]) {
            return path;
        } else {
            NSString *subPathDic = [path stringByAppendingPathComponent:subName];
            if (isTraversing && [self zj_isExistDirectory:subPathDic]) {
                [traversingDic addObject:subPathDic];
            }
        }
    }
    
    //算法2，逐层遍历；
    for (NSString *subName in traversingDic) {
        NSString *realPath = [self zj_find:subName fileName:fileName isTraversing:isTraversing];
        if (realPath) {
            return realPath;
        }
    }
    
    return nil;
}

+ (NSData *)zj_fileData:(NSString *)filePath
{
    return [NSData dataWithContentsOfFile:filePath];
}

+ (NSUInteger)zj_size:(NSString *)path
{
    unsigned long long size = 0;
    BOOL isDir, exist;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    exist = [fm fileExistsAtPath:path isDirectory:&isDir];
    if (exist) {
        if (isDir) {
            NSArray *arr = [fm contentsOfDirectoryAtPath:path error:nil];
            for (NSString *fileName in arr) {
                NSString *filePath = [path stringByAppendingPathComponent:fileName];
                exist = [fm fileExistsAtPath:filePath isDirectory:&isDir];
                if (isDir) {
                    size += [self zj_size:filePath];
                }else
                    size += [[fm attributesOfItemAtPath:filePath error:nil] fileSize];
            }
        } else {
            size = [[fm attributesOfItemAtPath:path error:nil] fileSize];
        }
    }
    
    return (NSUInteger)size;
}

+ (NSUInteger)zj_totalDiskSizeOfSystem
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
     NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
     NSNumber *number = attributes[NSFileSystemSize];
     return [number unsignedIntegerValue];
}

+ (NSUInteger)zj_freeDiskSizeOfSystem
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = attributes[NSFileSystemFreeSize];
    return [number unsignedIntegerValue];
}

+ (NSUInteger)zj_filesSize:(NSArray *)paths
{
    NSUInteger size = 0;
    
    for (NSString *path in paths) {
        size += [[self class] zj_size:path];
    }
    
    return size;
}

+ (void)zj_clearFiles:filepPath completion:(void (^)(BOOL finished))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *fm = [NSFileManager defaultManager];
        __block NSError *error = nil;
        if ([fm fileExistsAtPath:filepPath]) {
            __block BOOL ret = [fm removeItemAtPath:filepPath error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(ret && !error);
            });
        }
    });
}

#pragma mark -

+ (NSString *)zj_mimeTypeForPath:(NSString *)filepath
{
    NSString *fileExtension = [filepath pathExtension];
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)fileExtension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    
    if (contentType) {
        return contentType;
    }
    return @"application/octet-stream";
}

@end
