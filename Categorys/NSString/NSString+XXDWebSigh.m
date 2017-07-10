//
//  NSString+Extension.m
//  XXDNew
//
//  Created by Akries on 2016/10/28.
//  Copyright © 2016年 Ak. All rights reserved.
//

#import "NSString+XXDWebSigh.h"
#import <CommonCrypto/CommonDigest.h>


NSString *MD5SIGNSTRING = @"U2FsdGVkX1+f06tcUiFCLgkOwRVpBC4krKZ1ljPUh+B6GYdl";
@implementation NSString (XXDWebSigh)

- (NSString *)ThansformSigh:(NSMutableDictionary *)dic {
    NSString *sighStr = [self appandString:dic];
    sighStr = [sighStr stringByAppendingString:MD5SIGNSTRING];
    NSString *calcSign = [sighStr md5Mod16];
    return calcSign;
}

- (NSString *)appandString:(NSMutableDictionary *)dict {
    NSString *ret = @"";
    NSArray *mykeys = [dict allKeys];
    NSArray *notInArray = @[@"filename"];
    NSMutableArray *sortArray = [NSMutableArray arrayWithArray:mykeys];
    [sortArray removeObjectsInArray:notInArray];
    NSArray *sortedArray = [sortArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSInteger count = sortedArray.count;
    NSString *retString = nil;
//    NSArray *sortedkeys = [mykeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    for ( int i = 0; i < count; i++) {
        if ([dict[[sortedArray objectAtIndex:i]] isKindOfClass:[NSString class]]) {
            ret = dict[[sortedArray objectAtIndex:i]];
        }else {
            ret = [dict[[sortedArray objectAtIndex:i]] stringValue];
        }
        if (!retString) {
            retString = ret;
        }
        else {
            retString = [retString stringByAppendingString:ret];
        }
    }
    return retString;
}

- (NSString *)ThansformSigh:(NSMutableDictionary *)dic SignString:(NSString *)signStr {
    NSString *sighStr = [self appandString:dic];
    sighStr = [sighStr stringByAppendingString:signStr];
    NSString *calcSign = [sighStr md5Hash];
    return calcSign;
}

- (NSString*)md5Hash {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], [data length], result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

@end
