//
//  ZJSettingStepperItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingStepperItem : ZJSettingItem

/// 递增按钮
@property (nonatomic,strong) UIButton *increaseBtn;

/// 计步器显示（默认不可编辑）
@property (nonatomic,strong) UITextField *stepperTF;

/// 递减按钮
@property (nonatomic,strong) UIButton *decreaseBtn;

/// 计步数（0~100），默认0
@property (nonatomic,assign) NSInteger stepCount;

/// 计步最大数，默认100
@property (nonatomic,assign) NSInteger stepMax;

/// 计步最小数，默认0
@property (nonatomic,assign) NSInteger stepMin;

/// 计步回调
@property (nonatomic,copy) void(^ _Nullable stepperHandle)(NSInteger stepCount);

@end

NS_ASSUME_NONNULL_END

#pragma mark - 使用方式

//ZJSettingStepperItem *item2 = [[ZJSettingStepperItem alloc] initWithIcon:nil title:@"评分".localized destClass:nil];
//item2.stepMax = 10;
//[item2.increaseBtn setImage:[UIImage imageNamed:@"icon_stepper_increase_normal"] forState:UIControlStateNormal];    //不设置使用默认图片
//[item2.increaseBtn setImage:[UIImage imageNamed:@"icon_stepper_increase_selected"] forState:UIControlStateSelected];    //不设置使用默认图片
//[item2.decreaseBtn setImage:[UIImage imageNamed:@"icon_stepper_decrease_normal"] forState:UIControlStateNormal];    //不设置使用默认图片
//[item2.decreaseBtn setImage:[UIImage imageNamed:@"icon_stepper_decrease_selected"] forState:UIControlStateSelected];    //不设置使用默认图片
//item2.stepperHandle = ^(NSInteger stepCount) {
//    NSLog(@"----->%ld", (long)stepCount);
//};
//[itemArray addObject:item2];
