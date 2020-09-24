//
//  JMPublicButton.m
//  DvrDirectConTool
//
//  Created by 李治健 on 2020/9/17.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "JMPublicButton.h"

@implementation JMPublicButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        self.layer.cornerRadius = 24.0f;
        self.layer.masksToBounds = YES;
        [self setBackgroundImage:[UIImage jm_imageWithColor:JMColorFromHex(@"#1C7EFF")] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage jm_imageWithColor:JMColorFromHex(@"#1C74E9")] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage jm_imageWithColor:JMColorFromHex(@"#A5CCFF")] forState:UIControlStateDisabled];
    }
    return self;
}

@end
