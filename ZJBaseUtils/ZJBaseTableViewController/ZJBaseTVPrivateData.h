//
//  ZJBaseTVPrivateData.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJBaseTVConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTVPrivateData : NSObject

/// 表单全局配置参数
@property (nonatomic,strong) ZJBaseTVConfig *config;
/// 需要传递的数据（一般是对象类）
@property (nonatomic,strong) id _Nullable dataObject;
/// 需要传递的数据（一般是数据类）
@property (nonatomic,strong) id _Nullable data;
/// 需要传递的数据（一般是指针数据）
@property (nonatomic,assign) char * _Nullable pData;

@end

NS_ASSUME_NONNULL_END
