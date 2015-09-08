//
//  CXCoreProxy.m
//  CXNetworking
//
//  Created by c_xie on 15/9/6.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCoreProxy.h"
#import "AFNetworking.h"

@interface CXCoreProxy ()

@property (nonatomic,strong) AFHTTPRequestOperationManager *operationManager;
@property (nonatomic,strong) NSMutableDictionary *operationCollection;
@property (nonatomic,copy) NSNumber *requestID;


@end

@implementation CXCoreProxy

+ (instancetype)shareManager
{
    static CXCoreProxy *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSNumber *)getWithURLString:(NSString *)URLString
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    request.HTTPMethod = @"GET";
    return [self invokeNetworkingWithRequest:request];
}


- (NSNumber *)invokeNetworkingWithRequest:(NSURLRequest *)request
{
    NSNumber *requestID = [self generateRequestID];
    AFHTTPRequestOperation *requestOperation = [self.operationManager HTTPRequestOperationWithRequest:request success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
        AFHTTPRequestOperation *storeOperation = self.operationCollection[requestID];
        if (storeOperation == nil) { // being cacel
            return;
        } else {
            [self.operationCollection removeObjectForKey:requestID];
        }
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        AFHTTPRequestOperation *storeOperation = self.operationCollection[requestID];
        if (storeOperation == nil) { // being cacel
            return;
        } else {
            [self.operationCollection removeObjectForKey:requestID];
        }
    }];
    [self.operationCollection setObject:requestOperation forKey:requestID];
    [self.operationManager.operationQueue addOperation:requestOperation];// 开始执行操作
    return requestID;
}


#pragma mark - setter getter

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
