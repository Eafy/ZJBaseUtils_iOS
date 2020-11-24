//
//  ZJPickerItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJPickerItem : NSObject

/// 显示内容数组
@property (nonatomic,strong) NSArray<NSString *> *titleArray;

/// 默认选中的索引
@property (nonatomic,assign) NSUInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
