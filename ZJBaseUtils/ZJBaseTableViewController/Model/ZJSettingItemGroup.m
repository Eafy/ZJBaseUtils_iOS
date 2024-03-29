//
//  ZJSettingItemGroup.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingItemGroup.h>
#import <ZJBaseUtils/ZJSettingItem.h>

@implementation ZJSettingItemGroup

- (NSMutableArray<ZJSettingItem *> *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    
    return _items;
}

- (void)addObject:(id)anObject {
    if (anObject && [anObject isKindOfClass:[ZJSettingItem class]]) {
        [self.items addObject:anObject];
    }
}

- (void)removeObject:(id)anObject {
    if (anObject) {
        [self.items removeObject:anObject];
    }
}

- (void)removeAllObjects {
    [self.items removeAllObjects];
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < self.items.count) {
        return [self.items objectAtIndex:index];
    }
    return nil;
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < self.items.count) {
        [self.items replaceObjectAtIndex:index withObject:anObject];
    }
}

@end
