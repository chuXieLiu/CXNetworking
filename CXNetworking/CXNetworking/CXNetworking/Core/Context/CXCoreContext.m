//
//  CXCoreContext.m
//  CXNetworking
//
//  Created by c_xie on 15/9/14.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCoreContext.h"
#import "CXUserDefaults.h"
#import "CXAppUtils.h"


@interface CXCoreContext ()

@property (nonatomic,copy,readwrite) NSString *v;
@property (nonatomic,copy,readwrite) NSString *t;
@property (nonatomic,copy,readwrite) NSString *appid;
@property (nonatomic,copy,readwrite) NSString *deviceid;
@property (nonatomic,copy,readwrite) NSString *termcode;
@property (nonatomic,copy,readwrite) NSString *uid;
@property (nonatomic,copy,readwrite) NSString *user;
@property (nonatomic,copy,readwrite) NSString *sid;
@property (nonatomic,copy,readwrite) NSString *city;
@property (nonatomic,copy,readwrite) NSString *poi;
@property (nonatomic,copy,readwrite) NSString *role;

@end

@implementation CXCoreContext

#pragma mark - public method

+ (instancetype)shareManger
{
    static CXCoreContext *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


#pragma mark - getter

- (NSString *)v
{
    if (_v == nil) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        _v = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    return _v;
}

- (NSString *)t
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f",timeStamp];
}

- (NSString *)appid
{
    if (_appid == nil) {
        _appid = @"e5761ee33441713bfcc062f2";
    }
    return _appid;
}

- (NSString *)deviceid
{
    if (_deviceid == nil) {
        NSString *deviceTokenDescription = [CXUserDefaults stringForKey:kAppDeviceTokenStringKey];
        NSString *temp = [deviceTokenDescription stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSMutableCharacterSet *set = [NSMutableCharacterSet whitespaceCharacterSet];
        [set addCharactersInString:@">"];
        [set addCharactersInString:@"<"];
        _deviceid = [temp stringByTrimmingCharactersInSet:set];
    }
    return _deviceid;
}

- (NSString *)termcode
{
    if (_termcode == nil) {
        _termcode = [CXAppUtils generateTermcode];
    }
    return _termcode;
}

- (NSString *)uid
{
    if (_uid == nil) {
        _uid = [CXUserDefaults stringForKey:kAppUidStringKey];
    }
    return _uid;
}

- (NSString *)user
{
    if (_user == nil) {
        _user = [CXUserDefaults stringForKey:kAppUserStringKey];
    }
    return _user;
}

- (NSString *)sid
{
    if (_sid == nil) {
        _sid = [CXUserDefaults stringForKey:kAppSidStringKey];
    }
    return _sid;
}

- (NSString *)city
{
    return [CXUserDefaults stringForKey:kAppCityStringKey];
}

- (NSString *)poi
{
    return [CXUserDefaults stringForKey:kAppPoiStringkey];
}

- (NSString *)role
{
    return @"normal";
}

@end
