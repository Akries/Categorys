//
//  UIImageView+RoundCorner.m
//  ResultContained
//
//  Created by 李胜书 on 15/7/17.
//  Copyright (c) 2015年 李胜书. All rights reserved.
//

#import "UIView+RoundCorner.h"

@implementation UIView (RoundCorner)

- (void)imageWithRound{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height/2;
}

- (void)imageWithRound:(BOOL)whiteCorner{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height/2;
    if (whiteCorner) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

- (void)imagewithColor:(UIColor *)cornerColor CornerWidth:(float)cornerWidth{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.borderWidth = cornerWidth;
    self.layer.borderColor = cornerColor.CGColor;
}

- (void)viewWithRadis:(float)radisCorner{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radisCorner];
}

/// 部分圆角
- (void)tt_addRoundedCorners:(UIRectCorner)corners
                   withRadii:(CGSize)radii {
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1, 0, self.bounds.size.width - 2, self.bounds.size.height)
                                                    byRoundingCorners:corners
                                                          cornerRadii:radii];
    
    CAShapeLayer *shapelayer = [[CAShapeLayer alloc] init];
    shapelayer.path = roundPath.CGPath;
    shapelayer.frame = self.bounds;
    shapelayer.strokeColor = [UIColor redColor].CGColor;
    shapelayer.lineCap = kCALineCapRound;
    self.layer.mask = shapelayer;
}


// 参考
- (void)tt_shadowWithBezierPathWithCornerRadius:(CGFloat)radius {
    [self tt_shadowWithBezierPathWithCornerRadius:radius shadowWidth:5.f];
}

- (void)tt_shadowWithBezierPathWithCornerRadius:(CGFloat)radius
                                    shadowWidth:(CGFloat)shadowWidth {
    [self tt_shadowWithBezierPathWithCornerRadius:radius
                                      shadowWidth:shadowWidth
                                      shadowColor:RGBA_Color(155, 155, 155, 0.32)];
}

- (void)tt_shadowWithBezierPathWithCornerRadius:(CGFloat)radius
                                    shadowWidth:(CGFloat)shawWidth
                                    shadowColor:(UIColor *)color {
    
    self.layer.cornerRadius = radius;
    self.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = shawWidth == 0 ? 0 : 1;//阴影透明度，默认0
    if (shawWidth == 0)  return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //路径阴影
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGFloat width        = self.bounds.size.width;
        CGFloat height       = self.bounds.size.height;
        CGFloat x            = self.bounds.origin.x;
        CGFloat y            = self.bounds.origin.y;
        CGFloat addWH        = shawWidth;
        
        CGPoint topLeft      = self.bounds.origin;
        CGPoint topMiddle    = CGPointMake(x + (width / 2), y - addWH);
        CGPoint topRight     = CGPointMake(x + width, y);
        
        CGPoint rightMiddle  = CGPointMake(x + width + addWH, y + (height / 2));
        
        CGPoint bottomRight  = CGPointMake(x + width, y + height);
        CGPoint bottomMiddle = CGPointMake(x + (width / 2), y + height + addWH);
        CGPoint bottomLeft   = CGPointMake(x, y + height);
        
        
        CGPoint leftMiddle   = CGPointMake(x - addWH, y + (height / 2));
        
        [path moveToPoint:topLeft];
        //添加四个二元曲线
        //右上
        [path addQuadCurveToPoint:topRight
                     controlPoint:topMiddle];
        //右下
        [path addQuadCurveToPoint:bottomRight
                     controlPoint:rightMiddle];
        //左下
        [path addQuadCurveToPoint:bottomLeft
                     controlPoint:bottomMiddle];
        //左
        [path addQuadCurveToPoint:topLeft
                     controlPoint:leftMiddle];
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置阴影路径
            self.layer.shadowPath = path.CGPath;
        });
    });
}



@end
