//
//  UIBarButtonItem+TTRightBarButtonItemBack.m
//  XxdELoan
//
//  Created by tang on 2016/11/9.
//  Copyright © 2016年 李胜书. All rights reserved.
//

#import "UIBarButtonItem+TTRightBarButtonItemBack.h"

@implementation UIBarButtonItem (TTRightBarButtonItemBack)

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.frame = CGRectMake(0, 0, 25, 25);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (NSArray<UIBarButtonItem *> *)rightBarButtonItemsWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *rightBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBar setTitleColor:blueSelectColor forState:UIControlStateNormal];
    [rightBar setTitle:NSLocalizedString(title, @"") forState:UIControlStateNormal];
    rightBar.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightThin];
    rightBar.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBar.frame = CGRectMake(0, 0, [self titleWidth:title], 30);
    [rightBar addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBar];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -10;
    
    return @[spaceItem, rightItem];
}

+ (CGFloat)titleWidth:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0 weight:UIFontWeightThin]} context:nil];
    return rect.size.width;
}

@end
