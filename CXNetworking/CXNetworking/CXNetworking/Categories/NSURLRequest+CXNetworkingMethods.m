//
//  NSURLRequest+CXNetworkingMethods.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "NSURLRequest+CXNetworkingMethods.h"
#import <objc/runtime.h>

@implementation NSURLRequest (CXNetworkingMethods)

static char CXNetworkingRequestParams;

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &CXNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &CXNetworkingRequestParams);
}

@end
