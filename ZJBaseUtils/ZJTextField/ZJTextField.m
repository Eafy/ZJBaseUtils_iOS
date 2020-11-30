//
//  ZJTextField.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/30.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJTextField.h"

@implementation ZJTextField

- (void)deleteBackward {
    if ([self.zj_delegate respondsToSelector:@selector(textFieldWillDeleteBackward:)]) {
        [self.zj_delegate textFieldWillDeleteBackward:self];
    }
    [super deleteBackward];
    if ([self.zj_delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        [self.zj_delegate textFieldDidDeleteBackward:self];
    }
}

@end
