//
//  ZJSensorManager.m
//  ZJBaseUtils
//
//  Created by eafy on 2022/6/23.
//  Copyright © 2022 ZJ. All rights reserved.
//

#import "ZJSensorManager.h"
#import <ZJBaseUtils/ZJUtilsDef.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
//#import <CallKit/CXCallObserver.h>
//#import <CallKit/CXCall.h>

@interface ZJSensorManager ()

@property (nonatomic,assign) BOOL isProximityMonitoring;
@property (nonatomic,copy) void (^ proximityMonitorCB)(BOOL enable);

@property (nonatomic, strong) CTCallCenter *callCenter;
//@property (nonatomic, strong) CXCallObserver *callObserver;     //在国内无法过审
@property (nonatomic,copy) void (^ callMonitorCB)(BOOL enable);

@end

@implementation ZJSensorManager
singleton_m();

- (void)initData {
}

- (void)startProximity:(void (^ __nullable)(BOOL enable))handler {
    self.proximityMonitorCB = handler;
    if (self.isProximityMonitoring) return;
    self.isProximityMonitoring = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIDevice currentDevice].proximityMonitoringEnabled = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didProximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
    });
}

- (void)stopProximity {
    self.proximityMonitorCB = nil;
    if (!self.isProximityMonitoring) return;
    self.isProximityMonitoring = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIDevice currentDevice].proximityMonitoringEnabled = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
    });
}

- (void)didProximityStateDidChange:(NSNotification *)noti {
    if (self.proximityMonitorCB) {
        self.proximityMonitorCB([UIDevice currentDevice].proximityState);
    }
}

#pragma mark -

- (void)startCallMonitor:(void (^ __nullable)(NSInteger type))handler {
    _callMonitorCB = handler;
    if (_callCenter) return;
//    if (_callObserver) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (@available(iOS 10.0, *)) {
//            self.callObserver = [[CXCallObserver alloc] init];
//            [self.callObserver setDelegate:self queue:dispatch_get_main_queue()];
//        } else {
            self.callCenter = [[CTCallCenter alloc] init];
            @weakify(self);
            [self.callCenter setCallEventHandler:^(CTCall * _Nonnull call) {
                @strongify(self);
                if ([call.callState isEqual:CTCallStateIncoming] || [call.callState isEqual:CTCallStateDialing]) {
                    self.callMonitorCB(1);
                } else if ([call.callState isEqual:CTCallStateConnected]) {
                    self.callMonitorCB(2);
                } else {
                    self.callMonitorCB(0);
                }
            }];
//        }
    });
}

- (void)stopCallMonitor {
    _callMonitorCB = nil;
    _callCenter = nil;
    //    _callObserver = nil;
}

//- (void)callObserver:(CXCallObserver *)callObserver callChanged:(CXCall *)call  API_AVAILABLE(ios(10.0)) {
//    if (!call.outgoing && !call.onHold && !call.hasConnected && !call.hasEnded) {
//        NSLog(@"来电");
//    } else if (!call.outgoing && !call.onHold && !call.hasConnected && call.hasEnded) {
//        NSLog(@"来电-挂掉(未接通)");
//    } else if (!call.outgoing && !call.onHold && call.hasConnected && !call.hasEnded) {
//        NSLog(@"来电-接通");
//    } else if (!call.outgoing && !call.onHold && call.hasConnected && call.hasEnded) {
//        NSLog(@"来电-接通-挂掉");
//    } else if (call.outgoing && !call.onHold && !call.hasConnected && !call.hasEnded) {
//        NSLog(@"拨打");
//    } else if (call.outgoing && !call.onHold && !call.hasConnected && call.hasEnded) {
//        NSLog(@"拨打-挂掉(未接通)");
//    } else if (call.outgoing && !call.onHold && call.hasConnected && !call.hasEnded) {
//        NSLog(@"拨打-接通");
//    } else if (call.outgoing && !call.onHold && call.hasConnected && call.hasEnded) {
//        NSLog(@"拨打-接通-挂掉");
//    }
//    NSLog(@"outgoing(拨打):%d  onHold(待接通):%d   hasConnected(接通):%d   hasEnded(挂断):%d",call.outgoing,call.onHold,call.hasConnected,call.hasEnded);
//}

@end

