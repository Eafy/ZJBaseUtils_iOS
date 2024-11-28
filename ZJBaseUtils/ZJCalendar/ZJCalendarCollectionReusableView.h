//
//  ZJCalendarCollectionReusableView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJCalendarCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;
/// 当前Section
@property (nonatomic, assign) NSInteger indexSection;

@end

NS_ASSUME_NONNULL_END
