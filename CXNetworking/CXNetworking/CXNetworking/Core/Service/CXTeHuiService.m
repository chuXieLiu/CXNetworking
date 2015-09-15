//
//  CXTeHuiService.m
//  CXNetworking
//
//  Created by c_xie on 15/9/10.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXTeHuiService.h"

static NSString * const kTeHuiTestApiBaseURL = @"http://frontend.t.csq.im:8080/";
static NSString * const kTeHuiProduceApiBaseURL =  @"http://api.csq.im:8080/";

@implementation CXTeHuiService

@synthesize testApiBaseURL = _testApiBaseURL;
@synthesize productApiBaseURL = _productApiBaseURL;

- (NSString *)testApiBaseURL
{
    return kTeHuiTestApiBaseURL;
}

- (NSString *)productApiBaseURL
{
    return kTeHuiProduceApiBaseURL;
}

@end
