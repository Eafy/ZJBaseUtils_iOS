//
//  CLLocation+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2021/4/21.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import "CLLocation+ZJExt.h"

@implementation CLLocation (ZJExt)

+ (CLLocationCoordinate2D)longLatOffset:(CLLocationCoordinate2D)location radian:(CGFloat)radian dst:(CGFloat)dst
{
    double arc = 6371.393 * 1000;
    CGFloat lon = dst * sin(radian) / (arc * cos(location.latitude) * 2 * M_PI / 360) + location.longitude;
    CGFloat lat = dst * cos(radian) / (arc * 2 * M_PI / 360) + location.latitude;

    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(lat, lon);
    return loc;
}

@end
