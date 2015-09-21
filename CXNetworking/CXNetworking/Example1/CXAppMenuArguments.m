//
//  CXAppMenuArguments.m
//  CXNetworking
//
//  Created by c_xie on 15/9/21.
//  Copyright © 2015年 c_xie. All rights reserved.
//

#import "CXAppMenuArguments.h"

@implementation CXAppMenuArguments

- (NSString *)methodName
{
    return @"app/menu";
}
- (CXNetWorkingServiceType)serviceType
{
    return CXNetWorkingServiceTypeDefault;
}
- (CXNetWorkingHTTPRequestType)requestType
{
    return CXNetWorkingHTTPRequestTypeGET;
}

@end
