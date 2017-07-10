//
//  NSArray+Extension.h
//  XiYuWang
//
//  Created by 李胜书 on 16/5/19.
//  Copyright © 2016年 Ehsy_Sanli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/**
 获取类的属性名数组

 @param class 类的名字
 @return 返回类的属性名数组
 */
- (NSArray *)getAllPropertiesNameArr:(__unsafe_unretained Class)class;

/**
 获取类的属性的类型数组

 @param class 类的名字
 @return 返回类的属性的类型的数组
 */
- (NSArray *)getAllPropertiesTypeArr:(__unsafe_unretained Class)class;

@end
