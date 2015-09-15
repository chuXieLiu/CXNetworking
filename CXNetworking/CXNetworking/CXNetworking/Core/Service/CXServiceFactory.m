//
//  CXServiceFactory.m
//  CXNetworking
//
//  Created by c_xie on 15/9/14.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXServiceFactory.h"
#import "CXTeHuiService.h"
#import "CXDefaultService.h"

@interface CXServiceFactory ()

@property (nonatomic,strong) NSMutableDictionary *serviceCollection;

@end

@implementation CXServiceFactory

#pragma mark - public method

+ (instancetype)shareManager
{
    static CXServiceFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (CXCoreService<CXCoreServiceProtocol> *)serviceWithNetWorkingServiceType:(CXNetWorkingServiceType)serviceType
{
    if (self.serviceCollection[@(serviceType)] == nil) {
        self.serviceCollection[@(serviceType)] = [self generateServiceWithNetWorkingType:serviceType];
    }
    return self.serviceCollection[@(serviceType)];
}

#pragma mark - private methd

- (CXCoreService<CXCoreServiceProtocol> *)generateServiceWithNetWorkingType:(CXNetWorkingServiceType)serviceType
{
    if (serviceType == CXNetWorkingServiceTypeTeHui) {
        return [[CXTeHuiService alloc] init];
    } else {
        return [[CXDefaultService alloc] init];
    }
}


#pragma mark - setter getter

- (NSMutableDictionary *)serviceCollection
{
    if (_serviceCollection == nil) {
        _serviceCollection = [NSMutableDictionary dictionary];
    }
    return _serviceCollection;
}


@end
