//
//  NSArray+JMExt.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/11.
//  Copyright © 2020 lzj<lizhijian_21@163.com><lizhijian_21@163.com>. All rights reserved.
//

#import "NSArray+JMExt.h"

@implementation NSArray (JMExt)

- (NSString *)jm_toJsonString
{
    if (!self) return nil;

    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (error != nil)
        return nil;
    return jsonString;
}

- (NSArray *)jm_intersecWithArray:(NSArray *)array
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

- (NSArray *)jm_exceptWithArray:(NSArray *)array
{
    if (!self) return array;
    if (!array) return self;
    
    NSArray *intersecArray = [self jm_intersecWithArray:array];
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:self];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:array];
    [array1 removeObjectsInArray:intersecArray];
    [array2 removeObjectsInArray:intersecArray];
    
    NSMutableArray *exceptArray = [NSMutableArray arrayWithArray:array1];
    [exceptArray addObjectsFromArray:array2];
    
    return exceptArray;
}

- (NSArray *)jm_unionWithArray:(NSArray *)array
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

- (NSArray *)jm_reverseArray
{
    NSMutableArray *reverseArray = [NSMutableArray array];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [reverseArray addObject:element];
    }
    return reverseArray;
}


@end
