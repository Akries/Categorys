//
//  NSString+Extension.h
//  XXDNew
//
//  Created by Akries on 2016/10/28.
//  Copyright © 2016年 Ak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (stringToDic)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 获取对象所有属性和属性内容
 */
- (NSDictionary *)getAllPropertiesAndVaules:(__unsafe_unretained Class)class;

/**
 获取类的属性名和类型

 @param klass 类的名称
 @return 返回对应的字典,属性名：属性类型
 */
- (NSDictionary *)classPropsFor:(__unsafe_unretained Class)klass;

@end
