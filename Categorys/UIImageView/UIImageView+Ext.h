//
//  UIImageView+Ext.h
//  XXDNew
//
//  Created by tang on 2017/3/10.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Ext)

- (void)xxd_setImageWithUrlStr:(NSString *)urlStr;
- (void)xxd_setImageWithUrlStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;



@end
