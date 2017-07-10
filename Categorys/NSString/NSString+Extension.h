//
//  NSString+Extension.h
//  XXDNew
//
//  Created by Akries on 2016/10/28.
//  Copyright © 2016年 Ak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  正则
 */
+ (BOOL)isAllNumbers:(NSString *)str;
+ (BOOL)isAllChars:(NSString *)str;
+ (BOOL)isContainTwo:(NSString *)str;
+ (BOOL)isHaveIllegalChar:(NSString *)str;
+ (BOOL)validateMoblie:(NSString *)mobileNumber;
+ (BOOL)validatePhoneNumber:(NSString *)phoneNo;
+ (BOOL)validateMailBox:(NSString *)mailBox;


/**
 千分制
 */
+ (NSString *)positiveFormat:(NSString *)text;
/**
 url 编码
 */
- (NSString*)encodeString;

- (NSString *)positiveFormat;
- (NSString *)positiveFormatCutDecimal;// 去掉小数部分的
/**
 6-16为字母+数字组合
 */
- (BOOL)isNumAndChars;

/**
 *  判断
 */
+ (BOOL)includeChieseString:(NSString *)string;

/**
 *  去掉所有空格
 */
+ (NSString *)replaceAllSpace:(NSString *)string;

/**
 *  去掉前后空格
 */
+ (NSString *)replaceFrontLastSpace:(NSString *)string;

/**
 *   时间戳返回时间
 */
+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString;


/**
 *    判断键盘是否为emoji键盘,默认返回不是emoji键盘，tim添加
 */
+ (BOOL)isEmojiKeyboard:(id)view;

/**
 两个时间戳的相差时间
 */
+ (NSString*)compareTwoTime:(long long)time1 time2:(long long)time2;


/**
 是否为空串
 */
- (NSString *)notNullString;

/**
 变成拼音
 */
- (NSString *)transformToPinyin;

/**
 全字母 数字 字符
 */
- (BOOL)isAllEngNumAndSpecialSign;



/**
 md5加密
 */
+ (NSString *)md5:(NSString *)needMd5String;//一个类方法  一个对象 洋帅逼想用哪个就用那个(16位)
- (NSString *)md5Mod16;
- (NSString *)md5Mod16Big;
- (NSString *)md5Mod32;

/**
 纵向排列

 @return 返回纵向排列的STRING
 */
- (NSString *)VerticalString;


#pragma mark - 路径方法
/**
 *  快速返回沙盒中，Documents文件的路径
 *
 *  @return Documents文件的路径
 */
+ (NSString *)pathForDocuments;
/**
 *  快速返回沙盒中，Documents文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Documents文件中某个子文件的路径
 */
+ (NSString *)filePathAtDocumentsWithFileName:(NSString *)fileName;
/**
 *  快速返回沙盒中，Library下Caches文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (NSString *)pathForCaches;

/**
 *  快速返回沙盒中，Library下Caches文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Caches文件中某个子文件的路径
 */
+ (NSString *)filePathAtCachesWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，MainBundle(资源捆绑包的)的路径
 *
 *  @return 快速返回MainBundle(资源捆绑包的)的路径
 */
+ (NSString *)pathForMainBundle;

/**
 *  快速返回沙盒中，MainBundle(资源捆绑包的)中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回MainBundle(资源捆绑包的)中某个子文件的路径
 */
+ (NSString *)filePathAtMainBundleWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，tmp(临时文件)文件的路径
 *
 *  @return 快速返回沙盒中tmp文件的路径
 */
+ (NSString *)pathForTemp;

/**
 *  快速返回沙盒中，temp文件中某个子文件的路径
 *
 *  @param fileName 子文件名
 *
 *  @return 快速返回temp文件中某个子文件的路径
 */
+ (NSString *)filePathAtTempWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，Library下Preferences文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (NSString *)pathForPreferences;

/**
 *  快速返回沙盒中，Library下Preferences文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Preferences文件中某个子文件的路径
 */
+ (NSString *)filePathAtPreferencesWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷
 *
 *  @param directory NSSearchPathDirectory枚举
 *
 *  @return 快速你指定的系统文件的路径
 */
+ (NSString *)pathForSystemFile:(NSSearchPathDirectory)directory;

/**
 *  快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName
 *
 *  @param directory 你指的的系统文件
 *  @param fileName  子文件名
 *
 *  @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (NSString *)filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName;

#pragma mark - 文本计算方法
/**
 *  快速计算出文本的真实尺寸
 *
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

/**
 *  快速计算出文本的真实尺寸
 *
 *  @param text    需要计算尺寸的文本
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize;


@end
