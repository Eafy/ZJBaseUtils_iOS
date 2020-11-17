//
//  ZJPHAsset.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJPHAsset.h"

@implementation ZJPHAsset

- (instancetype)initWithPlayerItem:(AVPlayerItem * _Nullable)playerItem
{
    if (self = [super init] ) {
        _creationTimeInterval = self.creationDate.timeIntervalSince1970;
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *_Nullable)url
{
    if (self = [super init] ) {
        _creationTimeInterval = self.creationDate.timeIntervalSince1970;
    }
    return self;
}

#pragma mark -

- (AVPlayerItem *)playerItem
{
    if (!_playerItem && !_url && self.mediaType == PHAssetMediaTypeVideo) {
        _playerItem = [[AVPlayerItem alloc] initWithURL:self.url];
    }
    return _playerItem;
}

- (CGSize)size
{
    return CGSizeMake(self.pixelWidth, self.pixelHeight);
}

@end
