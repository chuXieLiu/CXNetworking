//
//  CXCommonParamsGenerator.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCommonParamsGenerator.h"
#import "CXRequestContext.h"

@implementation CXCommonParamsGenerator

+ (NSDictionary *)commonParamsDictionary
{
    CXRequestContext *context = [CXRequestContext shareManager];
    return @{};
}

@end
