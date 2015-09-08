//
//  CXRequestGenerator.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXRequestGenerator.h"
#import "CXService.h"
#import "NSDictionary+CXNetworkingMethods.h"
#import "CXNetworkingConfiguration.h"
#import "AFNetworking.h"
#import "NSURLRequest+CXNetworkingMethods.h"

@interface CXRequestGenerator ()

@property (nonatomic,strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation CXRequestGenerator

+ (instancetype)shareManager
{
    static CXRequestGenerator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSURLRequest *)GETRequestWithParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    CXService *service = [[CXService alloc] init];
    NSString *URLString = [NSString stringWithFormat:@"%@%@?%@",service.apiBaseURL,methodName,[requestParams URLParamsString]];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:URLString parameters:nil error:NULL];
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)POSTRequestWithParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    CXService *service = [[CXService alloc] init];
    NSString *URLString = [NSString stringWithFormat:@"%@%@",service.apiBaseURL,methodName];
    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:URLString parameters:requestParams error:NULL];
    return request;
}


#pragma mark - lazy

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kCXNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}


















@end
