//
//  NSArray+Extension.m
//  XiYuWang
//
//  Created by 李胜书 on 16/5/19.
//  Copyright © 2016年 Ehsy_Sanli. All rights reserved.
//

#import "NSArray+Extension.h"
#import <objc/runtime.h>

@implementation NSArray (Extension)

/* 获取对象的所有属性名数组 */
- (NSArray *)getAllPropertiesNameArr:(__unsafe_unretained Class)class {
    u_int count;
    
    objc_property_t *properties  = class_copyPropertyList(class, &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++) {
        const char *propertyName = property_getName(properties[i]);
        [propertiesArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    free(properties);
    
    return propertiesArray;
}

- (NSArray *)getAllPropertiesTypeArr:(__unsafe_unretained Class)class {
    u_int count;
    
    objc_property_t *properties  = class_copyPropertyList(class, &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++) {
        objc_property_t property = properties[i];
        const char *propertyType = property_getAttributes(property);
        [propertiesArray addObject:[NSString stringWithUTF8String:propertyType]];
    }
    
    free(properties);
    
    return propertiesArray;
}

@end
