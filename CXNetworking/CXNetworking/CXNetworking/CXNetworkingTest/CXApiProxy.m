//
//  CXApiProxy.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXApiProxy.h"
#import "AFNetworking.h"
#import "CXURLResponse.h"
#import "CXNetworkingConfiguration.h"
#import "CXRequestGenerator.h"

#define CXNetworkingBaseURL nil

@interface CXApiProxy ()

@property (nonatomic,assign) NSNumber *requestID;
@property (nonatomic,strong) AFHTTPRequestOperationManager *operationManager;
@property (nonatomic,strong) NSMutableDictionary *operationCollection;

@end

@implementation CXApiProxy

- (instancetype)init
{
    if (self = [super init]) {
        _requestID = 0l;
    }
    return self;
}

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static CXApiProxy *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSNumber *)GETWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(CXURLResponseCallBlock)success failure:(CXURLResponseCallBlock)failure
{
    NSURLRequest *request = [[CXRequestGenerator shareManager] GETRequestWithParams:params methodName:methodName];
    NSNumber *requestID = [self invokeNetworkingAPIWithRequest:request success:success failure:failure];
    return requestID;
}

- (NSNumber *)POSTWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(CXURLResponseCallBlock)success failure:(CXURLResponseCallBlock)failure
{
    NSURLRequest *request = [[CXRequestGenerator shareManager] POSTRequestWithParams:params methodName:methodName];
    NSNumber *requestID = [self invokeNetworkingAPIWithRequest:request success:success failure:failure];
    return requestID;
}

#pragma mark - private method

- (NSNumber *)invokeNetworkingAPIWithRequest:(NSURLRequest *)request success:(CXURLResponseCallBlock)success failure:(CXURLResponseCallBlock)failure
{
    NSNumber *requestID = [self generateRequestID];
    
    AFHTTPRequestOperation *requestOperation = [self.operationManager HTTPRequestOperationWithRequest:request success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
        
        AFHTTPRequestOperation *storeOperation = self.operationCollection[requestID];
        if (storeOperation == nil) {
            return;     // operation被取消
        } else {
            [self.operationCollection removeObjectForKey:requestID];
        }
        
        CXURLResponse *response = [[CXURLResponse alloc] initWithRequestID:requestID
                                                                   request:operation.request
                                                            responseString:operation.responseString
                                                              responseData:operation.responseData
                                                            responseStatus:CXURLResponseStatusTypeSuccess];
        if (success) {
            success(response);
        }
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        AFHTTPRequestOperation *storeOperation = self.operationCollection[requestID];
        if (storeOperation == nil) {
            return;     // operation被取消
        } else {
            [self.operationCollection removeObjectForKey:requestID];
        }
        CXURLResponse *response = [[CXURLResponse alloc] initWithRequestID:requestID
                                                                   request:request
                                                            responseString:operation.responseString
                                                              responseData:operation.responseData
                                                                     error:error];
        if (failure) {
            failure(response);
        }

    }];
    self.operationCollection[requestID] = requestOperation;
    [self.operationManager.operationQueue addOperation:requestOperation];
    return requestID;
}


- (NSNumber *)generateRequestID
{
    if (_requestID == nil) {
        _requestID = @(1);
    } else {
        _requestID = @((NSInteger)_requestID + 1);
    }
    return _requestID;
}


- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSOperation *operation = self.operationCollection[requestID];
    [operation cancel];
    [self.operationCollection removeObjectForKey:requestID];
}

- (void)cancelAllRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestID in requestIDList) {
        [self cancelRequestWithRequestID:requestID];
    }
}

#pragma mark - setter getter

- (AFHTTPRequestOperationManager *)operationManager
{
    if (_operationManager == nil) {
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:CXNetworkingBaseURL];
        _operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _operationManager;
}

- (NSMutableDictionary *)operationCollection
{
    if (_operationCollection == nil) {
        _operationCollection = [[NSMutableDictionary alloc] init];
    }
    return _operationCollection;
}


@end
