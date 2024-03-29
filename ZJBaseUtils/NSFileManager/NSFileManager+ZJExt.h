//
//  NSFileManager+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (ZJExt)

#pragma mark - StaticAPI

/// 获取沙盒文档文件夹路径
+ (NSString *)zj_documentsPath;

/// 获取文档下文件/文件夹下文件夹的路径
/// @param fileName 文件/文件夹名称/路径
/// @param isDirectory 是否是文件夹
/// @param isCreate 检测到不存在时是否创建，YES：创建
+ (NSString *)zj_documentsPath:(NSString *)fileName isDirectory:(BOOL)isDirectory isCreate:(BOOL)isCreate;

/// 获取沙盒缓存文件夹路径
+ (NSString *)zj_cachesPath;

/// 获取沙盒下文件/文件夹下文件夹的路径
/// @param filePath 文件/文件夹名称/路径
/// @param isDirectory 是否是文件夹
/// @param isCreate 检测到不存在时是否创建，YES：创建
+ (NSString *)zj_cachesPath:(NSString *)filePath isDirectory:(BOOL)isDirectory isCreate:(BOOL)isCreate;

/// 检查文件是否存在
/// @param path 文件路径
+ (BOOL)zj_isExist:(NSString *)path;

///  检查文件目录是否存在
/// @param path 目录
+ (BOOL)zj_isExistDirectory:(NSString *)path;

/// 获取路径下所有的文件列表
/// @param path 路径
+ (NSArray<NSString *> *)zj_fileLists:(NSString *)path;

#pragma mark - 

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

/// 移动文件夹文件到另1个文件夹(主要用来做文件批量新增)
/// @param dir 当前文件夹
/// @param toDir 目标文件夹
/// @param isCover 是否覆盖文件
/// @param excludeFiles 需要排除的文件
+ (void)zj_moveDir:(NSString *)dir toDir:(NSString *)toDir isCover:(BOOL)isCover excludeFiles:(NSArray<NSString *> *)excludeFiles;

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

#pragma mark -

/// 获取一个文件夹以及文件夹下所有文件的大小(字节)
/// @param path 文件/文件夹路径
+ (NSUInteger)zj_size:(NSString *)path;

/// 获取手机总容量(字节)（除去iOS系统所占容量）
+ (NSUInteger)zj_totalDiskSizeOfSystem;

/// 获取可用容量(字节)
+ (NSUInteger)zj_freeDiskSizeOfSystem;

/// 获取所给路径下文件或文件夹的总大小(字节)
/// @param paths 文件列表
+ (NSUInteger)zj_filesSize:(NSArray *)paths;

/// 清除缓存
/// @param completion 清除结果回调
/// @param filepPaths 需要清楚的文件/文件夹列表
+ (void)zj_clearFiles:(NSArray *)filepPaths completion:(void (^)(BOOL finished))completion;

#pragma mark - 

/// 获取文件的mime类型
/// @param filepath 文件路径
+ (NSString *)zj_mimeType:(NSString *)filepath;

/// 获取文件的名称（包含后缀）
/// @param filepath 文件路径
+ (NSString *)zj_fileName:(NSString *)filepath;

/// 获取文件上级目录
/// @param filepath 文件路径
+ (NSString *)zj_filePrePath:(NSString *)filepath;

@end

NS_ASSUME_NONNULL_END
