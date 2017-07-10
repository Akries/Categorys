//
//  UIImageView+RoundCorner.h
//  ResultContained
//
//  Created by 李胜书 on 15/7/17.
//  Copyright (c) 2015年 李胜书. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (RoundCorner)

- (void)imageWithRound;
- (void)imageWithRound:(BOOL)whiteCorner;
//YES则显示白色边框，NO则不显示
- (void)viewWithRadis:(float)radisCorner;
- (void) imagewithColor:(UIColor *)cornerColor CornerWidth:(float)cornerWidth;


/**
 添加圆角 @tang

 @param corners 系统枚举 哪些方向需要添加
 @param radii 圆角大小 注意这里是CGSize
 */
- (void)tt_addRoundedCorners:(UIRectCorner)corners
                   withRadii:(CGSize)radii;


/**
 添加四周阴影

 @param radius 圆角大小
 */
- (void)tt_shadowWithBezierPathWithCornerRadius:(CGFloat)radius;

/**
 添加四周阴影

 @param radius 圆角大小
 @param offset 阴影宽度
 */
- (void)tt_shadowWithBezierPathWithCornerRadius:(CGFloat)radius
                                    shadowWidth:(CGFloat)width;

/**
 添加四周阴影
 
 @param radius 圆角大小
 @param offset 阴影宽度
 @param color  阴影颜色
 */
- (void)tt_shadowWithBezierPathWithCornerRadius:(CGFloat)radius
                                    shadowWidth:(CGFloat)shawWidth
                                    shadowColor:(UIColor *)color;


@end
