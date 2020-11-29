//
//  ZJSettingItemGroup.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingItemGroup.h"
#import "ZJSettingItem.h"

@implementation ZJSettingItemGroup

- (NSMutableArray<ZJSettingItem *> *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    
    return _items;
}

- (void)addObject:(id)anObject
{
    if (anObject && [anObject isKindOfClass:[ZJSettingItem class]]) {
        [self.items addObject:anObject];
    }
}

@end
