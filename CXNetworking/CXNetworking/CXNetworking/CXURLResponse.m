//
//  CXURLResponse.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXURLResponse.h"
#import "NSURLRequest+CXNetworkingMethods.h"

@interface CXURLResponse ()

@property (nonatomic,assign,readwrite) CXURLResponseStautsType responseStatus;
@property (nonatomic,assign,readwrite) NSNumber *requestID;
@property (nonatomic,copy,readwrite) NSURLRequest *request;
@property (nonatomic,copy,readwrite) NSDictionary *requestParams;
@property (nonatomic,copy,readwrite) NSString *responseString;
@property (nonatomic,copy,readwrite) NSData *responseData;
@property (nonatomic,copy,readwrite) id responeObject;
@property (nonatomic,assign,readwrite) BOOL isCache;

@end

@implementation CXURLResponse


- (instancetype)initWithRequestID:(NSNumber *)requestID
                          request:(NSURLRequest *)request
                   responseString:(NSString *)responseString
                     responseData:(NSData *)responseData
                   responseStatus:(CXURLResponseStautsType)responseStatus
{
    if (self = [super init]) {
        self.requestID = requestID;
        self.request = request;
        self.requestParams = request.requestParams;
        self.responseString = responseString;
        self.responseData = responseData;
        self.responeObject = [self reformResponseData:responseData];
        self.isCache = NO;
    }
    return self;
}

- (instancetype)initWithRequestID:(NSNumber *)requestID
                          request:(NSURLRequest *)request
                   responseString:(NSString *)responseString
                     responseData:(NSData *)responseData
                            error:(NSError *)error
{
    if (self = [super init]) {
        self.requestID = requestID;
        self.request = request;
        self.requestParams = request.requestParams;
        self.responseString = responseString;
        self.responseData = responseData;
        self.responeObject = [self reformResponseData:responseData];
        self.responseStatus = [self responseStatusWithError:error];
        self.isCache = NO;
    }
    return self;
}

#pragma mark - private methods

- (id)reformResponseData:(NSData *)responseData
{
    id tempObject;
    if (responseData) {
        tempObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
    } else {
        tempObject = nil;
    }
    return tempObject;
}

- (CXURLResponseStautsType)responseStatusWithError:(NSError *)error
{
    CXURLResponseStautsType status;
    if (error) {
        if (error.code == NSURLErrorTimedOut) {
            status = CXURLResponseStatusTypeTimeOut;
        } else {
            status = CXURLResponseStatusTypeNoNetwork;  // 出超时以外都以无网络处理
        }
    } else {
        status = CXURLResponseStatusTypeSuccess;
    }
    return status;
}



@end
