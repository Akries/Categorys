//
//  NSDate+HandleDate.h
//  XXDNew
//
//  Created by tang on 2017/5/23.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//  统一处理时间

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DateFormatterType) {
    DateFormatterType_Day = 0,
    DateFormatterType_second,
    DateFormatterType_Year
};

@interface NSDate (HandleDate)


+ (NSDate *)dateWithTimeStamp:(NSString *)timeStamp;

+ (NSString *)dateStringWithTimeStamp:(NSString *)timeStamp fmtType:(DateFormatterType)type;

+ (BOOL)isTheSameDayWithOldDay:(NSDate *)oldDate;


/**
 两个时间戳之间相差多少小时

 @param oneTime 一个时间戳 如果为nil 默认为now
 @param otherTime 另一个时间戳
 @return 相差时间
 */
+ (double)distanceHoursBetween:(NSString *)oneTime otherTime:(NSString *)otherTime;

@end
