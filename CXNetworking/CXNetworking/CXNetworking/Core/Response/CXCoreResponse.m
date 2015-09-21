//
//  CXCoreResponse.m
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCoreResponse.h"

@interface CXCoreResponse ()

@property (nonatomic,assign,readwrite) CXCoreResponseStautsType responseStatusType;
@property (nonatomic,copy,readwrite) NSNumber *requestID;
@property (nonatomic,copy,readwrite) NSString *requestURL;
@property (nonatomic,strong,readwrite) NSDictionary *requestParams;
@property (nonatomic,copy,readwrite) NSString *responseString;
@property (nonatomic,strong,readwrite) NSData *responseData;
@property (nonatomic,strong,readwrite) id responseObject;

@end

@implementation CXCoreResponse

+ (instancetype)responseWithRequestID:(NSNumber *)requestID
                            requestURL:(NSString *)requestURL
                         requestParams:(NSDictionary *)requestParams
                        responseString:(NSString *)responseString
                          responseData:(NSData *)responseData
                        responseObject:(id)responseObject
                                 error:(NSError *)error
{
    CXCoreResponse *response = [[self alloc] init];
    response.responseStatusType = [self statusTypeWithError:error];
    response.requestID = requestID;
    response.requestURL = requestURL;
    response.requestParams = requestParams;
    response.responseString = responseString;
    response.responseData = responseData;
    response.responseObject = responseObject;
    return response;
}

+ (CXCoreResponseStautsType)statusTypeWithError:(NSError *)error
{
    CXCoreResponseStautsType statusType;
    if (error == nil) { // NSURLErrorAppTransportSecurityRequiresSecureConnection
        statusType = CXCoreResponseStautsTypeSuccess;
    } else {
        if (error.code == NSURLErrorTimedOut) { // -1001
            statusType = CXCoreResponseStautsTypeTimeOut;
        } else if (error.code == NSURLErrorCancelled) {
            statusType = CXCoreResponseStautsTypeCancel;
        } else {
            statusType = CXCoreResponseStautsTypeNoNetwork;
        }
    }
    return statusType;
}
/*
kCFURLErrorCancelled = -999,操作被取消，
*/

@end
