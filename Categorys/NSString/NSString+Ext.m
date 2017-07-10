//
//  NSString+Ext.m
//  XiYuWang
//
//  Created by 李胜书 on 16/6/20.
//  Copyright © 2016年 Ehsy_Sanli. All rights reserved.
//

#import "NSString+Ext.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Ext)

- (NSString *)transformToPinyin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
}

- (BOOL)isAllEngNumAndSpecialSign {
    NSString *regularString = @"^[A-Za-z0-9\\p{Z}\\p{P}]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularString];
    return [predicate evaluateWithObject:self];
}

//md5 32位 加密 （小写）
- (NSString *)md5Mod32 {
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
             result[12],result[13],result[14],result[15]] lowercaseString];
}

///md5 16位加密 （大写）
- (NSString *)md5Mod16Big {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr),result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

///md5 16位加密 （小写）
- (NSString *)md5Mod16 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr),result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)notNullString {
    NSString *str = self;
    if ([str isEqual:[NSNull null]] || ![str isKindOfClass:[NSString class]] || !str || [str isEqualToString:@"null"]) {
        str = @"";
    }
    return str;
}

- (NSString *)currentDate {
    NSDate *curDate = [NSDate date];
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"yyyyMM"];
    NSString *date = [dateFor stringFromDate:curDate];
    return date;
}

- (NSString *)currentDate:(NSString *)dateFormate {
    NSDate *curDate = [NSDate date];
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    [dateFor setDateFormat:dateFormate];
    NSString *date = [dateFor stringFromDate:curDate];
    return date;
}

- (NSString *)replaceString:(NSInteger)startIndex Length:(NSInteger)length String:(NSString *)replaceStr {
    if (self.length >= startIndex + length) {
        NSString *tempStr;
        NSString *tempReplaceStr = @"";
        for (int i = 0; i < length; i++) {
            tempReplaceStr = [tempReplaceStr stringByAppendingString:replaceStr];
        }
        tempStr = [self stringByReplacingCharactersInRange:NSMakeRange(startIndex, length) withString:tempReplaceStr];
        return tempStr;
    }
    return self;
}

- (NSString *)tt_replaceStart:(NSInteger)startIndex length:(NSInteger)length replaceStr:(NSString *)replaceStr perSpace:(NSInteger)perSpace {
    if (startIndex + length > self.length || perSpace >= self.length) {
        return self;
    }
    NSString *tempStr;
    NSString *tempReplaceStr = @"";
    for (NSUInteger i = 0; i < length; i++) {
        tempReplaceStr = [tempReplaceStr stringByAppendingString:replaceStr];
        tempStr = [self stringByReplacingCharactersInRange:NSMakeRange(startIndex, length) withString:tempReplaceStr];
    }
    
    if (perSpace <= length) {
        
    } else {
    }
    return tempStr;
    
    
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString *)ConvertStrToTime:(NSString *)timeStr TimeFormat:(NSString *)timeFormat {
    long long time = [timeStr longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:timeFormat];
    NSString *timeString = [formatter stringFromDate:d];
    return timeString;
}

- (BOOL)isIDCardIllegal {
    NSString *regularString = @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularString];
    return [predicate evaluateWithObject:self];
}

@end
