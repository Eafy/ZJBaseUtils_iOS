//
//  ZJUploadView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/31.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJUploadView.h>
#import <ZJBaseUtils/UIView+ZJExt.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/NSString+ZJIMGExt.h>
#import <ZJBaseUtils/UIButton+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/UIImage+ZJExt.h>
#import <ZJBaseUtils/ZJLocalization.h>
#import <ZJBaseUtils/ZJBundleRes.h>

@implementation ZJUploadViewStyleState
@end

@interface ZJUploadView()

@property (nonatomic, strong) UIButton *showImgBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *uploadingView;
@property (nonatomic, strong) UIImageView *successImgView;


@property (nonatomic, strong) UIView *circleView;

@property (nonatomic, strong) UIView *uploadSuccessView;

@property (nonatomic, strong) UIView *uploadFailedView;

@property (nonatomic, assign) CGFloat rightTopBtnWidth;

@property (nonatomic, strong) CAShapeLayer *borderShapeLayer;

@property (nonatomic, strong) NSMutableDictionary *styleStateDic;

@end

@implementation ZJUploadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.showImgBtn];
        [self defaultData];
        self.style = ZJUploadViewStyleNormal;
    }
    return self;
}

- (void)defaultData {
    ZJUploadViewStyleState *state = [[ZJUploadViewStyleState alloc] init];
    state.style = ZJUploadViewStyleNormal;
    state.title = @"上传照片".localized;
    state.image = [ZJBundleRes imageNamed:@"icon_uxkit_upload_normal"];
    state.titleColor = ZJColorFromRGB(0x8690A9);
    [self setStyleState:state];
    
    state = [[ZJUploadViewStyleState alloc] init];
    state.style = ZJUploadViewStyleDisable;
    state.image = [ZJBundleRes imageNamed:@"icon_uxkit_upload_disable"];
    state.titleColor = ZJColorFromRGB(0xBCC4D4);
    [self setStyleState:state];
    
    state = [[ZJUploadViewStyleState alloc] init];
    state.style = ZJUploadViewStyleUploading;
    state.title = @"上传中...".localized;
    state.titleColor = [UIColor whiteColor];
    [self setStyleState:state];
}

- (NSMutableDictionary *)styleStateDic {
    if (!_styleStateDic) {
        _styleStateDic = [NSMutableDictionary dictionary];
    }
    return _styleStateDic;
}

- (UIButton *)showImgBtn {
    if (!_showImgBtn) {
        _showImgBtn = [[UIButton alloc] initWithFrame:self.bounds];
        _showImgBtn.backgroundColor = [UIColor clearColor];
        _showImgBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_showImgBtn zj_layoutWithEdgeInsetsStyle:ZJButtonEdgeInsetsStyleTop imageTitleSpace:8];
    }
    return _showImgBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.zj_width-8, -8, 16, 16)];
        if (_closeImgName) {
            [_closeBtn setImage:[UIImage imageNamed:_closeImgName] forState:UIControlStateNormal];
        } else {
            [_closeBtn setImage:[ZJBundleRes imageNamed:@"icon_textField_clear_normal"] forState:UIControlStateNormal];
        }
        [_closeBtn addTarget:self action:@selector(clickedCloseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)clickedCloseBtnAction {
    self.style = ZJUploadViewStyleNormal;
}

- (UIImageView *)successImgView {
    if (!_successImgView) {
        _successImgView = [[UIImageView alloc] initWithImage:self.successImage];
        _successImgView.frame = self.bounds;
        _successImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_successImgView zj_cornerWithRadius:4];
    }
    return _successImgView;
}

#pragma mark -

- (void)setCloseImgName:(NSString *)closeImgName {
    _closeImgName = closeImgName;
    [self.closeBtn setImage:[UIImage imageNamed:closeImgName] forState:UIControlStateNormal];
}

- (void)setStyleState:(ZJUploadViewStyleState *)styleState {
    if (styleState) {
        [self.styleStateDic setValue:styleState forKey:[NSString stringWithFormat:@"%lu", (unsigned long)styleState.style]];
    }
}

- (void)setStyle:(ZJUploadViewStyle)style {
    _style = style;
    if (_borderShapeLayer) {
        [self.borderShapeLayer removeFromSuperlayer];
        _borderShapeLayer = nil;
    }
    if (_uploadingView) {
        [self.uploadingView removeFromSuperview];
        _uploadingView = nil;
    }
    if (_closeBtn) {
        [self.closeBtn removeFromSuperview];
        _closeBtn = nil;
    }
    if (_successImgView) {
        [self.successImgView removeFromSuperview];
        _successImgView = nil;
    }
    self.backgroundColor = [UIColor clearColor];
    
    if (style == ZJUploadViewStyleUploadFailed) {
        style = ZJUploadViewStyleNormal;
    }
    [self handleStyleState:style];
    
    switch (style) {
        case ZJUploadViewStyleNormal:
            _borderShapeLayer = [self zj_borderWithWidth:0.5 cornerRadii:CGSizeMake(4, 4) rectCorner:UIRectCornerAllCorners length:8 space:4 strokeColor:ZJColorFromRGB(0x8690A8)];
            break;
        case ZJUploadViewStyleDisable:
            _borderShapeLayer = [self zj_borderWithWidth:0.5 cornerRadii:CGSizeMake(4, 4) rectCorner:UIRectCornerAllCorners length:8 space:4 strokeColor:ZJColorFromRGB(0xBCC4D4)];
            break;
        case ZJUploadViewStyleUploading:
        {
            self.backgroundColor = ZJColorFromRgbWithAlpha(0x181E28, 0.7);
            [self zj_cornerWithRadius:4];
            UIImage *img = [self.showImgBtn imageForState:UIControlStateNormal];
            if (img) {
                [self.showImgBtn setImage:[UIImage zj_imageWithColor:[UIColor clearColor] size:img.size] forState:UIControlStateNormal];
            }
            [self addSubview:self.uploadingView];
        }
            break;
        case ZJUploadViewStyleUploadSuccess:
            self.layer.mask = nil;
            [self addSubview:self.successImgView];
            [self addSubview:self.closeBtn];
            break;
        default:
            break;
    }
}

- (void)handleStyleState:(ZJUploadViewStyle)style
{
    ZJUploadViewStyleState *styleState = [self.styleStateDic objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)style]];
    if (styleState) {
        UIControlState controlState = style == ZJUploadViewStyleDisable ? UIControlStateDisabled : UIControlStateNormal;
        self.showImgBtn.enabled = style != ZJUploadViewStyleDisable;
        self.showImgBtn.userInteractionEnabled = style == ZJUploadViewStyleNormal;

        if (styleState.title) {
            [self.showImgBtn setTitle:styleState.title forState:UIControlStateNormal];
        }
        
        if (styleState.imgName) {
            [self.showImgBtn setImage:styleState.imgName.zj_toImage forState:controlState];
        } else if (styleState.image) {
            [self.showImgBtn setImage:styleState.image forState:controlState];
        }
        if (styleState.titleFont) {
            self.showImgBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        }
        if (styleState.titleColor) {
            [self.showImgBtn setTitleColor:styleState.titleColor forState:controlState];
        }
        if (styleState.titleColor) {
            [self.showImgBtn setTitleColor:styleState.titleColor forState:controlState];
        }
    }
}

- (UIView *)uploadingView {
    if (!_uploadingView) {
        _uploadingView = [[UIView alloc] initWithFrame:self.showImgBtn.imageView.frame];
        _uploadingView.backgroundColor = [UIColor clearColor];
        
        CGRect circleRect = CGRectInset(_uploadingView.bounds, 2.0f, 2.0f);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circleRect.size.width/2, circleRect.size.width/2) radius:circleRect.size.width/2 startAngle:M_2_PI endAngle:0 clockwise:YES];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = circleRect;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;    //填充色
        shapeLayer.lineWidth = 1;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.lineCap = kCALineCapRound; //线框类型
        shapeLayer.path = bezierPath.CGPath;
        
        shapeLayer.strokeStart = 0.0;
        shapeLayer.strokeEnd = 0.75;
        [_uploadingView.layer addSublayer:shapeLayer];
        
        CABasicAnimation *animation1 = [[CABasicAnimation alloc] init];
        animation1.keyPath = @"transform.rotation.z";
        animation1.fromValue = @0.0;
        animation1.toValue = @(M_PI * 2);
        animation1.duration = 1;
        animation1.repeatCount = MAXFLOAT;
        animation1.autoreverses = false;
        animation1.fillMode = kCAFillModeForwards;
        [_uploadingView.layer addAnimation:animation1 forKey:nil];
    }
    return _uploadingView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil && _closeBtn) {
        CGPoint tempoint = [self.closeBtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.closeBtn.bounds, tempoint)) {
            view = self.closeBtn;
        }
    }
    return view;
}

@end
