//
//  UIView+Animation.h
//  XXDNew
//
//  Created by tang on 2017/1/12.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RotateAnimationDirection) {
    RotateAnimationDirectionClockWise     = 1,  // 顺时针
    RotateAnimationDirectionAntiClockWise = -1, // 逆时针
};

@interface UIView (Animation)


/**
 旋转动画
 @param direction 方向
 @param duration 时间
 */
- (void)rotateAnimationWithDirection:(RotateAnimationDirection)direction
                            duration:(CFTimeInterval)duration;



/**
 平移动画
 @param fromePoint 起点
 @param toPoint 终点
 */
- (void)positionTransitionAnimationFrom:(CGPoint)fromePoint
                                toPoint:(CGPoint)toPoint;

/**
 抖动动画
 @param interval 间隔时间戳
 */
- (void)shakeAnimationWithInterval:(CGFloat)interval;

/**
 停止抖动
 */
- (void)stopShake;

@end
