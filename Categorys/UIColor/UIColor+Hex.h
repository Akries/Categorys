//
//  UIColor+Hex.h
//  EHSYBeta
//
//  Created by 李胜书 on 16/2/3.
//  Copyright © 2016年 EHSY_SanLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor(Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
