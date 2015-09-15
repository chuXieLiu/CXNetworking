//
//  CXServiceFactory.h
//  CXNetworking
//
//  Created by c_xie on 15/9/14.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXCoreService;
@protocol CXCoreServiceProtocol;

typedef enum : NSUInteger {
    CXNetWorkingServiceTypeTeHui,
    CXNetWorkingServiceTypeDefault  // 默认service，-》默认的baseURL
} CXNetWorkingServiceType;

@interface CXServiceFactory : NSObject

+ (instancetype)shareManager;

- (CXCoreService<CXCoreServiceProtocol> *)serviceWithNetWorkingServiceType:(CXNetWorkingServiceType)serviceType;


@end
