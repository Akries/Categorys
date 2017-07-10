//
//  UIBarButtonItem+TTRightBarButtonItemBack.h
//  XxdELoan
//
//  Created by tang on 2016/11/9.
//  Copyright © 2016年 李胜书. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TTRightBarButtonItemBack)

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (NSArray <UIBarButtonItem *> *)rightBarButtonItemsWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
