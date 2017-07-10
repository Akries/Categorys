//
//  UIBarButtonItem+Extension.m
//  XiYuWang
//
//  Created by akries on 16/1/7.
//  Copyright © 2016年 akries. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


/**
 *  NavBar按钮定义
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (UIBarButtonItem *)itemInitWithImageName:(NSString *)imageName withTitle:(NSString *)title  highImageName:(NSString *)highImageName withHighTitle:(NSString *)highTitle target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //获取标题文字的size
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:Font(15)}];
    //! 这里需要根据内容大小来调整宽度
    button.frame = CGRectMake(0, 8, size.width <= 10 ? 50 : size.width + 20, 32);
    //button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = Font(15);
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (imageName) {
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (highImageName) {
        
        [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //        button.layer.cornerRadius = 5;
    //        button.layer.borderColor =[UIColor lightGrayColor].CGColor;
    //        button.layer.borderWidth =0.5;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName withTitle:(NSString *)title  highImageName:(NSString *)highImageName withHighTitle:(NSString *)highTitle target:(id)target action:(SEL)action
{
    return [[self alloc] itemInitWithImageName:imageName withTitle:title highImageName:highImageName withHighTitle:highTitle target:target action:action];
}


@end
