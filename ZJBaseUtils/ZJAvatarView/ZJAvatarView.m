//
//  ZJAvatarView.m
//  ZJBaseUtils
//
//  Created by eafy on 2021/1/29.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJAvatarView.h>

@implementation ZJAvatarView

- (void)initDefaultData
{
    self.backgroundColor = [UIColor clearColor];
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.masksToBounds = YES;
    if (self.bounds.size.height > 0) {
        self.layer.cornerRadius = self.bounds.size.height/2;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.layer.cornerRadius == 0) {
        self.layer.cornerRadius = self.bounds.size.height/2;
    }
}

#pragma mark -

+ (instancetype)avatarWithName:(NSString *)imgName {
    ZJAvatarView *view = [[ZJAvatarView alloc] init];
    if (imgName) view.image = [UIImage imageNamed:imgName];
    [view initDefaultData];
    return view;
}


+ (instancetype)avatarSmallWithName:(NSString *)imgName {
    ZJAvatarView *view = [[ZJAvatarView alloc] initWithFrame:CGRectMake(0, 0, ZJAvatarViewFrameStyleSmall, ZJAvatarViewFrameStyleSmall)];
    if (imgName) view.image = [UIImage imageNamed:imgName];
    [view initDefaultData];
    return view;
}

+ (instancetype)avatarMediumWithName:(NSString *)imgName {
    ZJAvatarView *view = [[ZJAvatarView alloc] initWithFrame:CGRectMake(0, 0, ZJAvatarViewFrameStyleMedium, ZJAvatarViewFrameStyleMedium)];
    if (imgName) view.image = [UIImage imageNamed:imgName];
    [view initDefaultData];
    return view;
}

+ (instancetype)avatarLargeWithName:(NSString *)imgName {
    ZJAvatarView *view = [[ZJAvatarView alloc] initWithFrame:CGRectMake(0, 0, ZJAvatarViewFrameStyleLarge, ZJAvatarViewFrameStyleLarge)];
    if (imgName) view.image = [UIImage imageNamed:imgName];
    [view initDefaultData];
    return view;
}



@end
