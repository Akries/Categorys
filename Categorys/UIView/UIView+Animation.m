//
//  UIView+Animation.m
//  XXDNew
//
//  Created by tang on 2017/1/12.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import "UIView+Animation.h"
#import <objc/runtime.h>

#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI)
static void *timerKey = &timerKey;

@interface UIView ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation UIView (Animation)

// 旋转动画
- (void)rotateAnimationWithDirection:(RotateAnimationDirection)direction duration:(CFTimeInterval)duration {
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: (direction)*(M_PI * 2.0)];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAnimation forKey:nil];
}


// 平移动画
- (void)positionTransitionAnimationFrom:(CGPoint)fromePoint toPoint:(CGPoint)toPoint {
    CABasicAnimation *transitionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    transitionAnimation.duration = 1.5;
    transitionAnimation.fromValue = [NSValue valueWithCGPoint:fromePoint];
    transitionAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    transitionAnimation.removedOnCompletion = NO;
    transitionAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:transitionAnimation forKey:nil];
}


// 抖动动画
- (void)shakeAnimationWithInterval:(CGFloat)interval {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(shakeAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, timerKey, timer, OBJC_ASSOCIATION_RETAIN);
}

- (NSTimer *)timer {
    return objc_getAssociatedObject(self, timerKey);
}

// 抖动动画
- (void)shakeAnimation {
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    shakeAnimation.values = @[@(DEGREES_TO_RADIANS(-6)), @(DEGREES_TO_RADIANS(6)), @(DEGREES_TO_RADIANS(-6))];
    shakeAnimation.duration = 0.4;
    shakeAnimation.repeatCount = 2;
    shakeAnimation.autoreverses = YES;
    [self.layer addAnimation:shakeAnimation forKey:nil];
}
// 停止抖动
- (void)stopShake {
    [self.timer invalidate];
    self.timer = nil;
    [self.layer removeAllAnimations];
}


@end
