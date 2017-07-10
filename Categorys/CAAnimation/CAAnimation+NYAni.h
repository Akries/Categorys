//
//  CAAnimation+NYAni.h
//  XiYuWang
//
//  Created by Akries on 16/5/31.
//  Copyright © 2016年 akries. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


typedef NS_ENUM(NSUInteger, NYAxis)
{
    NYAxisX = 0,
    NYAxisY,
    NYAxisZ
};

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@interface CAAnimation (NYAni)
/**
 *  breathing forever
 *
 *  @param time duritaion, from clear to fully seen
 *
 *  @return animation obj
 */
+(CABasicAnimation *)opacityForever_Animation:(float)time;

/**
 *  breathing with fixed repeated times
 *
 *  @param repeatTimes times
 *  @param time        duritaion, from clear to fully seen
 *
 *  @return animation obj
 */
+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;

/**
 *  //rotate
 *
 *  @param dur         duration
 *  @param degree      rotate degree in radian(弧度)
 *  @param axis        axis
 *  @param repeatCount repeat count
 *
 *  @return animation obj
 */
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(NYAxis)axis repeatCount:(int)repeatCount;


/**
 *  scale animation
 *
 *  @param fromScale   the original scale value, 1.0 by default
 *  @param toScale     target scale
 *  @param time        duration
 *  @param repeatTimes repeat counts
 *
 *  @return animaiton obj
 */
+(CABasicAnimation *)scaleFrom:(CGFloat)fromScale toScale:(CGFloat)toScale durTimes:(float)time rep:(float)repeatTimes;
/**
 *  shake
 *
 *  @param repeatTimes time
 *  @param time        duration
 *  @param obj         always be CALayer at present
 *  @return aniamtion obj
 */
+(CAKeyframeAnimation *)shake_AnimationRepeatTimes:(float)repeatTimes durTimes:(float)time forObj:(id)obj;

/**
 *  bounce
 *
 *  @param repeatTimes time
 *  @param time        duration
 *  @param obj         always be CALayer at present
 *  @return aniamtion obj
 */
+(CAKeyframeAnimation *)bounce_AnimationRepeatTimes:(float)repeatTimes durTimes:(float)time forObj:(id)obj;


@end
