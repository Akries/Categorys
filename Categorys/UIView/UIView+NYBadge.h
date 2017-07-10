//
//  UIView+NYBadge.h
//  XiYuWang
//
//  Created by Akries on 16/5/31.
//  Copyright © 2016年 akries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYBadgeProtocol.h"

@interface UIView (NYBadge)<NYBadgeProtocol>


@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIFont *badgeFont;		/* [UIFont boldSystemFontOfSize:9] default*/
@property (nonatomic, strong) UIColor *badgeBgColor;    /* 红色  default */
@property (nonatomic, strong) UIColor *badgeTextColor;  /* 白色  default */
@property (nonatomic, assign) CGRect badgeFrame;        /* 不建议修改 */

@property (nonatomic, assign) CGPoint  badgeCenterOffset;/* x为- 横向偏移  y为- 上下偏移量 */

@property (nonatomic, assign) NYBadgeAnimType aniType;   /* 不是显示badge动画效果 */

@property (nonatomic, assign) NSInteger badgeMaximumBadgeNumber; /*最大显示99 以后就是99+ */

/**
 *  显示默认小红点
 */
- (void)showNYBadge;

/**
 *  自定义 badge
 *
 *  @param style   类型 点,数字或是洋洋大帅哥这样的string
 *  @param value   具体数
 *  @param aniType 动画效果
 */
- (void)showNYBadgeWithStyle:(NYBadgeStyle)style
                       value:(NSInteger)value
               animationType:(NYBadgeAnimType)aniType;


/**
 *  clear badge
 */
- (void)clearBadge;



@end
