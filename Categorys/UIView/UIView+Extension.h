//
//  UIBarButtonItem+Extension.h
//  XiYuWang
//
//  Created by akries on 16/1/7.
//  Copyright © 2016年 akries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

- (void)initBorderColor:(UIColor *)borderColor Width:(CGFloat)borderWidth;

@end
