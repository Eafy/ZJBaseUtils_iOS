//
//  NSString+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/12.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/NSString+ZJExt.h>

@implementation NSString (ZJExt)

- (NSData *)zj_base64Decode
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

#pragma mark -

+ (BOOL)zj_isEmpty:(NSString *)str
{
    if (!str) return YES;
    return [str isEqualToString:@""];
}

- (BOOL)isValidateByRegex:(NSString *)regex
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)zj_isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

- (BOOL)zj_isValidChar
{
    NSString *stringRegex = @"[[A-Z0-9a-z._%+-]]";
    return [self isValidateByRegex:stringRegex];
}

- (BOOL)zj_isPhone
{
    NSString *reg = @"^(0|86|17951)?((1[3,5,7,8][0-9])|(14[5,7])|(17[0,6,7,8])|(19[7]))\\d{8}$";
    if ([self isValidateByRegex:reg]) {
        return YES;
    }
    return NO;
    
}

- (BOOL)zj_isPhone_11
{
    NSString *reg = @"^[0-9]*[1-9][0-9]*$";
    if ([self isValidateByRegex:reg] && self.length <= 11) {
        return YES;
    }
    return NO;
}

- (BOOL)zj_isContainChinese
{
    NSString *reg = @".*[\u4e00-\u9fa5].*";
    if ([self isValidateByRegex:reg]) {
        return YES;
    }
    return NO;
}

- (BOOL)zj_isContainNumber
{
    NSString *regex= @"^-?[1-9]\\d*$";
    BOOL isMatch = [self isValidateByRegex:regex];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)zj_isContainsEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
    {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (0x278b <= hs && hs <= 0x2792) {     //中文9宫格键盘输入的字符不是表情
            returnValue = NO;
        } else if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        }
    }];
    
    return returnValue;
}

#pragma mark - 数据和字符串互转

+ (NSString *)zj_stringFromBytes:(unsigned char *)bytes length:(NSUInteger)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++) {
        [mutableString appendFormat:@"%02X", bytes[i]];
    }
    return [NSString stringWithString:mutableString];
}

+ (NSString *)zj_stringFromLowercaseBytes:(unsigned char *)bytes length:(NSUInteger)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++) {
        [mutableString appendFormat:@"%02x", bytes[i]];
    }
    return [NSString stringWithString:mutableString];
}

+ (NSString *)zj_stringRandomWithSize:(NSUInteger)size
{
    if (size == 0) return @"";
    
    char data[size];
    for (int i=0; i<size; i++) {
        if (arc4random_uniform(3) == 0) {
            data[i] = (char)('0' + (arc4random_uniform(10)));
        } else if (arc4random_uniform(3) == 1) {
            data[i] = (char)('a' + (arc4random_uniform(26)));
        } else {
            data[i] = (char)('A' + (arc4random_uniform(26)));
        }
    }
    return [[NSString alloc] initWithBytes:data length:size encoding:NSUTF8StringEncoding];
}

+ (NSString *)zj_numberRandomWithSize:(NSUInteger)size
{
    if (size == 0) return @"";
    
    char data[size];
    for (int i=0; i<size; i++) {
        data[i] = (char)('0' + (arc4random_uniform(10)));
    }
    return [[NSString alloc] initWithBytes:data length:size encoding:NSUTF8StringEncoding];
}

- (NSData *)zj_toData
{
    NSString *string = [self lowercaseString];
    NSMutableData *data = [NSMutableData data];
    char byte_chars[3] = {'\0','\0','\0'};
    
    NSUInteger length = string.length;
    int i = 0;
    unsigned char whole_byte;
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

- (NSString *)zj_toHexString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    const char *bytes = [data bytes];
    
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        hexStr = [NSString stringWithFormat:@"%@%02X", hexStr, bytes[i] & 0xFF];   ///16进制数
    }
    return hexStr;
}

- (NSString *)zj_fromHexString
{
    if ([self length] <= 0) return @"";
    char *cBuff = calloc(1, [self length] / 2 + 1);
    if (!cBuff) return @"";
    
    unsigned int anInt;
    for (int i = 0; i < [self length] - 1; i += 2) {
        NSString * hexCharStr = [self substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        cBuff[i / 2] = (char)anInt;
    }
    NSString *str = [NSString stringWithCString:cBuff encoding:NSUTF8StringEncoding];
    free(cBuff);
    
    return str;
}

- (NSData *)zj_scanToData
{
    NSData *data = [NSData data];
    if (self.length) {
        if ([self characterAtIndex:0] != '"') {
            data = [self zj_toData];
        } else {
            NSString *str = [self substringFromIndex:1];
            data = [[NSData alloc] initWithData:[str dataUsingEncoding:NSASCIIStringEncoding]];
        }
    }
    return data;
}

- (NSNumber *)zj_scanFirstToNumber
{
    if (!self) return nil;
    NSScanner* scanner = [NSScanner scannerWithString:self];
    NSNumber *hexNSNumber;
    
    if ([self characterAtIndex:0] != '0') {
        uint hexValue;
        if ([scanner scanHexInt:&hexValue])
            hexNSNumber = [NSNumber numberWithInt:hexValue];
    } else {
        int value;
        if ([scanner scanInt:&value]) {
            hexNSNumber = [NSNumber numberWithInt:value];
        }
    }
    
    return (hexNSNumber);
}

#pragma mark - 

- (CGSize)zj_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    if (!font) return CGSizeZero;
    
    CGSize textSize;
    if (CGSizeEqualToSize(maxSize, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    } else {
        NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:maxSize
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}

- (NSString *)zj_emojiToUTF8
{
    NSString *uniStr = [NSString stringWithUTF8String:[self UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *utf8Str = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding];
    
    return utf8Str;
}

- (NSString *)zj_toEmoji
{
    const char *jsonString = [self UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *emojiStr = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    
    return emojiStr;
}

- (NSMutableAttributedString *)zj_stringWithColor:(UIColor *)color1 specialColor:(UIColor *)color2 specialStrings:(NSArray *)specialStrings lineSpacing:(CGFloat)lineSpace font:(UIFont *)font alignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = alignment;
    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    paragraphStyle.lineSpacing = lineSpace;  //行自定义行高度
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName:color1, NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
    if (color2) {
        for (NSString *specialString in specialStrings) {
            [str addAttribute:NSForegroundColorAttributeName value:color2 range:[self rangeOfString:specialString]];
        }
    }
    return str;
}

- (NSMutableAttributedString *)zj_stringWithColor:(UIColor *)color font:(UIFont *)font
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:font}];
    return str;
}

- (NSString *)zj_removeBlank
{
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return str;
}

- (NSString*)zj_substringWithBoundsLeft:(NSString*)leftStr right:(NSString*)rightStr
{
    NSRange rangeSub;
    NSString *strSub;
    
    NSRange range;
    range = [self rangeOfString:leftStr options:0];
    
    if (range.location == NSNotFound) {
        return nil;
    }
    
    rangeSub.location = range.location + range.length;
    
    range.location = rangeSub.location;
    range.length = [self length] - range.location;
    range = [self rangeOfString:rightStr options:0 range:range];
    
    if (range.location == NSNotFound) {
        return nil;
    }
    
    rangeSub.length = range.location - rangeSub.location;
    strSub = [[self substringWithRange:rangeSub] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return strSub;
}

- (NSString *)zj_chineseToPinyin
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}

@end
