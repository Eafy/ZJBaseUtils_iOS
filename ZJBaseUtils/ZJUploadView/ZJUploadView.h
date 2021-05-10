//
//  ZJUploadView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/31.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJUploadViewStyle) {
    ZJUploadViewStyleNormal,
    ZJUploadViewStyleDisable,
    ZJUploadViewStyleUploading,
    ZJUploadViewStyleUploadSuccess,
    ZJUploadViewStyleUploadFailed,  //等同于Normal
};

@interface ZJUploadViewStyleState: NSObject

@property (nonatomic,assign) ZJUploadViewStyle style;

@property (nonatomic,strong) NSString *title;
/// 标题字体，默认常规12
@property (nonatomic,strong) UIFont *titleFont;
/// 普通字体颜色
@property (nonatomic,strong) UIColor *titleColor;
/// 图标名称
@property (nonatomic,copy) NSString *imgName;
/// 图标对象（优先imgName）
@property (nonatomic,strong) UIImage *image;

@end


@interface ZJUploadView : UIView

/// 状态样式
@property (nonatomic,assign) ZJUploadViewStyle style;
/// 右上角关闭按钮图标
@property (nonatomic,copy) NSString *closeImgName;

/// 上传成功显示的图片
@property (nonatomic,strong) UIImage *successImage;

/// 设置样式数据，默认已有
/// @param styleState 样式数据
- (void)setStyleState:(ZJUploadViewStyleState *)styleState;

@end

NS_ASSUME_NONNULL_END
