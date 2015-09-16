//
//  CXCoreProxy.m
//  CXNetworking
//
//  Created by c_xie on 15/9/6.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCoreProxy.h"
#import "AFNetworking.h"
#import "CXCoreResponse.h"
#import "NSURLRequest+Extension.h"


@interface CXCoreProxy ()

@property (nonatomic,strong) AFHTTPRequestOperationManager *operationManager;
@property (nonatomic,strong) NSMutableDictionary *operationCollection;
@property (nonatomic,copy) NSNumber *requestID;


@end

@implementation CXCoreProxy

#pragma mark - public method

+ (instancetype)shareManager
{
    static CXCoreProxy *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSNumber *)invokeGetNetworingWithServiceType:(CXNetWorkingServiceType)serviceType methodName:(NSString *)methodName params:(NSDictionary *)params result:(CXNetWorkingResultCallBlock)resultCallBlock
{
    NSURLRequest *request = [[CXCoreRequest shareManager] generateRequestWithServiceType:serviceType HTTPMethod:CXNetWorkingHTTPMethodTypeGET methodName:methodName params:params];
    return [self invokeNetworkingWithRequest:request result:resultCallBlock];
}

#pragma mark - private method

- (NSNumber *)invokeNetworkingWithRequest:(NSURLRequest *)request result:(CXNetWorkingResultCallBlock)resultCallBlock

{
    NSNumber *requestID = [self generateRequestID];
    AFHTTPRequestOperation *requestOperation = [self.operationManager HTTPRequestOperationWithRequest:request success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
        AFHTTPRequestOperation *storeOperation = self.operationCollection[requestID];
        if (storeOperation == nil) { // being cacel
            return;
        } else {
            [self.operationCollection removeObjectForKey:requestID];
        }
        NSURLRequest *request = operation.request;
        CXCoreResponse *response = [CXCoreResponse responseWithRequestID:requestID requestURL:request.requestURL requestParams:request.requestParams responseString:operation.responseString responsedata:response.responsedata responseObject:responseObject error:nil];
        if (resultCallBlock) {
            resultCallBlock(response);
        }
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        AFHTTPRequestOperation *storeOperation = self.operationCollection[requestID];
        if (storeOperation == nil) { // being cacel
            return;
        } else {
            [self.operationCollection removeObjectForKey:requestID];
        }
        NSURLRequest *request = operation.request;
        CXCoreResponse *response = [CXCoreResponse responseWithRequestID:requestID requestURL:request.requestURL requestParams:request.requestParams responseString:operation.responseString responsedata:response.responsedata responseObject:operation.responseObject error:error];
        if (resultCallBlock) {
            resultCallBlock(response);
        }
    }];
    [self.operationCollection setObject:requestOperation forKey:requestID];
    [self.operationManager.operationQueue addOperation:requestOperation];// 开始执行操作
    return requestID;
}


- (void)cancelRequestWithID:(NSNumber *)requestID
{
    NSOperation *operation = self.operationCollection[requestID];
    if (operation == nil) {
        return;
    }
    [operation cancel];
    [self.operationCollection removeObjectForKey:operation];
}


#pragma mark - getter

- (AFHTTPRequestOperationManager *)operationManager
{
    if (_operationManager == nil) {
        _operationManager = [AFHTTPRequestOperationManager manager];
        _operationManager.responseSerializer =  [AFJSONResponseSerializer serializer];
        _operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html" , nil];;
       
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

- (NSNumber *)generateRequestID
{
    if (_requestID == nil) {
        _requestID = @(1);
    } else {
        if ([_requestID integerValue] == NSIntegerMax) {
            _requestID = @(1);
        } else {
            _requestID = @((NSInteger)_requestID + 1);
        }
    }
    return _requestID;
}






@end
