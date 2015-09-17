//
//  CXUserDefaults.m
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXUserDefaults.h"

NSString * const kAppDeviceTokenStringKey = @"kAppDeviceTokenStringKey";
NSString * const kAppUidStringKey = @"kAppUidStringKey";
NSString * const kAppUserStringKey = @"kAppUserStringKey";
NSString * const kAppSidStringKey = @"kAppSidStringKey";
NSString * const kAppCityStringKey = @"kAppCityStringKey";
NSString * const kAppPoiStringkey = @"kAppPoiStringkey";

@implementation CXUserDefaults

#pragma mark - setter
+ (void)setObject:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

+ (void)setFloat:(float)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
}

+ (void)setDouble:(double)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

#pragma mark - getter
+ (id)objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (NSString *)stringForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (NSArray *)arrayForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:key];
}

+ (NSDictionary *)dictionaryForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
}

+ (NSInteger)integerForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (float)floatForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

+ (double)doubleForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

+ (BOOL)boolForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
