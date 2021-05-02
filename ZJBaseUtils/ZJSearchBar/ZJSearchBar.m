//
//  ZJSearchBar.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/30.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSearchBar.h"
#import "UISearchBar+ZJExt.h"
#import "UIColor+ZJExt.h"
#import "ZJBaseUtils.h"

@interface ZJSearchBar () <UISearchBarDelegate>

@property (nonatomic, assign) BOOL isSetTFHeight;

@end

@implementation ZJSearchBar

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder buttonTitle:(NSString *)buttonTitle {
    if (self = [super initWithFrame:frame]) {
        
        self.searchBarStyle = UISearchBarStyleMinimal;
        self.backgroundColor = [UIColor clearColor];
        self.showsCancelButton = YES;
        self.backgroundImage = [[UIImage alloc] init];
        self.tintColor = ZJColorFromRGB(0x181E28);
        self.barTintColor = ZJColorFromRGB(0x181E28);
        self.searchFieldBackgroundPositionAdjustment = UIOffsetMake(8, 0);
        [self setPositionAdjustment:UIOffsetMake(6, 0) forSearchBarIcon:UISearchBarIconSearch];
        
        [self zj_setCancelButtonTitle:buttonTitle];
        [self zj_setTextFont:[UIFont systemFontOfSize:14]];
        [self zj_setCancelButtonTitleColor:ZJColorFromRGB(0x181E28) font:[UIFont systemFontOfSize:14]];
        [self setImage:[ZJBundleRes imageNamed:@"icon_searchbar_clear_normal"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        [self setImage:[ZJBundleRes imageNamed:@"icon_textField_clear_normal"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
        
        UITextField *searchField = [self valueForKey:@"searchField"];
        if (searchField) {
            if (placeholder) {
                searchField.attributedPlaceholder = [placeholder zj_stringWithColor:ZJColorFromRGB(0x8690A9) font:[UIFont systemFontOfSize:14]];
            }
            [searchField setBackground:nil];
            [searchField setBorderStyle:UITextBorderStyleNone];
            [searchField setTintColor:ZJColorFromRGB(0x8690A9)];
            [searchField setBackgroundColor:ZJColorFromRGB(0xF5F8FC)];
            searchField.layer.cornerRadius = 8;
            searchField.layer.masksToBounds = YES;
            
        }
        UIButton *cancelBtn = [self valueForKey:@"cancelButton"];
        cancelBtn.enabled = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UITextField *searchField = [self valueForKey:@"searchField"];
    if (!self.isSetTFHeight) {
        self.isSetTFHeight = YES;
        [self setSearchFieldBackgroundImage:[UIImage zj_imageWithColor:ZJColorFromRGB(0xF5F8FC) size:CGSizeMake(self.zj_width, self.zj_height-1.75)] forState:UIControlStateNormal];
    } else {
        if (searchField) {
            searchField.zj_top = 0;
            searchField.zj_height = self.zj_height;
            searchField.zj_centerY = self.zj_height/2;

            for (UIView *view in searchField.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"_UITextFieldImageBackgroundView")] ||
                    [view isKindOfClass:NSClassFromString(@"_UISearchTextFieldCanvasView")]) {
                    view.zj_top = 0;
                    view.zj_height = self.zj_height;
                    view.zj_centerY += 0.5;
                }
            }
        }
    }
}

@end
