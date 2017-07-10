//
//  UIImageView+RedPointNumber.h
//  mytest
//
//  Created by 李胜书 on 15/7/22.
//  Copyright (c) 2015年 李胜书. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, STFakeAnimationDirection) {
    STFakeAnimationRight = 1,       ///< left to right
    STFakeAnimationLeft = -1,       ///< right to left
    STFakeAnimationDown = -2,       ///< up to down
    STFakeAnimationUp = 2           ///< down to up
};

// animation duration
static const NSTimeInterval STFakeLabelAnimationDuration = 0.7;

/**
 STFakeAnimation is an Objective-C category that adds fake 3D animation to UIlabel
 object class. It is intended to be simple, lightweight, and easy to use. 
 Animate just need a single line of code
 
 'st_startAnimationWithDirection: toText:' method animate with direction and new text
 */
@interface UILabel (STFakeAnimation)

- (void)st_startAnimationWithDirection:(STFakeAnimationDirection)direction toText:(NSString *)toText;

@end