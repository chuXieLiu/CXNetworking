//
//  CXCoreRequest.h
//  CXNetworking
//
//  Created by c_xie on 15/9/7.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CXNetWorkingServiceTypeDefault  // 默认service，-》默认的baseURL
} CXNetWorkingServiceType;

typedef enum : NSUInteger {
    CXNetWorkingHTTPMethodTypeGET,
    CXNetWorkingHTTPMethodTypePOST
} CXNetWorkingHTTPMethodType;

@interface CXCoreRequest : NSObject

+ (instancetype)shareManager;

/**
 *  生成request
 *
 *  @param serviceType service类型，可决定调用生产机还是测试机，使用哪个baseURL
 *  @param HTTPMethod  请求方式，如GET，POST
 *  @param methodName  接口方法，如app/init
 *  @param params      接口参数
 *
 *  @return NSURLRequest对象
 */
- (NSURLRequest *)generateRequestWithServiceType:(CXNetWorkingServiceType)serviceType HTTPMethod:(CXNetWorkingHTTPMethodType)HTTPMethod methodName:(NSString *)methodName params:(NSDictionary *)params;

@end
