//
//  UIBarButtonItem+Extension.h
//  XiYuWang
//
//  Created by akries on 16/1/7.
//  Copyright © 2016年 akries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName withTitle:(NSString *)title  highImageName:(NSString *)highImageName withHighTitle:(NSString *)highTitle target:(id)target action:(SEL)action;
@end
