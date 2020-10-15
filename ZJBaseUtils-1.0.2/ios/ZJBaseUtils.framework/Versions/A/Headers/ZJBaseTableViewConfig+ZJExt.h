//
//  ZJBaseTableViewConfig+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJBaseTableViewConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTableViewConfig (ZJExt)

/// 缓存Cell行高
@property (nonatomic,assign) CGFloat rowCacheHeight;
/// 缓存footer的高度
@property (nonatomic,assign) CGFloat footerCacheHeight;

@end

NS_ASSUME_NONNULL_END
