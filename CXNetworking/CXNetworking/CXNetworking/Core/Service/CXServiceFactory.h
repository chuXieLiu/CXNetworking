//
//  CXServiceFactory.h
//  CXNetworking
//
//  Created by c_xie on 15/9/14.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXNetworkingConst.h"
@class CXCoreService;
@protocol CXCoreServiceProtocol;

@interface CXServiceFactory : NSObject

+ (instancetype)shareManager;

- (CXCoreService<CXCoreServiceProtocol> *)serviceWithNetWorkingServiceType:(CXNetWorkingServiceType)serviceType;


@end
