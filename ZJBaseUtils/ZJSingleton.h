//  ZJSingleton.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//
//单例模式宏,头文件宏：singleton_h(name)，实现文件宏：singleton_m(name)。
//比如单列类名为：shareAudioTool,头文件加入singleton_h(AudioTool)，实现文件：singleton_m(AudioTool);
//需添加初始化数据接口：-initData方法，如下
/*
 - (void)initData {
 //初始化数据
 }
 */

#ifndef ZJSingleton_h
#define ZJSingleton_h
#ifndef singleton_h
#import <objc/message.h>

// ## : 连接字符串和参数
#define singleton_h(name) + (instancetype _Nullable)shared##name;

#if __has_feature(objc_arc) // ARC

#define singleton_m(name) \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}\
- (id)copy \
{ \
return _instance; \
} \
- (id)mutableCopy \
{ \
return _instance; \
} \
- (instancetype)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super init]; \
SEL initDataSel = NSSelectorFromString(@"initData"); \
if ([self respondsToSelector:initDataSel]) { \
    ((void (*) (id, SEL)) objc_msgSend)(self, initDataSel); \
} \
}); \
return _instance; \
}

#else // 非ARC

#define singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (oneway void)release \
{ \
\
} \
- (id)autorelease \
{ \
return _instance; \
} \
- (id)retain \
{ \
return _instance; \
} \
- (NSUInteger)retainCount \
{ \
return 1; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}

#endif
#endif
#endif /* ZJSingleton_h */
