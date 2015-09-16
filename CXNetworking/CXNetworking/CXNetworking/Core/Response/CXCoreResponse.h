//
//  CXCoreResponse.h
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 除了超时以外的错误，都以无网络处理
 */

typedef NS_ENUM(NSUInteger, CXCoreResponseStautsType) {
    CXCoreResponseStautsTypeSuccess,
    CXCoreResponseStautsTypeTimeOut,
    CXCoreResponseStautsTypeNoNetwork
} ;

@interface CXCoreResponse : NSObject

@property (nonatomic,assign,readonly) CXCoreResponseStautsType responseStatusType;
@property (nonatomic,copy,readonly) NSNumber *requestID;
@property (nonatomic,copy,readonly) NSString *requestURL;
@property (nonatomic,strong,readonly) NSDictionary *requestParams;
@property (nonatomic,copy,readonly) NSString *responseString;
@property (nonatomic,strong,readonly) NSData *responsedata;
@property (nonatomic,strong,readonly) id responseObject;

+ (instancetype)responseWithRequestID:(NSNumber *)requestID
                            requestURL:(NSString *)requestURL
                         requestParams:(NSDictionary *)requestParams
                        responseString:(NSString *)responseString
                          responsedata:(NSData *)responsedata
                        responseObject:(id)responseObject
                                 error:(NSError *)error;

@end
