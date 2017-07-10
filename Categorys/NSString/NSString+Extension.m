//
//  NSString+Extension.m
//  XXDNew
//
//  Created by Akries on 2016/10/28.
//  Copyright © 2016年 Ak. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)


/**
 转千分制
*/
+ (NSString *)positiveFormat:(NSString *)text{
    
    if(!text || [text floatValue] == 0){
        return @"0.00";
    }else if([text floatValue] < 1 && [text floatValue] > 0 ){
        return text;
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###.00;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"";
}

//URL编码
- (NSString*)encodeString{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

- (NSString *)positiveFormat {
    if (self == nil || self.floatValue == 0) {
        return @"0.00";
    } else {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,##0.00;"];// ,###.00;
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    }
    return @"";
}

- (NSString *)positiveFormatCutDecimal {
    if (self == nil || self.floatValue == 0) {
        return @"0";
    } else {
//        
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        [numberFormatter setPositiveFormat:@"###,##0;"];// ,###.00;
//        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,##0.00;"];
        NSString *result = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
        if ([result containsString:@"."]) {
            NSArray *temp = [result componentsSeparatedByString:@"."];
            if (temp.count > 1) {
                NSString *decimal = (NSString *)temp[1];
                if (decimal.floatValue == 0) {
                    result = temp[0];
                }
            }
        }
        return result;
    }
    return @"";
}

/**
 *  判断全数字 或英文
 */
+ (BOOL)isAllChars:(NSString *)str{
    NSString *mobileRegex = @"^[A-Za-z]+$";
    NSPredicate *registmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    return [registmobile evaluateWithObject:str];
}

+ (BOOL)isAllNumbers:(NSString *)str{
    NSString *mobileRegex = @"^[0-9]+$";
    NSPredicate *registmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    return [registmobile evaluateWithObject:str];
}

/**
 *
 */
+ (BOOL)isContainTwo:(NSString *)str{
    NSString *mobileRegex = @"(?!^[0-9]+$)(?!^[a-z]+$)(?!^[A-Z]+$)(?!^[^A-z0-9]+$)^.{6,20}$";
    NSPredicate *registmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    return [registmobile evaluateWithObject:str];
}

/**
 *  判断非法字符
 */
+ (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%*`~!@#^+=_）\\|~＜＞$%^&*_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    
    return range.location < str.length;
}

/**
 *  判断手机号码的合法性
 */
+ (BOOL)validateMoblie:(NSString *)mobileNumber
{
    NSString *mobileRegex = @"1[0-9]{10}";
    NSPredicate *registmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    return [registmobile evaluateWithObject:mobileNumber];
}

/**
 *  判断邮箱的合法性
 */
+ (BOOL)validateMailBox:(NSString *)mailBox
{
    NSString* emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:mailBox];
}

/**
 *  判断固定电话的合法性
 */
+ (BOOL)validatePhoneNumber:(NSString *)phoneNo
{
    NSString *phoneRegex = @"0[0-9]{2,4}\\-[0-9]{6,14}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNo];
}


/**
 *  子串是不是包含中文
 */
+ (BOOL)includeChieseString:(NSString *)string
{
    for (int i = 0; i < string.length; i ++) {
        
        unichar ch = [string characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

/**
 *  去除空格
 */
+ (NSString *)replaceAllSpace:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}

/**
 *  去除先后空格
 */
+ (NSString *)replaceFrontLastSpace:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return string;
}

//将date时间戳转变成时间字符串
//@paaram   date            用于转换的时间
//@param    formatString    时间格式(yyyy-MM-dd HH:mm:ss)
//@return   NSString        返回字字符如（2012－8－8 11:11:11）
+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    return dateString;
}

/**
 *    判断键盘是否为emoji键盘,默认返回不是emoji键盘
 */
+ (BOOL)isEmojiKeyboard:(id)view;
{
    if ([view isKindOfClass:[UITextField class]]) {
        UITextField *tf = (UITextField *)view;
        return tf.textInputMode.primaryLanguage ? NO : YES;
    }else if([view isKindOfClass:[UITextView class]]){
        UITextView *tv = (UITextView *)view;
        return tv.textInputMode.primaryLanguage ? NO : YES;
    }else if ([view isKindOfClass:[UISearchBar class]]){
        //UISearchBar里面包含一个view，view里面包含UISearchBarTextField,UISearchBarTextField是一个UITextField
        UITextField *tf;
        UISearchBar *sb = (UISearchBar *)view;
        for (UIView *view in sb.subviews) {
            if ([view isKindOfClass:[UIView class]] && view.subviews.count > 0) {
                for (UIView *tmpView in view.subviews) {
                    if ([tmpView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                        tf = (UITextField *)tmpView;
                        break;
                    }
                }
            }
        }
        if (tf) {
            return tf.textInputMode.primaryLanguage ? NO : YES;
        }
    }else{
    }
    return NO;
}

- (NSString *)notNullString {
    NSString *str = self;
    if ([str isEqual:[NSNull null]] || ![str isKindOfClass:[NSString class]] || !str || [str isEqualToString:@"null"]|| [str isEqualToString:@"<null>"]) {
        str = @"";
    }
    return str;
}

- (BOOL)isAllEngNumAndSpecialSign {
    NSString *regularString = @"^[A-Za-z0-9\\p{Z}\\p{P}]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularString];
    return [predicate evaluateWithObject:self];
}

- (NSString *)transformToPinyin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
}



/**
 *  md5加密
 */
+ (NSString *)md5:(NSString *)needMd5String
{
    const char *cStr = [needMd5String UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//md5 32位 加密 （小写）
- (NSString *)md5Mod32 {
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]] lowercaseString];
}

//md5 16位加密 （大写）
- (NSString *)md5Mod16Big {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr),result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//md5 16位加密 （小写）
- (NSString *)md5Mod16 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr),result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)VerticalString {
    NSMutableString * str = [[NSMutableString alloc] initWithString:self];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}

+ (NSString*)compareTwoTime:(long long)time1 time2:(long long)time2
{
    NSTimeInterval balance = time2 /1000- time1 /1000;
    NSString *timeString = [[NSString alloc]init];
    timeString = [NSString stringWithFormat:@"%f",balance / 60];
    timeString = [timeString substringToIndex:timeString.length-7];
    
    NSInteger timeInt = [timeString intValue];
    
    NSInteger hour = timeInt / 60;
    
    NSInteger mint = timeInt % 60;
    
    if(hour == 0) {
        timeString = [NSString stringWithFormat:@"%ld分钟",(long)mint];
    }else{
        if(mint == 0) {
            timeString = [NSString stringWithFormat:@"%ld小时",(long)hour];
        }else{
            timeString = [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hour,(long)mint];
        }
    }
    return timeString;
}



/**
 *  快速返回沙盒中，Documents文件的路径
 *
 *  @return Documents文件的路径
 */
+ (NSString *)pathForDocuments
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  快速返回Documents文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Documents文件中某个子文件的路径
 */
+ (NSString *)filePathAtDocumentsWithFileName:(NSString *)fileName
{
    return  [[self pathForDocuments] stringByAppendingPathComponent:fileName];
}

/**
 *  快速返回沙盒中Library下Caches文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (NSString *)pathForCaches
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)filePathAtCachesWithFileName:(NSString *)fileName
{
    return [[self pathForCaches] stringByAppendingPathComponent:fileName];
}

/**
 *  快速返回MainBundle(资源捆绑包的)的路径
 *
 *  @return 快速返回MainBundle(资源捆绑包的)的路径
 */
+ (NSString *)pathForMainBundle
{
    return [NSBundle mainBundle].bundlePath;
}

/**
 *  快速返回MainBundle(资源捆绑包的)下文件的路径
 *
 *  @param fileName MainBundle(资源捆绑包的)下的文件名
 *
 *  @return 快速返回MainBundle(资源捆绑包的)下文件的路径
 */
+ (NSString *)filePathAtMainBundleWithFileName:(NSString *)fileName
{
    return [[self pathForMainBundle] stringByAppendingPathComponent:fileName];
}

/**
 *  快速返回沙盒中tmp(临时文件)文件的路径
 *
 *  @return 快速返回沙盒中tmp文件的路径
 */
+ (NSString *)pathForTemp
{
    return NSTemporaryDirectory();
}

/**
 *  快速返回沙盒中，temp文件中某个子文件的路径
 *
 *  @param fileName 子文件名
 *
 *  @return 快速返回temp文件中某个子文件的路径
 */
+ (NSString *)filePathAtTempWithFileName:(NSString *)fileName
{
    return [[self pathForTemp] stringByAppendingPathComponent:fileName];
}

/**
 *  快速返回沙盒中，Library下Preferences文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (NSString *)pathForPreferences
{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  快速返回沙盒中，Library下Preferences文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Preferences文件中某个子文件的路径
 */
+ (NSString *)filePathAtPreferencesWithFileName:(NSString *)fileName
{
    return [[self pathForPreferences] stringByAppendingPathComponent:fileName];
}

/**
 *  快速你指定的系统文件的路径
 *
 *  @param directory NSSearchPathDirectory枚举
 *
 *  @return 快速你指定的系统文件的路径
 */
+ (NSString *)pathForSystemFile:(NSSearchPathDirectory)directory
{
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) lastObject];
}

/**
 *  快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName
 *
 *  @param directory 你指的的系统文件
 *  @param fileName  子文件名
 *
 *  @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (NSString *)filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName
{
    return [[self pathForSystemFile:directory] stringByAppendingPathComponent:fileName];
}

/**
 *  快速计算出文本的真实尺寸
 *
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary *arrts = @{NSFontAttributeName:font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
}

/**
 *  快速计算出文本的真实尺寸
 *
 *  @param text    需要计算尺寸的文本
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    return [text sizeWithFont:font andMaxSize:maxSize];
}


- (BOOL)isNumAndChars {
    NSString *mobileRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *registmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    return [registmobile evaluateWithObject:self];
}

@end
