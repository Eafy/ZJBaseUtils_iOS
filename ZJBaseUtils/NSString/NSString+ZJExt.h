//
//  NSString+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/12.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJExt)

- (NSData *)zj_base64Decode;

#pragma mark - 判断

/// 判断字符串是否为空字符串
/// @param str 需要判断的字符串
+ (BOOL)zj_isEmpty:(nullable NSString *)str;

///  验证字符串是否为合法邮箱
- (BOOL)zj_isValidEmail;

/// 验证字符串是否为英文字符串
- (BOOL)zj_isValidChar;

/// 验证字符串是否是有效手机号码
- (BOOL)zj_isPhone;

/// 判断是否为有效长度的手机号
- (BOOL)zj_isPhone_11;

/// 字符串里是否包含中文
- (BOOL)zj_isContainChinese;

/// 是否包含数字
- (BOOL)zj_isContainNumber;

/// 判断字符串是否含有Emoji表情
- (BOOL)zj_isContainsEmoji;


#pragma mark - 数据和字符串互转

/// 数据转为字符串（默认大写）
/// @param bytes 数据
/// @param length 长度
+ (NSString *)zj_stringFromBytes:(unsigned char *)bytes length:(NSUInteger)length;

/// 数据转为字符串（默认小写）
/// @param bytes 数据
/// @param length 长度
+ (NSString *)zj_stringFromLowercaseBytes:(unsigned char *)bytes length:(NSUInteger)length;

/// 随机获取字符串
/// @param size 生成字符串的长度
+ (NSString *)zj_stringRandomWithSize:(NSUInteger)size;

/// 随机数字
/// @param size 生成字符串的长度
+ (NSString *)zj_numberRandomWithSize:(NSUInteger)size;

/// 将16进制字符串转为NSData
- (NSData *)zj_toData;

/// 扫描字符串，将第1个符合的字符串转为NSData
- (NSData *)zj_scanToData;

/// 扫描字符串，将第1个符合的字符串转为NSNumber
- (NSNumber *)zj_scanFirstToNumber;

#pragma mark - 显示类

/// 计算字符串所占尺寸
/// @param font 字体
/// @param maxSize 最大尺寸
- (CGSize)zj_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/// 编码：将字符串转化成UTF-8（主要用作emoji表情编码）
- (NSString *)zj_emojiToUTF8;

/// 解码：将带emoji字符串UTF-8编码转化为正常字符串
- (NSString *)zj_toEmoji;

/// 给文字添加颜色
/// @param color1 正常色
/// @param color2 特别色
/// @param specialStrings 要添加颜色的字符串数组（必须为strTemp中的字符串）
/// @param lineSpace 行高
/// @param font 字体
/// @param alignment 字符对齐方式
- (NSMutableAttributedString *)zj_stringWithColor:(UIColor *)color1 specialColor:(UIColor * _Nullable)color2 specialStrings:(NSArray * _Nullable)specialStrings lineSpacing:(CGFloat)lineSpace font:(UIFont *)font alignment:(NSTextAlignment)alignment;

/// 给文字设置字体和颜色描述
/// @param color 颜色
/// @param font 字体
- (NSMutableAttributedString *)zj_stringWithColor:(UIColor *)color font:(UIFont *)font;

/// 去掉字符串中首尾的空格
- (NSString *)zj_removeBlank;

/// 根据左边和右边的字符串，截取中间特定字符串
/// @param leftStr 左边匹配字符串
/// @param rightStr 右边匹配的字符串
- (NSString*)zj_substringWithBoundsLeft:(NSString*)leftStr right:(NSString*)rightStr;

/// 获得汉字的拼音
- (NSString *)zj_chineseToPinyin;

@end

NS_ASSUME_NONNULL_END
