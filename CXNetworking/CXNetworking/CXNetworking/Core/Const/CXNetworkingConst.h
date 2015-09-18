//
//  CXNetworkingConst.h
//  CXNetworking
//
//  Created by c_xie on 15/9/16.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//


/**
 serviceType
 */
typedef enum : NSUInteger {
    CXNetWorkingServiceTypeTeHui,
    CXNetWorkingServiceTypeDefault  // 默认service，->默认的baseURL
} CXNetWorkingServiceType;


/**
 methodType
 */
typedef enum : NSUInteger {
    CXNetWorkingHTTPRequestTypeGET,
    CXNetWorkingHTTPRequestTypePOST
} CXNetWorkingHTTPRequestType;