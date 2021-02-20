//
//  ZJCalendarCollectionViewCell.h
//  ZJUXKit
//
//  Created by eafy on 2020/9/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJCalendarMonth.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJCalendarCollectionViewCell : UICollectionViewCell

- (void)setupData:(ZJCalendarDay *)day
             type:(ZJCalendarSelectedType)type
      hasSelected:(BOOL)hasRangSelected
    expiredEnable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
