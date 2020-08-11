//
//  NSArray+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 Eafy<lizhijian_21@163.com>. All rights reserved.
//

#import "NSArray+ZJExt.h"

@implementation NSArray (ZJExt)

- (NSArray *)zj_intersecWithArray:(NSArray *)array
{
    if (!self || !array) return nil;
    
    NSMutableArray *intersecArray = [NSMutableArray array];
    for (id obj in self) {  //遍历
        if (![array containsObject:obj]) {
            continue;
        }
        [intersecArray addObject:obj];
    }
    
    return intersecArray;
}

- (NSArray *)zj_exceptWithArray:(NSArray *)array
{
    if (!self) return array;
    if (!array) return self;
    
    NSArray *intersecArray = [self zj_intersecWithArray:array];
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:self];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:array];
    [array1 removeObjectsInArray:intersecArray];
    [array2 removeObjectsInArray:intersecArray];
    
    NSMutableArray *exceptArray = [NSMutableArray arrayWithArray:array1];
    [exceptArray addObjectsFromArray:array2];
    
    return exceptArray;
}

- (NSArray *)zj_unionWithArray:(NSArray *)array
{
    if (!self) return array;
    if (!array) return self;
    
    NSMutableArray *unionArray = [NSMutableArray arrayWithArray:self];
    for (id obj in array) {
        if (![self containsObject:obj]) {
            [unionArray addObject:obj];
        }
    }
    
    return unionArray;
}

- (NSArray *)zj_reverseArray
{
    NSMutableArray *reverseArray = [NSMutableArray array];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [reverseArray addObject:element];
    }
    return reverseArray;
}


@end
