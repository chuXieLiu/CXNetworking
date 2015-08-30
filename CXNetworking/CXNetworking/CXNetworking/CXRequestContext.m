//
//  CXRequestContext.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXRequestContext.h"
#import "AFNetworkReachabilityManager.h"

@interface CXRequestContext ()

@property (nonatomic,copy,readwrite) NSString *v;
@property (nonatomic,copy,readwrite) NSString *t;
@property (nonatomic,copy,readwrite) NSString *sign;
@property (nonatomic,copy,readwrite) NSString *deviceid;
@property (nonatomic,copy,readwrite) NSString *appid;
@property (nonatomic,copy,readwrite) NSString *termcode;
@property (nonatomic,copy,readwrite) NSString *uid;
@property (nonatomic,copy,readwrite) NSString *user;
@property (nonatomic,copy,readwrite) NSString *sid;
@property (nonatomic,copy,readwrite) NSString *city;
@property (nonatomic,copy,readwrite) NSString *poi;
@property (nonatomic,copy,readwrite) NSString *role;

@end

@implementation CXRequestContext

+ (instancetype)shareManager
{
    static CXRequestContext *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}



















@end
