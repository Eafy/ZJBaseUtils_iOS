//
//  ZJSegmentedControl.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJSegmentedControlStyle) {
    ZJSegmentedControlStylePlain = 0,      //扁平模式
    ZJSegmentedControlStyleGroup,          //
};

@protocol ZJSegmentedControlDelegate;

@interface ZJSegmentedControl : UIView

- (instancetype)initWithItems:(nullable NSArray *)items;

- (instancetype)initWithStyle:(ZJSegmentedControlStyle)style titleItems:(NSArray *)items;

- (instancetype)initWithTitleItems:(NSArray *)items norImgItems:(nullable NSArray *)norImgItems selImgItems:(nullable NSArray *)selImgItems;

- (instancetype)initWithStyle:(ZJSegmentedControlStyle)style titleItems:(NSArray *)items norImgItems:(nullable NSArray *)norImgItems selImgItems:(nullable NSArray *)selImgItems;


/// 代理
@property (nonatomic,weak) id<ZJSegmentedControlDelegate> delegate;
/// 样式
@property (readonly) ZJSegmentedControlStyle style;
/// 可见个数，默认显示所有，StylePlain才生效
@property (nonatomic,assign) NSUInteger visibleCount;
/// 是否显示右边遮罩，visibleCount > 0，默认设置YES
@property (nonatomic,assign) BOOL isShowRightMask;
/// 当前选择
@property (nonatomic,assign) NSUInteger selectedIndex;

/// 底部选择视图
@property (nonatomic,strong) UIView *selectLineView;

/// 固定间距，默认0，即自动计算
@property (nonatomic,assign) CGFloat fixedSpace;
/// 固定宽度，默认0，即自动计算
@property (nonatomic,assign) CGFloat fixedWidth;
/// 左右空余空间，默认0，即自动计算
@property (nonatomic,assign) CGFloat leftRightMargin;

/// 是否隐藏选择线，默认NO
@property (nonatomic,assign) BOOL hideSelectLine;
/// 选择线底部默认间距，默认4
@property (nonatomic,assign) CGFloat selectLineBottomMargin;

/// 扁平默认0，Group默认；
@property (nonatomic,assign) CGFloat selectCornerRadius;

- (void)setSelectedColor:(nullable UIColor *)color bgColor:(nullable UIColor *)bgColor font:(nullable UIFont *)font;
- (void)setNormalColor:(nonnull UIColor *)color bgColor:(nonnull UIColor *)bgColor font:(nonnull UIFont *)font;

@end

@protocol ZJSegmentedControlDelegate<NSObject>
@required

- (void)segmentedControl:(ZJSegmentedControl *)segmentedControl didSelectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
