//
//  TeHuiAPIManager.m
//  CXNetworking
//
//  Created by c_xie on 15/9/6.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "TeHuiAPIManager.h"

@interface TeHuiAPIManager ()<CXNetworkingAPIManager>

@end

@implementation TeHuiAPIManager

- (instancetype)init
{
    if (self = [super init]) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName
{
    return @"special/companylist";
}

- (CXNetworkingAPIManagerRequestType)requestType
{
    return CXNetworkingAPIManagerRequestTypeGet;
}

@end
