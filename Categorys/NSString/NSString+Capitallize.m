//
//  NSString+Capitallize.m
//  通讯录2
//
//  Created by dllo on 15/11/7.
//  Copyright (c) 2015年 JEH. All rights reserved.
//

#import "NSString+Capitallize.h"

@implementation NSString (Capitallize)

//将汉字转换为拼音
- (NSString *)pinyinOfName {
    NSMutableString * name = [[NSMutableString alloc] initWithString:self ];
    CFRange range = CFRangeMake(0, self.length);
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    return name;
}

//汉字转换为拼音后，返回大写的首字母
- (NSString *)capitalizeOfName {
    NSMutableString *capitallize = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];
    CFRange range = CFRangeMake(0, 1);
    if (!CFStringTransform((__bridge CFMutableStringRef) capitallize, &range, kCFStringTransformMandarinLatin, NO) || !CFStringTransform((__bridge CFMutableStringRef) capitallize, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    NSString *result = [capitallize substringWithRange:NSMakeRange(0, 1)];
    NSString *linguistics  = [result uppercaseString];
    return linguistics;
}

@end
