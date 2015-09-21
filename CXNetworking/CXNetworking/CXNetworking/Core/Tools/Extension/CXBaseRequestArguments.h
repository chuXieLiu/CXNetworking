//
//  CXBaseRequestArguments.h
//  CXNetworking
//
//  Created by c_xie on 15/9/21.
//  Copyright © 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXNetworkingConst.h"

@protocol CXRequestArgumentsProtocol <NSObject>

@required
- (NSString *)methodName;                           // 接口方法
- (CXNetWorkingServiceType)serviceType;             // 接口类型
- (CXNetWorkingHTTPRequestType)requestType;         // 请求方式

@end


@interface CXBaseRequestArguments : NSObject

@property (nonatomic,weak) NSObject<CXRequestArgumentsProtocol> *child;

@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *size;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *order;

- (NSString *)generateURLString;

@end








