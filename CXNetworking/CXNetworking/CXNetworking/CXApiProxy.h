//
//  CXApiProxy.h
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXNetworkingConfiguration.h"

@interface CXApiProxy : NSObject

+ (instancetype)shareManager;

- (NSNumber *)GETWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(CXURLResponseCallBlock)success failure:(CXURLResponseCallBlock)failure;
- (NSNumber *)POSTWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(CXURLResponseCallBlock)success failure:(CXURLResponseCallBlock)failure;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelAllRequestWithRequestIDList:(NSArray *)requestIDList;

@end























