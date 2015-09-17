//
//  CXBaseAPIManager.m
//  CXNetworking
//
//  Created by c_xie on 15/9/16.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXBaseAPIManager.h"
#import "CXCoreProxy.h"
#import "AFNetworking.h"

@interface CXBaseAPIManager ()

@property (nonatomic,assign,readwrite) BOOL isLoading;
@property (nonatomic,assign,readwrite) BOOL isReachable;
@property (nonatomic,assign,readwrite) CXAPIManagerStatusType statusType;
@property (nonatomic,strong) NSMutableArray *requestIDCollection;
@property (nonatomic,strong) id data;
@end

@implementation CXBaseAPIManager

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.paramSource = nil;       // 参数源可由外部提供
        self.interceptor = nil;       // 拦截器
        self.validator = nil;         // 外部拦截
        self.delegate = nil;          // 网络访问回调
        if ([self conformsToProtocol:@protocol(CXAPIManager)]) {
            self.child = (NSObject<CXAPIManager> *)self;     // 子类必须提供网络访问配置
        } else {
            NSAssert(NO, @"必须遵守CXAPIManager协议");
        }
        self.statusType = CXAPIManagerStatusTypeDefault;
    }
    return self;
}

#pragma mark - 访问网络请求数据

- (NSNumber *)loadData
{
    NSNumber *requestID = [self loadDataFromNetworking];
    return requestID;
}

#pragma mark - 取消所有的请求

- (void)cancelAllRequest
{
    for (NSNumber *requestID in self.requestIDCollection) {
        [self cancelRequestWithID:requestID];
    }
    [self.requestIDCollection removeAllObjects];
}

#pragma mark - 取消某个请求

- (void)cancelRequestWithID:(NSNumber *)requestID
{
    [[CXCoreProxy shareManager] cancelRequestWithID:requestID];
    [self.requestIDCollection removeObject:requestID];
}

#pragma mark - 获取处理过后的数据

- (id)fetchDataWithReformer:(id<CXAPIManagerResponseDataReformer>)reformer
{
    id data = nil;
    if (reformer && [reformer respondsToSelector:@selector(manager:reformData:)]) {
        data = [reformer manager:self reformData:self.data];
    } else {
        data = self.data;
    }
    return data;
}

#pragma mark - 访问网络成功回调之前

- (void)beforeCallBackSuccessedResponse:(CXCoreResponse *)response
{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforeCallBackSuccessedResponse:)]) {
        [self.interceptor manager:self beforeCallBackSuccessedResponse:response];
    }
}

#pragma mark - 访问网络成功回调之后

- (void)afterCallBackSuccessedResponse:(CXCoreResponse *)response
{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallBackSuccessedResponse:)]) {
        [self.interceptor manager:self afterCallBackSuccessedResponse:response];
    }
}

#pragma mark - 访问网络失败回调之前

- (void)beforeCallBackFailuredResponse:(CXCoreResponse *)response
{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforeCallBackFailuredResponse:)]) {
        [self.interceptor manager:self beforeCallBackFailuredResponse:response];
    }
}

#pragma mark - 访问网络失败回调之后

- (void)afterCallBackFailuredResponse:(CXCoreResponse *)response
{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallBackFailuredResponse:)]) {
        [self.interceptor manager:self afterCallBackFailuredResponse:response];
    }
}

#pragma mark - 即将调用参数访问网络

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params
{
    // 父类提供了拦截方法，没有必要再让自己成为拦截器
    if (self.interceptor && self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
    } else {
        return YES;
    }
}

#pragma mark - 调用参数访问网络之后

- (void)afterCallingAPIWithParams:(NSDictionary *)params
{
    if (self.interceptor && self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}



#pragma mark - private method

- (NSNumber *)loadDataFromNetworking
{
    NSNumber *requestID = nil;
    NSDictionary *params = nil;
    if (self.paramSource != nil && [self.paramSource respondsToSelector:@selector(paramForAPI:)]) {
        params = [self.paramSource paramForAPI:self];
    }
    
    if (self.isReachable) {                                     // 网络是否可用
        if ([self shouldCallAPIWithParams:params]) {            // 是否允许参数调用
            if (self.validator && [self.validator respondsToSelector:@selector(manager:isCorrectWithParams:)]) {
                if ([self.validator manager:self isCorrectWithParams:params]) { // 参数验证是否通过
                    requestID = [self loadDataWithParams:params];
                } else {
                    [self failureOnCallingApi:nil statusType:CXAPIManagerStatusTypeParamsError];
                }
            } else {
                requestID = [self loadDataWithParams:params];
            }
        }
        
    } else {
        [self failureOnCallingApi:nil statusType:CXAPIManagerStatusTypeNoNetWork];
    }
    return requestID;
}


- (NSNumber *)loadDataWithParams:(NSDictionary *)params
{
    NSNumber *requestID = nil;
    NSString *method = [self.child methodName];
    CXNetWorkingServiceType serviceType = [self.child serviceType];
    CXNetWorkingHTTPRequestType requestType = [self.child requestType];
    if (requestType == CXNetWorkingHTTPRequestTypeGET) {
        requestID = [[CXCoreProxy shareManager] invokeGetNetworingWithServiceType:serviceType methodName:method params:params result:^(CXCoreResponse *response) {
            if (response.responseStatusType == CXCoreResponseStautsTypeSuccess) {
                
            } else {
                CXAPIManagerStatusType statusType;
                if (response.responseStatusType == CXCoreResponseStautsTypeTimeOut) {
                    statusType = CXAPIManagerStatusTypeTimeout;
                } else if (response.responseStatusType == CXCoreResponseStautsTypeNoNetwork) {
                    statusType = CXAPIManagerStatusTypeNoNetWork;
                }
                [self failureOnCallingApi:response statusType:statusType];
            }
        }];
    } else if (requestType == CXNetWorkingHTTPRequestTypePOST) {
        
    }
    return requestID;
}

- (void)successOnCallingApi:(CXCoreResponse *)response
{
    if (response.responseObject) {
        self.data = response.responseObject;
    } else {
        self.data = response.responseData;
    }
    [self removeRequestIDFromCollection:response.requestID];
    if ([self.validator manager:self isCorrectWithCallBackData:self.data]) {    // 返回数据验证
        self.statusType = CXAPIManagerStatusTypeSuccess;
        // 成功回调之前
        [self beforeCallBackSuccessedResponse:response];
        // 成功回调
        [self.delegate APIMamagerDidSuccessCallBack:self];
        // 成功回调之后
        [self afterCallBackSuccessedResponse:response];
    } else {
        [self failureOnCallingApi:response statusType:CXAPIManagerStatusTypeResponseError];
    }
    
}

- (void)failureOnCallingApi:(CXCoreResponse *)response statusType:(CXAPIManagerStatusType)statusType
{
    self.statusType = statusType;
    [self removeRequestIDFromCollection:response.requestID];
    // 失败回调之前
    [self beforeCallBackFailuredResponse:response];
    // 失败回调
    if (self.delegate && [self.delegate respondsToSelector:@selector(APIManagerDidFailureCallBack:)]) {
        [self.delegate APIManagerDidFailureCallBack:self];
    }
    // 失败回调之后
    [self afterCallBackFailuredResponse:response];
    
}

- (void)removeRequestIDFromCollection:(NSNumber *)requestID
{
    if ([self.requestIDCollection containsObject:requestID]) {
        [self.requestIDCollection removeObject:requestID];
    }
}


#pragma mark - getter

- (BOOL)isLoading
{
    if (self.requestIDCollection.count > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isReachable
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (NSMutableArray *)requestIDCollection
{
    if (_requestIDCollection == nil) {
        _requestIDCollection = [[NSMutableArray alloc] init];
    }
    return _requestIDCollection;
}

- (void)dealloc
{
    [self cancelAllRequest];
    if (self.requestIDCollection != nil) {
        self.requestIDCollection = nil;
    }
}

@end
