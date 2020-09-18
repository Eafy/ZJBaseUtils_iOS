//
//  NSString+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/12.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JMExt)

- (NSData *)jm_base64Decode;

#pragma mark - 判断

/// 判断字符串是否为空字符串
- (BOOL)jm_isEmpty;

///  验证字符串是否为合法邮箱
- (BOOL)jm_isValidEmail;

/// 验证字符串是否为英文字符串
- (BOOL)jm_isValidChar;

/// 验证字符串是否是有效手机号码
- (BOOL)jm_isPhone;

/// 判断是否为有效长度的手机号
- (BOOL)jm_isPhone_11;

/// 字符串里是否包含中文
- (BOOL)jm_isContainChinese;

/// 是否包含数字
- (BOOL)jm_isContainNumber;

/// 判断字符串是否含有Emoji表情
- (BOOL)jm_isContainsEmoji;

#pragma mark - 数据和字符串互转

/// 数据转为字符串
/// @param bytes 数据
/// @param length 长度
+ (NSString *)jm_stringFromBytes:(unsigned char *)bytes length:(NSUInteger)length;

/// 随机获取字符串
/// @param size 生成字符串的长度
+ (NSString *)jm_stringRandomWithSize:(NSUInteger)size;

/// 将16进制字符串转为NSData
- (NSData *)jm_toData;

/// 扫描字符串，将第1个符合的字符串转为NSData
- (NSData *)jm_scanToData;

/// 扫描字符串，将第1个符合的字符串转为NSNumber
- (NSNumber *)jm_scanFirstToNumber;

#pragma mark - 显示类

/// 计算字符串所占尺寸
/// @param font 字体
/// @param maxSize 最大尺寸
- (CGSize)jm_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/// 编码：将字符串转化成UTF-8（主要用作emoji表情编码）
- (NSString *)jm_emojiToUTF8;

/// 解码：将带emoji字符串UTF-8编码转化为正常字符串
- (NSString *)jm_toEmoji;

/// 给文字添加颜色
/// @param color1 正常色
/// @param color2 特别色
/// @param specialStrings 要添加颜色的字符串数组（必须为strTemp中的字符串）
/// @param lineSpace 行高
/// @param fontSize 字体大小
/// @param alignment 字符对齐方式
- (NSMutableAttributedString *)jm_toColor:(UIColor *)color1
                                  specialColor:(UIColor * _Nullable)color2
                                specialStrings:(NSArray * _Nullable)specialStrings
                                   lineSpacing:(CGFloat)lineSpace
                                      fontSize:(CGFloat)fontSize
                                     alignment:(NSTextAlignment)alignment;


/// 去掉字符串中首尾的空格
- (NSString *)jm_removeBlank;

/// 根据左边和右边的字符串，截取中间特定字符串
/// @param leftStr 左边匹配字符串
/// @param rightStr 右边匹配的字符串
- (NSString*)jm_substringWithBoundsLeft:(NSString*)leftStr right:(NSString*)rightStr;

/// 获得汉字的拼音
- (NSString *)jm_chineseToPinyin;

@end

NS_ASSUME_NONNULL_END
