//
//  NSFileManager+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (ZJExt)

#pragma mark - StaticAPI

/// 获取沙盒文档文件夹路径
+ (NSString *)zj_documentsPath;

/// 获取沙盒文档文件夹下文件/文件夹的路径
/// @param fileName 文件/文件名称
/// @param isCreate 检测到不存在时是否创建，YES：创建
+ (NSString *)zj_documentsPath:(NSString *)fileName isCreate:(BOOL)isCreate;

/// 获取沙盒缓存文件夹路径
+ (NSString *)zj_cachesPath;

/// 获取沙盒缓存文件夹下文件/文件夹的路径
/// @param fileName 文件/文件夹名称
/// @param isCreate 检测到不存在时是否创建，YES：创建
+ (NSString *)zj_cachesPath:(NSString *)fileName isCreate:(BOOL)isCreate;

/// 检查文件是否存在
/// @param path 文件路径
+ (BOOL)zj_isExist:(NSString *)path;

///  检查文件目录是否存在
/// @param path 目录
+ (BOOL)zj_isExistDirectory:(NSString *)path;

/// 获取路径下所有的文件列表
/// @param path 路径
+ (NSArray<NSString *> *)zj_fileLists:(NSString *)path;

/// 新建文件
/// @param path 文件路径
/// @param data 需要写入数据，没有传nil
+ (BOOL)zj_create:(NSString *)path data:(nullable NSData *)data;

/// 新建文件夹
/// @param path 文件夹路径
+ (BOOL)zj_createDirectory:(NSString *)path;

/// 删除文件
/// @param path 路径
+ (BOOL)zj_delete:(NSString *)path;

/// 移动文件
/// @param path 原文件路径
/// @param toPath 新文件路径
+ (BOOL)zj_move:(NSString *)path toPath:(NSString *)toPath;

/// 往文件中写入数据
/// @param path 文件路径
/// @param data 待写入数据
/// @param isAppend 是否是追加
+ (BOOL)zj_write:(NSString *)path data:(NSData *)data isAppend:(Boolean)isAppend;

/// 拷贝文件
/// @param path 原文件路径
/// @param toPath 新文件路径
+ (BOOL)zj_copy:(NSString *)path toPath:(NSString *)toPath;

/// 查找文件/文件夹
/// @param path （查找范围）文件夹路径
/// @param fileName 文件名称
/// @param isTraversing 是否遍历，YES:依次遍历文件夹下所以文件与文件夹
+ (NSString *)zj_find:(NSString *)path fileName:(NSString *)fileName isTraversing:(BOOL)isTraversing;

/// 根据文件路径获取数据
/// @param filePath 文件路径
+ (NSData *)zj_fileData:(NSString *)filePath;

/** 获取一个文件夹以及文件夹下所有文件的大小，返回值得单位是byte */
+ (NSUInteger)zj_size: (NSString *)path;

/** 获取手机总容量(GB)（除去iOS系统所占容量） */
+ (NSUInteger)zj_totalDiskSizeOfSystem;

/** 获取可用容量(GB) */
+ (NSUInteger)zj_freeDiskSizeOfSystem;

/** 获取所给路径下文件或文件夹的总大小(Kb)
 */
+ (NSUInteger)zj_filesSize:(NSArray *)paths;

/// 清除缓存
/// @param clearcache 清除结果回调
/// @param filepPath 需要清楚的文件/文件夹
+ (void)clearFiles:filepPath completion:(void (^)(BOOL finished))completion;


@end

NS_ASSUME_NONNULL_END
