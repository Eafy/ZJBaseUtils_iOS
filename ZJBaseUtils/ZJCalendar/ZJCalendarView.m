//
//  ZJCalendarView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/22.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJCalendarView.h>
#import <ZJBaseUtils/ZJCalendarCollectionViewCell.h>
#import <ZJBaseUtils/ZJCalendarCollectionReusableView.h>
#import <ZJBaseUtils/ZJCalendarWeekTitleView.h>
#import <ZJBaseUtils/ZJCalendarCenter.h>
#import <ZJBaseUtils/ZJBaseUtils.h>

// view高度
#define CalendarViewHeight (495+ZJSafeAreaBottom())

@interface ZJCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *maskInsideView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZJCalendarWeekTitleView *weekTitleView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) ZJButton *okButton;

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) ZJCalendarSelectedType selectedType;
@property (nonatomic, strong) NSMutableArray<ZJCalendarDay *> *selectedDays;
@property (nonatomic, strong) void(^completionBlock)(NSArray<ZJCalendarDay *> *);

@property (nonatomic, strong) NSDate *needShowDate;
@property (nonatomic, assign) BOOL expiredEnable;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation ZJCalendarView

- (instancetype)initWithSelectedType:(ZJCalendarSelectedType)type fromStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate withChineseCalendar:(BOOL)hasChinese expiredEnable:(BOOL)enable completion:(void(^)(NSArray<ZJCalendarDay *> *))completion {
    
    if (self = [super init]) {
        ZJCalendarCenter *calendarCenter = [[ZJCalendarCenter alloc] init];
        self.datas = [calendarCenter getMonthArrayFrom:startDate andEndDate:endDate withChineseCalendar:hasChinese];
        self.selectedType = type;
        self.expiredEnable = enable;
        self.completionBlock = completion;
        self.selectedDays = [NSMutableArray array];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        
        NSString *calendarTitleYear = @"CalendarTitleYear".localized;
        NSString *calendarTitleMon = @"CalendarTitleMon".localized;
        if (ZJSystem.currentLanguageType == ZJ_SYS_LANGUAGE_TYPE_ZH_Hans || ZJSystem.currentLanguageType == ZJ_SYS_LANGUAGE_TYPE_ZH_Hant) {
            if ([calendarTitleYear isEqualToString:@"CalendarTitleYear"]) {
                calendarTitleYear = @"年";
            }
            if ([calendarTitleMon isEqualToString:@"CalendarTitleMon"]) {
                calendarTitleMon = @"月";
            }
        } else {
            if ([calendarTitleYear isEqualToString:@"CalendarTitleYear"]) {
                calendarTitleYear = @" ";
            }
            if ([calendarTitleMon isEqualToString:@"CalendarTitleMon"]) {
                calendarTitleMon = @"Mon";
            }
        }
        self.dateFormatter.dateFormat = [NSString stringWithFormat:@"yyyy%@MM%@", calendarTitleYear, calendarTitleMon];
        [self configSubViews];
    }
    return self;
}

#pragma mark -

- (UIView *)maskInsideView {
    if (!_maskInsideView) {
        _maskInsideView = [[UIView alloc] init];
        _maskInsideView.backgroundColor = [ZJColorFromRGB(0x181E28) colorWithAlphaComponent:0.7];
        weakSelf(self);
        [_maskInsideView zj_addSingleTap:^(id  _Nonnull obj) {
            [weakSelf dismiss];
        }];
    }
    return _maskInsideView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ZJColorFromRGB(0xDCE0E8);
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Calendar Selection".localized;
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = ZJColorFromRGB(0x181E28);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGSize screenSize = UIScreen.mainScreen.bounds.size;
        CGFloat width = (screenSize.width-[self getCollectionViewMargin]*2)/7;
        CGFloat height = 55;
        layout.itemSize = CGSizeMake(width, height);
        layout.headerReferenceSize = CGSizeMake(screenSize.width, 55);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[ZJCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"ZJCalendarCollectionViewCell"];
        [_collectionView registerClass:[ZJCalendarCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZJCalendarCollectionReusableView"];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)configSubViews {
    [self addSubview:self.maskInsideView];
    [self addSubview:self.contentView];
    
    self.okButton = [ZJButton buttonWithStyle:ZJButtonStyleColor];
    self.okButton.frame = CGRectMake(0, 0, ZJScreenWidth()-32, 40);
    self.okButton.norTitle = @"OK".localized;
    [self.okButton addTarget:self action:@selector(clickedOKBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.closeButton = [[UIButton alloc] init];
    [self.closeButton setImage:[ZJBundleRes imageNamed:@"icon_alertview_close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    self.weekTitleView = [[ZJCalendarWeekTitleView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth()-[self getCollectionViewMargin]*2, 55)];
    self.weekTitleView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.closeButton];
    [self.contentView addSubview:self.weekTitleView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.okButton];
    [self updatedOKBtnState];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.maskInsideView.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(55, 0, self.contentView.bounds.size.width-110, 55);
    self.closeButton.frame = CGRectMake(self.contentView.bounds.size.width-16-55, 0, 55, 55);
    self.weekTitleView.frame = CGRectMake([self getCollectionViewMargin], 55, ZJScreenWidth()-[self getCollectionViewMargin]*2, 55);
    self.collectionView.frame = CGRectMake([self getCollectionViewMargin], 55, self.contentView.bounds.size.width-[self getCollectionViewMargin]*2, 385);
    self.lineView.frame = CGRectMake(0, self.collectionView.zj_bottom, self.contentView.bounds.size.width, 0.5);
    self.okButton.frame = CGRectMake(16, self.lineView.zj_bottom+8, self.contentView.bounds.size.width-16*2, 40);
    
    [self scrollTo:self.needShowDate];
}

/// 日历左右内边距
- (CGFloat)getCollectionViewMargin {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = ((int)w % 7)*0.5;
    if (margin<7) {
        margin += 7;
    }
    return margin;
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    
    self.frame = view.bounds;
    self.alpha = 0;
    self.contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, CalendarViewHeight);
    [self.contentView zj_cornerWithRadii:CGSizeMake(8, 8) rectCorner:(UIRectCornerTopLeft | UIRectCornerTopRight)];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.contentView.frame = CGRectMake(0, self.bounds.size.height-CalendarViewHeight, self.bounds.size.width, CalendarViewHeight);
    } completion:^(BOOL finished) {
        [self showDate:self.needShowDate];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, CalendarViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showDate:(NSDate *)date {
    self.needShowDate = date;
    [self scrollTo:date];
    self.weekTitleView.titleLabel.text = [self.dateFormatter stringFromDate:date];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    ZJCalendarMonth *month = self.datas[section];
    return month.days.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZJCalendarCollectionViewCell" forIndexPath:indexPath];
    ZJCalendarMonth *month = self.datas[indexPath.section];
    ZJCalendarDay *day = month.days[indexPath.row];
    [cell setupData:day type:self.selectedType hasSelected:self.selectedDays.count>1 expiredEnable:self.expiredEnable];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJCalendarMonth *month = self.datas[indexPath.section];
    ZJCalendarDay *day = month.days[indexPath.row];
    if (!self.expiredEnable && day.diffTaday < 0) return;
    
    if (self.selectedType == ZJCalendarSelectedTypeSingle) {
        [self singleSelected:indexPath];
    }else if (self.selectedType == ZJCalendarSelectedTypeMultiple){
        [self multipleSelected:indexPath];
    }else if (self.selectedType == ZJCalendarSelectedTypeRang){
        [self rangleSelected:indexPath];
    }
    [self updatedOKBtnState];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ZJCalendarCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZJCalendarCollectionReusableView" forIndexPath:indexPath];
    ZJCalendarMonth *month = self.datas[indexPath.section];
    headerView.titleLabel.text = [self.dateFormatter stringFromDate:month.date];
    return headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSArray<NSIndexPath *> *indexPaths = [self.collectionView indexPathsForVisibleSupplementaryElementsOfKind:UICollectionElementKindSectionHeader];
    for (NSIndexPath *indexP in indexPaths) {
        ZJCalendarCollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZJCalendarCollectionReusableView" forIndexPath:indexP];
        
        CGRect rect = [headerView.superview convertRect:headerView.frame toView:self.contentView];
        if (rect.origin.y<0 || rect.origin.y>500){
            return;
        }
        if (rect.origin.y<=70) {
            ZJCalendarMonth *month = self.datas[indexP.section];
            self.weekTitleView.titleLabel.text = [self.dateFormatter stringFromDate:month.date];
            return;
        }
        if (rect.origin.y>70) {
            if (indexP.section - 1 >= 0){
                ZJCalendarMonth *month = self.datas[indexP.section-1];
                self.weekTitleView.titleLabel.text = [self.dateFormatter stringFromDate:month.date];
                return;
            }
        }
    }
}

#pragma mark -

- (void)updatedOKBtnState {
    self.okButton.enabled = self.selectedDays.count > 0;
    if (self.selectedType == ZJCalendarSelectedTypeRang) {
        self.okButton.enabled = self.selectedDays.count > 1;
    }
}

- (void)clickedOKBtnAction:(ZJButton *)btn {
    [self dismiss];
    if (self.completionBlock) {
        self.completionBlock([self.selectedDays mutableCopy]);
    }
}

- (void)scrollTo:(NSDate *)date {
    if (date == nil) {
        return;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateCom = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    for (NSInteger i = 0; i < self.datas.count; i ++ ) {
        ZJCalendarMonth *month = self.datas[i];
        if (dateCom.year==month.year && dateCom.month == month.month) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:i] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentOffset.y==0 ? 0 : self.collectionView.contentOffset.y-55)];
             return;
        }
    }
}

// MARK:- 选择逻辑
// 单选
- (void)singleSelected:(NSIndexPath *)indexPath {
    
    ZJCalendarMonth *month = self.datas[indexPath.section];
    ZJCalendarDay *day = month.days[indexPath.row];
    if (self.selectedDays.count == 1) {
        ZJCalendarDay *seletedDay = self.selectedDays.firstObject;
        seletedDay.isSelected = NO;
        [self.selectedDays removeObject:seletedDay];
    } else {
        for (ZJCalendarDay *d in self.selectedDays) {
            d.isSelected = NO;
        }
        [self.selectedDays removeAllObjects];
    }
    day.isSelected = YES;
    [self.selectedDays addObject:day];
    [self.collectionView reloadData];
}

// 多选
- (void)multipleSelected:(NSIndexPath *)indexPath {
    
    ZJCalendarMonth *month = self.datas[indexPath.section];
    ZJCalendarDay *day = month.days[indexPath.row];
    day.isSelected = !day.isSelected;
    if (!day.isSelected) {
        if ([self.selectedDays containsObject:day]) {
            [self.selectedDays removeObject:day];
        }
    }else{
        [self.selectedDays addObject:day];
    }
    [self.collectionView reloadData];
}

// 区间选择
- (void)rangleSelected:(NSIndexPath *)indexPath {
    
    ZJCalendarMonth *month = self.datas[indexPath.section];
    ZJCalendarDay *day = month.days[indexPath.row];
    
    if (self.selectedDays.count == 0) {
        day.isSelected = !day.isSelected;
        [self.selectedDays addObject:day];
    } else if (self.selectedDays.count == 1) {
        ZJCalendarDay *seletedDay = self.selectedDays.firstObject;
        if ([seletedDay.date compare:day.date] == NSOrderedSame) {
            return;
        }
        
        NSComparisonResult compResult = [seletedDay.date compare:day.date];
        for (ZJCalendarMonth *monthM in self.datas) {
            if (monthM.year >= seletedDay.year || monthM.year <= day.year) {
                for (ZJCalendarDay *dayM in monthM.days) {
                    if ([dayM.date compare:day.date]==compResult && [seletedDay.date compare:dayM.date]==compResult) {
                        dayM.isSelected = YES;
                        if (compResult == NSOrderedAscending) {
                            [self.selectedDays addObject:dayM];
                        } else {
                            [self.selectedDays insertObject:dayM atIndex:0];
                        }
                    }
                }
            }
        }
        if (compResult == NSOrderedAscending) {
            [self.selectedDays addObject:day];
        } else {
            [self.selectedDays insertObject:day atIndex:0];
        }
        
        ZJCalendarDay *firstDay = self.selectedDays.firstObject;
        firstDay.isSelected = YES;
        firstDay.isBeginSelected = YES;
        ZJCalendarDay *lastDay = self.selectedDays.lastObject;
        lastDay.isSelected = YES;
        lastDay.isEndSelected = YES;
        
        [self.collectionView reloadData];
    } else if (self.selectedDays.count >=2) {
        for (ZJCalendarDay *d in self.selectedDays) {
            d.isSelected = NO;
            d.isEndSelected = NO;
            d.isBeginSelected = NO;
        }
        [self.selectedDays removeAllObjects];
        day.isSelected = !day.isSelected;
        [self.selectedDays addObject:day];
    }
    [self.collectionView reloadData];
}

@end
