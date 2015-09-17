//
//  CXUserDefaults.h
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - app 基本配置信息

UIKIT_EXTERN NSString * const kAppDeviceTokenStringKey;
UIKIT_EXTERN NSString * const kAppUidStringKey;
UIKIT_EXTERN NSString * const kAppUserStringKey;
UIKIT_EXTERN NSString * const kAppSidStringKey;
UIKIT_EXTERN NSString * const kAppCityStringKey;
UIKIT_EXTERN NSString * const kAppPoiStringkey;

@interface CXUserDefaults : NSObject

+ (void)setObject:(id)value forKey:(NSString *)key;
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)setFloat:(float)value forKey:(NSString *)key;
+ (void)setDouble:(double)value forKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key;
+ (NSArray *)arrayForKey:(NSString *)key;
+ (NSDictionary *)dictionaryForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;
+ (double)doubleForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;

@end
