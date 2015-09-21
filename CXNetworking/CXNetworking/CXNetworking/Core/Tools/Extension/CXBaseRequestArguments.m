//
//  CXBaseRequestArguments.m
//  CXNetworking
//
//  Created by c_xie on 15/9/21.
//  Copyright © 2015年 c_xie. All rights reserved.
//

#import "CXBaseRequestArguments.h"
#import "NSDictionary+Request.h"
#import "CXCommonParamsGenerater.h"
#import "CXSignatureGenerater.h"
#import "CXServiceFactory.h"
#import "CXCoreService.h"
#import <objc/runtime.h>

@interface CXBaseRequestArguments ()


@end

@implementation CXBaseRequestArguments

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(CXRequestArgumentsProtocol)]) {
            self.child = (NSObject<CXRequestArgumentsProtocol> *)self;
        } else {
            NSAssert(NO, @"必须遵守CXRequestArgumentsProtocol协议");
        }
    }
    return self;
}

#pragma mark - public method

- (NSString *)generateURLString
{
    NSString *paramsString = [self paramsString];
    NSString *methodName = [self.child methodName];
    NSString *sign = [CXSignatureGenerater signatureWithURLParamsString:paramsString MethodName:methodName];
    CXCoreService *service = [[CXServiceFactory shareManager] serviceWithNetWorkingServiceType:[self.child serviceType]];
    return [NSString stringWithFormat:@"%@%@?%@&sign=%@",service.apiBaseURL,methodName,paramsString,sign];
}


#pragma mark - private method

- (NSString *)paramsString
{
    NSMutableDictionary *otherParams = [self argumentsDictionay];
    NSDictionary *commonParams = [CXCommonParamsGenerater commonParamsDictionary];
    [otherParams addEntriesFromDictionary:commonParams];
    return [otherParams.copy paramsString];
}


- (NSMutableDictionary *)argumentsDictionay
{
    Class c = [self class];
    NSMutableDictionary *properiesDict = [NSMutableDictionary dictionary];
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivas = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivas[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            if (![key isEqualToString:@"_child"]) {
                key = [key substringFromIndex:1];
                id value = [self valueForKey:key];
                properiesDict[key] = value;
            }
        }
        free(ivas);
        c = [c superclass];
    }
    
    return properiesDict;
}









@end
