//
//  NSURLRequest+Extension.m
//  CXNetworking
//
//  Created by c_xie on 15/9/16.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "NSURLRequest+Extension.h"
#import <objc/runtime.h>

@implementation NSURLRequest (Extension)

static char RequestParamsKey;
- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &RequestParamsKey, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &RequestParamsKey);
}

static char requestURLKey;
- (void)setRequestURL:(NSString *)requestURL
{
    objc_setAssociatedObject(self, &requestURLKey, requestURL, OBJC_ASSOCIATION_COPY);
}

- (NSString *)requestURL
{
    return objc_getAssociatedObject(self, &requestURLKey);
}







@end
