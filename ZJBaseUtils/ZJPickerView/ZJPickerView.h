//
//  ZJPickerView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJPickerItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJPickerView : UIPickerView

@property (nonatomic,strong) NSArray<ZJPickerItem *> *itemsArray;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) UILabel *titleLB;
@property (nonatomic,strong) UIButton *okBtn;
@property (nonatomic,strong) UIButton *cancelBtn;

@end

NS_ASSUME_NONNULL_END
