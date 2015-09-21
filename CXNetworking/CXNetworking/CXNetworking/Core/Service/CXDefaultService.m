//
//  CXDefaultService.m
//  CXNetworking
//
//  Created by c_xie on 15/9/10.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXDefaultService.h"

static NSString * const kDefaultTestApiBaseURL = @"http://frontend.t.csq.im/ci/";
static NSString * const kDefaultProduceApiBaseURL =  @"https://api.csq.im/ci/";

@implementation CXDefaultService

@synthesize testApiBaseURL = _testApiBaseURL;
@synthesize productApiBaseURL = _productApiBaseURL;


- (NSString *)testApiBaseURL
{
    return kDefaultTestApiBaseURL;
}


- (NSString *)productApiBaseURL
{
    return kDefaultProduceApiBaseURL;
}

@end
