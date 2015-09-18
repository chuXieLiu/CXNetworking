//
//  CXSignatureGenerater.m
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXSignatureGenerater.h"
#import "CXCoreContext.h"
#import "CXAppUtils.h"

static NSString * const kAppSignToken = @"1idj2in3Zk$09#d019i";

@implementation CXSignatureGenerater

+ (NSString *)signatureWithSigParams:(NSDictionary *)sigParams MethodName:(NSString *)methodName
{
    CXCoreContext *context = [CXCoreContext shareManger];
    NSString *signature = [CXAppUtils md5:[NSString stringWithFormat:@"%@%@%@%@",context.v,methodName, context.t, kAppSignToken]];
    return signature;
}

+ (NSString *)signatureWithURLParamsString:(NSString *)paramsString MethodName:(NSString *)methodName
{
    NSString *key = [NSString stringWithFormat:@"%@%@%@",methodName,paramsString,kAppSignToken];
    return [CXAppUtils md5:key];
}

@end
