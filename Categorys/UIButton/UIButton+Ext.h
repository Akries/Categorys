//
//  UIButton (UIButtonExt).h
//  EHSYBeta
//
//  Created by 李胜书 on 16/2/19.
//  Copyright © 2016年 EHSY_SanLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonLayoutType){
    initLayout,
    afterAnimationLayout
};

@interface UIButton (Ext)

- (void)centerImageAndTitle:(float)space;
- (void)centerImageAndTitle;
- (void)centerImageAndTitleWithLayoutType:(ButtonLayoutType)layoutType;

- (void)changeButtonImageAndLabel;

@end
