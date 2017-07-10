//
//  NSObject+Ext.h
//  XiYuWang
//
//  Created by 李胜书 on 16/5/19.
//  Copyright © 2016年 Ehsy_Sanli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Ext)

+ (instancetype)objectInitWithDictionary:(NSDictionary *)data;
/************************************************************************
 *把字典赋值给当前实体类的属性
 *参数：字典
 *适用情况：当网络请求的数据的key与实体类的属性相同时可以通过此方法吧字典的Value
 *        赋值给实体类的属性
 ************************************************************************/
- (void)assginToPropertyWithDictionary: (NSDictionary *) data;

// obj->json
- (NSString *)objConvertToJsonStr;
// json->obj
- (id)jsonStrConvertToObj;

/// 包装部分<MJExtension>
/// 字典数据转模型数组
+ (NSMutableArray *)xxd_objArrFromKeyValues:(id)res;
/// 字典转模型
+ (instancetype)xxd_objFromKeyValue:(id)res;
/// 模型转字典
- (NSDictionary *)xxd_keyValues;
/// 模型数组转字典数组
+ (NSMutableArray *)xxd_keyValuesArrFromObjArr:(NSArray *)res;

@end
