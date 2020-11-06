//
//  ZJError.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJError.h"

@implementation ZJError

+ (ZJError *)initWithCode:(NSInteger)errCode msg:(NSString *)errMsg
{
    ZJError *error = [[ZJError alloc] init];
    error.errCode = errCode;
    error.errMsg = errMsg;
    return error;
}


@end
