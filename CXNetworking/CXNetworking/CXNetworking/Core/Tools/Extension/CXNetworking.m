//
//  CXNetworking.m
//  CXNetworking
//
//  Created by c_xie on 15/9/20.
//  Copyright © 2015年 c_xie. All rights reserved.
//

#import "CXNetworking.h"

@implementation CXNetworking

+ (instancetype)shareManager
{
    static CXNetworking *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 15.0;
        instance = [[self alloc] initWithBaseURL:nil sessionConfiguration:config];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    });
    return instance;
}

@end
