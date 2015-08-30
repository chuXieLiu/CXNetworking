//
//  CXNetworkingBaseAPIManager.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXNetworkingBaseAPIManager.h"
#import "CXApiProxy.h"
#import "CXRequestContext.h"
#import "CXNetworkingConfiguration.h"
#import "CXURLResponse.h"

NSString *const KCXNetworkingManagerRequestID = @"KCXNetworkingManagerRequestID";

@interface CXNetworkingBaseAPIManager ()

@property (nonatomic,strong,readwrite) id fetchedRawData;
@property (nonatomic,copy,readwrite) NSString *errorMessage;
@property (nonatomic,assign) CXNetworkingAPIManagerErrorType errorType;
@property (nonatomic,strong) NSMutableArray *requestIDList;


@end

@implementation CXNetworkingBaseAPIManager

#pragma mark - life cycle

- (instancetype)init
{
    if (self = [super init]) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = CXNetworkingAPIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(CXNetworkingAPIManager)]) {
            self.child = (id<CXNetworkingAPIManager>)self;
        } else {
            NSAssert(NO, @"子类必须实现CXNetworkingAPIManager协议");
        }
        
    }
    return self;
}

- (void)dealloc
{
    [self cancelAllRequests];
    self.requestIDList = nil;
}

#pragma mark - public methods

- (void)cancelAllRequests
{
    [[CXApiProxy shareManager] cancelAllRequestWithRequestIDList:self.requestIDList];
    [self.requestIDList removeAllObjects];
}

- (void)cancelRequestWithRequestID:(NSInteger)requestID
{
    [self removeRequestIDFromRequestIDList:requestID];
    [[CXApiProxy shareManager] cancelRequestWithRequestID:@(requestID)];
}


- (id)fetchDataWithReformer:(id<CXNetworkingAPIManagerCallBackDataReformer>)reformer
{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - invoke api
- (NSInteger)loadData
{
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestID = [self loadDataWithParams:params];
    return requestID;
}

- (void)cleanData
{
    IMP childIMP = [self.child methodForSelector:@selector(cleanData)];
    IMP selfIMP = [self.child methodForSelector:@selector(cleanData)];
    if (childIMP == selfIMP) {
        self.fetchedRawData = nil;
        self.errorMessage = nil;
        self.errorType = CXNetworkingAPIManagerErrorTypeDefault;
    } else {
        if ([self.child respondsToSelector:@selector(cleanData)]) {
            [self.child cleanData];
        }
    }
}

// 如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
- (NSDictionary *)reformParams:(NSDictionary *)params
{
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self.child methodForSelector:@selector(reformParams:)];
    if (childIMP == selfIMP) {
        return params;
    } else {
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}


- (NSInteger)loadDataWithParams:(NSDictionary *)params
{
    NSInteger requestID = 0;
    NSDictionary *apiParams = [self reformParams:params];
    if ([self shouldInvokeAPIWithParams:apiParams]) { // 验证参数
        if ([self.validator manager:self isCorrectWithParamsDada:apiParams]) {
            // 先检查是否有缓存
            if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
                return 0;
            }
            
            // 网络请求
            if ([self isReachable]) {
                switch (self.child.requestType) {
                    case CXNetworkingAPIManagerRequestTypeGet:
                        requestID = [self invokeNetworkAPIWithParams:apiParams requestMethod:CXNetworkingAPIManagerRequestTypeGet methodName:self.child.methodName];
                        break;
                    case CXNetworkingAPIManagerRequestTypePost:
                        requestID = [self invokeNetworkAPIWithParams:apiParams requestMethod:CXNetworkingAPIManagerRequestTypePost methodName:self.child.methodName];
                        break;
                    default:
                        break;
                }
                NSMutableDictionary *params = [apiParams mutableCopy];
                params[KCXNetworkingManagerRequestID] = @(requestID);
                [self afterInvokeAPIWithParams:params];
                return requestID;
            } else {
                [self failedOnInvokeAPI:nil withErrorType:CXNetworkingAPIManagerErrorTypeNoNetWork];
                return requestID;
            }
        } else {
            [self failedOnInvokeAPI:nil withErrorType:CXNetworkingAPIManagerErrorTypeParamsError];
            return requestID;
        }
        
    }
    return requestID;
}




#pragma mark - private method

- (void)afterInvokeAPIWithParams:(NSDictionary *)params
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}

- (NSInteger)invokeNetworkAPIWithParams:(NSDictionary *)params requestMethod:(CXNetworkingAPIManagerRequestType)requestMethod methodName:(NSString *)methodName
{
    NSNumber *requestID;
    if (requestMethod == CXNetworkingAPIManagerRequestTypeGet) {
        requestID = [[CXApiProxy shareManager] GETWithParams:params methodName:methodName success:^(CXURLResponse *response) {
            [self successOnInvokeAPI:response];
        } failure:^(CXURLResponse *response) {
            [self failedOnInvokeAPI:response withErrorType:CXNetworkingAPIManagerErrorTypeDefault];
        }];
    } else if (requestMethod == CXNetworkingAPIManagerRequestTypePost) {
        requestID = [[CXApiProxy shareManager] POSTWithParams:params methodName:methodName success:^(CXURLResponse *response) {
            [self successOnInvokeAPI:response];
        } failure:^(CXURLResponse *response) {
            [self failedOnInvokeAPI:response withErrorType:CXNetworkingAPIManagerErrorTypeDefault];
        }];
    }
    return [requestID integerValue];
    
}

- (void)successOnInvokeAPI:(CXURLResponse *)response
{
    if (response.responeObject) {
        self.fetchedRawData = [response.responeObject copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
    [self removeRequestIDFromRequestIDList:[response.requestID integerValue]];
    if ([self.validator manager:self isCorrectWithCallBackDada:response.responeObject]) {
        if (!response.isCache) {
            // TODO
            // 进行数据缓存
        }
        // 数据已处理成功
        [self.delegate managerCallAPIDidSuccess:self];
    } else {
        [self failedOnInvokeAPI:response withErrorType:CXNetworkingAPIManagerErrorTypeNoContent];
    }
}

- (void)failedOnInvokeAPI:(CXURLResponse *)response withErrorType:(CXNetworkingAPIManagerErrorType)errorType
{
    self.errorType = errorType;
    [self removeRequestIDFromRequestIDList:[response.requestID integerValue]];
    [self.delegate managerCallAPIDidFailed:self];
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params
{
    // TODO
    return NO;
}

- (BOOL)shouldInvokeAPIWithParams:(NSDictionary *)params
{
    if (self != self.interceptor &&[self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
    } else {
        return YES;
    }
}

- (void)removeRequestIDFromRequestIDList:(NSInteger)requestID
{
    NSNumber *tempRequestID = nil;
    for (NSNumber *storeRequestID in self.requestIDList) {
        if ([storeRequestID integerValue] == requestID) {
            tempRequestID = storeRequestID;
        }
    }
    if (tempRequestID) {
        [self.requestIDList removeObject:tempRequestID];
    }
}

- (BOOL)isReachable
{
    BOOL isReachability = [CXRequestContext shareManager].isReachable;
    if (!isReachability) {
        self.errorType = CXNetworkingAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}


#pragma mark - setter getter

- (NSMutableArray *)requestIDList
{
    if (_requestIDList == nil) {
        _requestIDList = [[NSMutableArray alloc] init];
    }
    return _requestIDList;
}









@end
