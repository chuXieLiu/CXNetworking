//
//  CXCommonParamsGenerater.m
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCommonParamsGenerater.h"
#import "CXCoreContext.h"

@implementation CXCommonParamsGenerater

+ (NSDictionary *)commonParamsDictionary
{
    CXCoreContext *context = [CXCoreContext shareManger];
    return @{
             @"v"        : context.v,
             @"t"        : context.t,
             @"deviceid" : context.deviceid,
             @"appid"    : context.appid,
             @"termcode" : context.termcode,
             @"uid"      : context.uid,
             @"user"     : context.user,
             @"sid"      : context.sid,
             @"city"     : context.city,
             @"poi"      : context.poi,
             @"role"     : context.role
             };
}

@end
