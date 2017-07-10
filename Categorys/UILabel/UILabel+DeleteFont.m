//
//  UILabel+DeleteFont.m
//  XiYuWang
//
//  Created by 李胜书 on 16/3/10.
//  Copyright © 2016年 akries. All rights reserved.
//

#import "UILabel+DeleteFont.h"

@implementation UILabel (DeleteFont)

- (void)deleteFont {
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSStrikethroughStyleAttributeName:@1,NSStrikethroughColorAttributeName:[UIColor whiteColor]}];
    self.attributedText = attStr;
}

@end
