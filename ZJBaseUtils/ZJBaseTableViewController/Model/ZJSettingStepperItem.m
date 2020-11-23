//
//  ZJSettingStepperItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingStepperItem.h"
#import "UIView+ZJFrame.h"
#import "ZJSettingTableViewCellExt.h"
#import "ZJBaseUtils.h"

@interface ZJSettingStepperItem ()

@property (nonatomic,strong) UIView *stepperView;

@end

@implementation ZJSettingStepperItem

- (void)defaultData {
    self.stepMin = 0;
    self.stepMax = 100;
    self.stepCount = 0;
}

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeStepper;
}

- (UIView *)accessoryView
{
    if (super.accessoryView.tag != self.type) {
        super.accessoryView = self.stepperView;
        super.accessoryView.tag = self.type;
    }
    
    return super.accessoryView;
}

- (UIView *)stepperView
{
    if (!_stepperView) {
        _stepperView = [[UIView alloc] init];
        _stepperView.backgroundColor = [UIColor clearColor];
        [_stepperView addSubview:self.increaseBtn];
        [_stepperView addSubview:self.stepperTF];
        [_stepperView addSubview:self.decreaseBtn];
    }
    return _stepperView;
}

- (UIButton *)increaseBtn
{
    if (!_increaseBtn) {
        _increaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        _increaseBtn.backgroundColor = [UIColor clearColor];
        [_increaseBtn setImage:[ZJBaseUtils imageNamed:@"icon_stepper_increase_normal"] forState:UIControlStateNormal];
        [_increaseBtn setImage:[ZJBaseUtils imageNamed:@"icon_stepper_increase_selected"] forState:UIControlStateSelected];
        [_increaseBtn addTarget:self action:@selector(handleStepperCount:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _increaseBtn;
}

- (UITextField *)stepperTF
{
    if (!_stepperTF) {
        _stepperTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        _stepperTF.backgroundColor = [UIColor colorWithRed:245/255.0 green:248/255.0 blue:252/255.0 alpha:1.0];
        
        _stepperTF.text = @"0";
        _stepperTF.font = [UIFont systemFontOfSize:14];
        _stepperTF.textColor = [UIColor colorWithRed:24/255.0 green:30/255.0 blue:40/255.0 alpha:1.0];
        _stepperTF.textAlignment = NSTextAlignmentCenter;
        _stepperTF.enabled = NO;
    }
    
    return _stepperTF;
}

- (UIButton *)decreaseBtn
{
    if (!_decreaseBtn) {
        _decreaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        _decreaseBtn.backgroundColor = [UIColor clearColor];
        [_decreaseBtn setImage:[ZJBaseUtils imageNamed:@"icon_stepper_decrease_normal"] forState:UIControlStateNormal];
        [_decreaseBtn setImage:[ZJBaseUtils imageNamed:@"icon_stepper_decrease_selected"] forState:UIControlStateSelected];
        [_decreaseBtn addTarget:self action:@selector(handleStepperCount:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _decreaseBtn;
}

- (void)handleStepperCount:(UIButton *)btn
{
    if (btn == self.increaseBtn) {
        self.stepCount += 1;
    } else if (btn == self.decreaseBtn) {
        self.stepCount -= 1;
    }
}

- (void)setStepCount:(NSInteger)stepCount
{
    _stepCount = stepCount;
    if (_stepCount > self.stepMax) {
        _stepCount = self.stepMax;
    } else if (_stepCount < self.stepMin) {
        _stepCount = self.stepMin;
    }
    
    self.increaseBtn.selected = self.stepCount == self.stepMax;
    self.decreaseBtn.selected = self.stepCount == self.stepMin;
    self.stepperTF.text = [NSString stringWithFormat:@"%ld", (long)self.stepCount];
    if (_stepperHandle) {
        self.stepperHandle(self.stepCount);
    }
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    [cell.textLabel sizeToFit];
    self.stepperView.zj_height = cell.zj_height/3*2;
    if (self.stepperView.zj_width == 0) {
        CGFloat width = self.increaseBtn.zj_width + self.stepperTF.zj_width + self.decreaseBtn.zj_width;
        width += 16;
        self.stepperView.zj_width = width;
        
        self.increaseBtn.zj_centerY = self.stepperView.zj_height/2.0;
        self.stepperTF.zj_centerY = self.increaseBtn.zj_centerY;
        self.decreaseBtn.zj_centerY = self.increaseBtn.zj_centerY;
        
        self.increaseBtn.zj_right = self.stepperView.zj_right;
        self.stepperTF.zj_right = self.increaseBtn.zj_left - 8;
        self.decreaseBtn.zj_right = self.stepperTF.zj_left - 8;
    }
}

@end
