//
//  CXCoreProxy.h
//  CXNetworking
//
//  Created by c_xie on 15/9/6.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXCoreRequest.h"
@class CXCoreResponse;

typedef void(^CXNetWorkingResultCallBlock)(CXCoreResponse *response);

@interface CXCoreProxy : NSObject

+ (instancetype)shareManager;
- (NSNumber *)invokeGetNetworingWithServiceType:(CXNetWorkingServiceType)serviceType methodName:(NSString *)methodName params:(NSDictionary *)params result:(CXNetWorkingResultCallBlock)resultCallBlock;
- (void)cancelRequestWithID:(NSNumber *)requestID;

@end
