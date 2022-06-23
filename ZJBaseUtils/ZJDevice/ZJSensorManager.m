//
//  ZJSensorManager.m
//  ZJBaseUtils
//
//  Created by eafy on 2022/6/23.
//  Copyright © 2022 ZJ. All rights reserved.
//

#import "ZJSensorManager.h"

@interface ZJSensorManager ()

@property (nonatomic,assign) BOOL isProximityMonitoring;
@property (nonatomic,copy) void (^ proximityMonitorCB)(BOOL enable);

@end

@implementation ZJSensorManager
singleton_m();

- (void)initData {
}

- (void)startProximity:(void (^ __nullable)(BOOL enable))handler {
    if (self.isProximityMonitoring) return;
    self.isProximityMonitoring = YES;
    self.proximityMonitorCB = handler;
    
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didProximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

- (void)stopProximity {
    if (!self.isProximityMonitoring) return;
    self.isProximityMonitoring = NO;
    self.proximityMonitorCB = nil;
    
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
}

- (void)didProximityStateDidChange:(NSNotification *)noti {
    if (self.proximityMonitorCB) {
        self.proximityMonitorCB([UIDevice currentDevice].proximityState);
    }
}

@end
