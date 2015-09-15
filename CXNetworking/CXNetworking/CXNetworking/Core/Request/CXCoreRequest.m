//
//  CXCoreRequest.m
//  CXNetworking
//
//  Created by c_xie on 15/9/7.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCoreRequest.h"
#import "AFNetworking.h"
#import "CXCoreService.h"
#import "CXServiceFactory.h"
#import "CXSignatureGenerater.h"
#import "CXCommonParamsGenerater.h"
#import "NSDictionary+Request.h"

static NSTimeInterval const kTimeoutSeconds = 30.0f;
static NSString * const kGETRequestMethod = @"GET";
static NSString * const kPOSTRequestMethod = @"POST";

@interface CXCoreRequest ()

@property (nonatomic,strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation CXCoreRequest

+ (instancetype)shareManager
{
    static CXCoreRequest *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (NSURLRequest *)generateRequestWithServiceType:(CXNetWorkingServiceType)serviceType HTTPMethod:(CXNetWorkingHTTPMethodType)HTTPMethod methodName:(NSString *)methodName params:(NSDictionary *)params
{
    if (HTTPMethod == CXNetWorkingHTTPMethodTypeGET) {
        CXCoreService *service = [[CXServiceFactory shareManager] serviceWithNetWorkingServiceType:serviceType];
        NSString *signature = [CXSignatureGenerater signatureWithSigParams:params MethodName:methodName];
        NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:params];
        [requestParams addEntriesFromDictionary:[CXCommonParamsGenerater commonParamsDictionary]];
        NSString *URLString = [NSString stringWithFormat:@"%@%@?sign=%@&%@",service.apiBaseURL,methodName,signature,[requestParams paramsString]];
        NSLog(@"URLString=%@",URLString);
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:kGETRequestMethod URLString:URLString parameters:nil error:NULL];
        return request.copy;
    } else if (HTTPMethod == CXNetWorkingHTTPMethodTypePOST) {
        
    }
    return nil;
}



#pragma mark - setter getter

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        _httpRequestSerializer.timeoutInterval = kTimeoutSeconds;
    }
    return _httpRequestSerializer;
}



@end
