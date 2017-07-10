//
//  UIImageView+RedPointNumber.h
//  mytest
//
//  Created by 李胜书 on 15/7/22.
//  Copyright (c) 2015年 李胜书. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (RedPointNumber)

- (void)imageWithRedPoint;
- (void)imageWithRedNumber:(NSInteger)number;
- (void)imageWithRedNumberUp:(NSInteger)number;
- (void)imageRemoveRedNumber;
- (void)imageWithRedNumber:(NSInteger)number Radio:(float)radio FontFloat:(float)fontFloat;

@end
