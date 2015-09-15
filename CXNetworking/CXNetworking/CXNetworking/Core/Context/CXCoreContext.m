//
//  CXCoreContext.m
//  CXNetworking
//
//  Created by c_xie on 15/9/14.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCoreContext.h"

@interface CXCoreContext ()

@property (nonatomic,copy,readwrite) NSString *v;
@property (nonatomic,copy,readwrite) NSString *t;
@property (nonatomic,copy,readwrite) NSString *sign;
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


#pragma mark - setter getter

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



@end
