//
//  ZJSettingItemGroup.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJSettingItem;

@interface ZJSettingItemGroup : NSMutableArray

/// 标识（用户自定义标签Tag）
@property (nonatomic,assign) NSInteger tag;
/// 头部标题
@property (nonatomic,copy) NSString *headerTitle;
/// 底部标题
@property (nonatomic,copy) NSString *footerTitle;
/// 当前分组中所有行的数据（保存的是SettingItem模型）
@property (nonatomic,strong) NSArray<ZJSettingItem *> *items;

@end

NS_ASSUME_NONNULL_END
