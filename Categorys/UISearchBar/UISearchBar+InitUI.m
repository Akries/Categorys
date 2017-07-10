//
//  UISearchBar+InitUI.m
//  XxdELoan
//
//  Created by 李胜书 on 16/10/31.
//  Copyright © 2016年 李胜书. All rights reserved.
//

#import "UISearchBar+InitUI.h"

@implementation UISearchBar (InitUI)

- (void)initSearchBarUI:(UIColor *)backColor {
//    self.layer.cornerRadius = 5.0f;
//    self.layer.masksToBounds = YES;
    self.barTintColor = backColor;
    [self setBackgroundImage:[UIImage new]];
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[obj subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UITextField class]]) {
                obj.layer.borderColor = [UIColor grayColor].CGColor;
                obj.layer.borderWidth = 0.5;
                [obj viewWithRadis:5.0];
            }
        }];
    }];
}

@end
