//
//  UIImage+Ext.h
//  XXDFinancialPlanner
//
//  Created by DD Li on 16/7/15.
//  Copyright © 2016年 DDstrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)setupQRImg:(NSString *)url Size:(CGFloat)size;

- (UIImage *)addIconToQRCodeImage:(UIImage *)icon withIconSize:(CGSize)iconSize;

- (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;

- (UIImage *)fixOrientation:(UIImage *)aImage;
@end
