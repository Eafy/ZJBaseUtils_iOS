//
//  ViewController.m
//  ZJBaseUtilsDemo
//
//  Created by eafy on 2021/2/24.
//

#import "ViewController.h"
#import <ZJBaseUtils/ZJBaseUtils.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [ZJPhoto deleteLatestPhoto:^(BOOL success) {
//        NSLog(@"------------->%d", success);
//    }];
    
    [ZJPhoto deleteLatestVideo:^(BOOL success) {
        NSLog(@"------------->%d", success);
     }];
}


@end
