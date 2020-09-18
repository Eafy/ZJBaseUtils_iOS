//
//  NSFileManager+JMExt.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/11.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSFileManager+JMExt.h"

@implementation NSFileManager (JMExt)

#pragma mark - StaticAPI

+ (NSString *)jm_documentsPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)jm_documentsPath:(NSString *)fileName isCreate:(BOOL)isCreate
{
    NSString *path = [self jm_documentsPath];
    path = [path stringByAppendingPathComponent:fileName];
    if (isCreate && ![NSFileManager jm_isExist:path]) {
        if ([NSFileManager jm_create:path data:nil]) {
            return path;
        } else {
            return @"";
        }
    }
    return path;
}

+ (NSString *)jm_cachesPath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)jm_cachesPath:(NSString *)fileName isCreate:(BOOL)isCreate
{
    NSString *path = [self jm_cachesPath];
    path = [path stringByAppendingPathComponent:fileName];
    if (isCreate && ![NSFileManager jm_isExist:path]) {
        if ([NSFileManager jm_create:path data:nil]) {
            return path;
        } else {
            return @"";
        }
    }
    return path;
}

+ (BOOL)jm_isExist:(NSString *)filePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)jm_isExistDirectory:(NSString *)path
{
    BOOL isDirectory = NO;
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return result && isDirectory;
}

+ (NSArray<NSString *> *)jm_fileLists:(NSString *)path
{
    NSArray<NSString *> *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    return array;
}

+ (BOOL)jm_create:(NSString *)path data:(NSData *)data
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return [fileManager createFileAtPath:path contents:data attributes:nil];
    }

    return NO;
}

+ (BOOL)jm_createDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return [fileManager createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
    } else {
        return [self jm_isExistDirectory:path];
    }
}

+ (BOOL)jm_delete:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return [fileManager removeItemAtPath:path error:NULL];
    }
    
    return NO;
}

+ (BOOL)jm_move:(NSString *)path toPath:(NSString *)toPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return [fileManager moveItemAtPath:path toPath:toPath error:nil];
    }

    return NO;
}

+ (BOOL)jm_write:(NSString *)path data:(NSData *)data isAppend:(Boolean)isAppend
{
    if (!path || !data) return NO;
    if (!isAppend) {
        [self jm_delete:path];
    }
    if (![self jm_create:path data:nil]) return NO;

    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    if (fileHandle) {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
        return YES;
    }

    return NO;
}

+ (BOOL)jm_copy:(NSString *)path toPath:(NSString *)toPath
{
    if (!toPath) return NO;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return [fileManager copyItemAtPath:path toPath:toPath error:nil];
    }

    return NO;
}

+ (NSString *)jm_find:(NSString *)path fileName:(NSString *)fileName isTraversing:(BOOL)isTraversing
{
    NSMutableArray *traversingDic = [NSMutableArray array];
    NSArray<NSString *> *array = [self jm_fileLists:path];
    for (NSString *subName in array) {
        if ([subName isEqualToString:fileName]) {
            return path;
        } else {
            NSString *subPathDic = [path stringByAppendingPathComponent:subName];
            if (isTraversing && [self jm_isExistDirectory:subPathDic]) {
                [traversingDic addObject:subPathDic];
            }
        }
    }
    
    //算法2，逐层遍历；
    for (NSString *subName in traversingDic) {
        NSString *realPath = [self jm_find:subName fileName:fileName isTraversing:isTraversing];
        if (realPath) {
            return realPath;
        }
    }
    
    return nil;
}

+ (NSData *)jm_fileData:(NSString *)filePath
{
    return [NSData dataWithContentsOfFile:filePath];
}

+ (unsigned long long)jm_size:(NSString *)path
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
                    size += [self jm_size:filePath];
                }else
                    size += [[fm attributesOfItemAtPath:filePath error:nil] fileSize];
            }
        } else {
            size = [[fm attributesOfItemAtPath:path error:nil] fileSize];
        }
    }
    
    return size;
}

+ (NSUInteger)jm_totalDiskSizeOfSystem
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
     NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
     NSNumber *number = attributes[NSFileSystemSize];
     return [number unsignedIntegerValue];
}

+ (NSUInteger)jm_freeDiskSizeOfSystem
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = attributes[NSFileSystemFreeSize];
    return [number unsignedIntegerValue];
}

+ (NSUInteger)jm_filesSize:(NSArray *)paths
{
    NSUInteger size = 0;
    
    for (NSString *path in paths) {
        size += [[self class] jm_size:path];
    }
    
    return size;
}

+ (void)clearFiles:filepPath completion:(void (^)(BOOL finished))completion
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

@end
