//
//  ZJSearchBar.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/30.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSearchBar : UISearchBar

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder buttonTitle:(NSString *)buttonTitle;

@end

NS_ASSUME_NONNULL_END
