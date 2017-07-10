//
//  NSDate+HandleDate.m
//  XXDNew
//
//  Created by tang on 2017/5/23.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import "NSDate+HandleDate.h"

@implementation NSDate (HandleDate)

+ (NSDate *)dateWithTimeStamp:(NSString *)timeStamp {
    return [NSDate dateWithTimeIntervalSince1970:timeStamp.longLongValue / 1000];
}

+ (NSString *)dateStringWithTimeStamp:(NSString *)timeStamp fmtType:(DateFormatterType)type {
    NSDateFormatter *fmt = [NSDateFormatter new];
    switch (type) {
        case DateFormatterType_Day:
            fmt.dateFormat = kMineDateFormater_Day;
            break;
        case DateFormatterType_second:
            fmt.dateFormat = kMineDateFormater_Second;
            break;
        case DateFormatterType_Year:
            fmt.dateFormat = kMineDateFormater_Year;
            break;
        default:
            fmt.dateFormat = kMineDateFormater_Day;
            break;
    }
    return [fmt stringFromDate:[self dateWithTimeStamp:timeStamp]];
}

+ (BOOL)isTheSameDayWithOldDay:(NSDate *)oldDate {
    if (oldDate == nil) return NO;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *oldComp = [calendar components:unitFlags fromDate:oldDate];
    NSDateComponents *CurComp = [calendar components:unitFlags fromDate:[NSDate date]];
    
    return [oldComp day] == [CurComp day] &&
           [oldComp month] == [CurComp month] &&
           [oldComp year]  == [CurComp year];
}



+ (double)distanceHoursBetween:(NSString *)oneTime otherTime:(NSString *)otherTime {
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger delta = [timeZone secondsFromGMT];
    
    // 两个时间戳转换日期类
    // start
    NSDate  *DRstartDate;
    if (oneTime.length == 0) { // 如果没有开始时间 ，默认现在时间
        NSDate *nowDate = [NSDate date];
        NSTimeInterval nowInter = nowDate.timeIntervalSince1970;
        DRstartDate = [NSDate dateWithTimeIntervalSince1970:nowInter + delta];
        
    } else {
        DRstartDate = [NSDate dateWithTimeIntervalSince1970:oneTime.longLongValue / 1000 + delta];
    }
    
    // end
    NSDate *DRendDate;
    if (otherTime.length == 0) {
        NSDate *nowDate = [NSDate date];
        NSTimeInterval otherInter = nowDate.timeIntervalSince1970;
        DRendDate = [NSDate dateWithTimeIntervalSince1970:otherInter + delta];
    } else {
        DRendDate = [NSDate dateWithTimeIntervalSince1970:otherTime.longLongValue / 1000 + delta];
    }
    
    
    // 通过日历来比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:DRstartDate toDate:DRendDate options:0];
    
    // 获得某个时间的年月日时分秒
    
    double hour = 0;
    if (cmps.year == 0 && cmps.month == 0 && cmps.day == 0) {// 同一天
        
        if (cmps.hour == 0) { // 同一小时
            hour = cmps.minute / 60.0 + cmps.second / 60.0 / 60.0;
            
        } else {
            hour = cmps.hour;
        }
    }
    
    return hour; // 如果为负数 说明当前时间比开始时间晚， 如果为正数，说明当前时间比开始时间早
    
}


@end
