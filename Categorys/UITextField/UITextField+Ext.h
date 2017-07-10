//
//  UITextField+Ext.h
//  XXDNew
//
//  Created by tang on 2017/3/24.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Ext)

/**
 监听键盘
 @param changeBlock 
 */
- (void)observeKeyboardChangeFrame:(void(^)(CGRect frame))changeBlock referTo:(UIView *)referView;


/**
 键盘与输入框之间的间距  默认为10
 */
@property (nonatomic, assign) CGFloat offsetSpace;

@property (nonatomic, strong) UIFont *placeholderFont;



@end
