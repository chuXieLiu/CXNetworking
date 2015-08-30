//
//  CXURLResponse.h
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXNetworkingConfiguration.h"

@interface CXURLResponse : NSObject

@property (nonatomic,assign,readonly) CXURLResponseStautsType responseStatus;
@property (nonatomic,assign,readonly) NSNumber *requestID;
@property (nonatomic,copy,readonly) NSURLRequest *request;
@property (nonatomic,copy,readonly) NSString *responseString;
@property (nonatomic,copy,readonly) NSData *responseData;
@property (nonatomic,copy,readonly) id responeObject; // 已通过NSJSONSerialization序列化的数据
@property (nonatomic,copy,readonly) NSDictionary *requestParams;
@property (nonatomic,assign,readonly) BOOL isCache;

- (instancetype)initWithRequestID:(NSNumber *)requestID
                          request:(NSURLRequest *)request
                   responseString:(NSString *)responseString
                     responseData:(NSData *)responseData
                   responseStatus:(CXURLResponseStautsType)responseStatus;

- (instancetype)initWithRequestID:(NSNumber *)requestID
                          request:(NSURLRequest *)request
                   responseString:(NSString *)responseString
                     responseData:(NSData *)responseData
                            error:(NSError *)error;

@end
