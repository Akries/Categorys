//
//  NSString+Ext.h
//  XiYuWang
//
//  Created by 李胜书 on 16/6/20.
//  Copyright © 2016年 Ehsy_Sanli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

- (NSString *)transformToPinyin;

- (BOOL)isAllEngNumAndSpecialSign;
///md5 16位加密 （小写）
- (NSString *)md5Mod16;
///md5 16位加密 （大写）
- (NSString *)md5Mod16Big;
///md5 32位加密
- (NSString *)md5Mod32;
- (NSString *)notNullString;
///获取当前时间段字符
- (NSString *)currentDate;
///获取当前时间段字符的格式
- (NSString *)currentDate:(NSString *)dateFormate;
/**
 电话号码从第几个开始到多长为止用其他字符替换

 @param startIndex 开始坐标
 @param length     长度
 @param replaceStr 替换的字符

 @return 返回新的字符串，如果长度越界，则直接返回自身
 */
- (NSString *)replaceString:(NSInteger)startIndex Length:(NSInteger)length String:(NSString *)replaceStr;

/**
 脱敏展示

 @param startIndex 开始坐标
 @param length     长度
 @param replaceStr 替换的字符
 @param perSpace   每隔多少个长度一个间隔
 @return 脱敏后的字符串
 */
- (NSString *)tt_replaceStart:(NSInteger)startIndex
                    length:(NSInteger)length
                replaceStr:(NSString *)replaceStr
                  perSpace:(NSInteger)perSpace;

- (NSString *)dictionaryToJson:(NSDictionary *)dic;

/**
 将毫秒转为日期

 @param timeStr 需要转的毫秒字符串
 @param timeFormat 需要转的时间格式
 @return 返回的日期
 */
- (NSString *)ConvertStrToTime:(NSString *)timeStr TimeFormat:(NSString *)timeFormat;

/**
 身份证正则匹配
 */
- (BOOL)isIDCardIllegal;

@end
