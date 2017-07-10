//
//  UIImageView+Ext.m
//  XXDNew
//
//  Created by tang on 2017/3/10.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import "UIImageView+Ext.h"

@implementation UIImageView (Ext)

- (void)xxd_setImageWithUrlStr:(NSString *)urlStr {
    [self xxd_setImageWithUrlStr:urlStr placeholderImage:nil];
}

- (void)xxd_setImageWithUrlStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholder {
    if (urlStr.length == 0) { return; }
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder];
}

@end
