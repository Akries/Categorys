//
//  UIImage+Extension.h
//  西域电商
//
//  Created by akries on 15/10/16.
//  Copyright © 2015年 Akries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  传入图片的名称,返回一张可拉伸不变形的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 可拉伸图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

/**
 *  用纯色合成一张图片
 *
 *  @param color 颜色
 *
 *  @return image
 */
+ (UIImage *)NYimageWithColor:(UIColor *)color;

/**
 *  旋转一张图片
 *
 *  @param image       图片
 *  @param orientation 旋转角度
 *
 *  @return 被旋转的图片
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
@end
