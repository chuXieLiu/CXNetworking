//
//  TeHuiAPIManager.m
//  CXNetworking
//
//  Created by c_xie on 15/9/17.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "TeHuiAPIManager.h"

@interface TeHuiAPIManager ()
<
    CXAPIManager,
    CXAPIManagerParamSource,
    CXAPIManagerValidator
>

@end

@implementation TeHuiAPIManager

- (instancetype)init
{
    if (self = [super init]) {
        self.paramSource = self;
        self.validator = self;
    }
    return self;
}

#pragma mark - CXAPIManager

- (NSString *)methodName
{
    return @"special/companylist";
}

- (CXNetWorkingServiceType)serviceType
{
    return CXNetWorkingServiceTypeTeHui;
}

- (CXNetWorkingHTTPRequestType)requestType
{
    return CXNetWorkingHTTPRequestTypeGET;
}

#pragma mark - CXAPIManagerParamSource

- (NSDictionary *)paramForAPI:(CXBaseAPIManager *)manager
{
    NSLog(@"%s",__func__);
    return @{
             @"company_id" : @"",
             @"type_id"    : @""
             };
}

#pragma mark - CXAPIManagerValidator

- (BOOL)manager:(CXBaseAPIManager *)manager isCorrectWithParams:(NSDictionary *)params
{
    NSLog(@"%s",__func__);
    NSLog(@"params=%@",params);
    return YES;
}

- (BOOL)manager:(CXBaseAPIManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    NSLog(@"%s",__func__);
    NSLog(@"data=%@",data);
    return NO;
}


- (void)beforeCallBackSuccessedResponse:(CXCoreResponse *)response
{
    [super beforeCallBackSuccessedResponse:response];
    NSLog(@"%s,requestID = %@,requestURL = %@",__func__,response.requestID,response.requestURL);
}
- (void)afterCallBackSuccessedResponse:(CXCoreResponse *)response
{
    [super afterCallBackSuccessedResponse:response];
    NSLog(@"%s,requestID = %@,requestURL = %@",__func__,response.requestID,response.requestURL);
}

- (void)beforeCallBackFailuredResponse:(CXCoreResponse *)response
{
    [super beforeCallBackFailuredResponse:response];
    NSLog(@"%s,requestID = %@,requestURL = %@",__func__,response.requestID,response.requestURL);
}
- (void)afterCallBackFailuredResponse:(CXCoreResponse *)response
{
    [super afterCallBackFailuredResponse:response];
    NSLog(@"%s,requestID = %@,requestURL = %@",__func__,response.requestID,response.requestURL);
}

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params
{
    [super shouldCallAPIWithParams:params];
    NSLog(@"%s,%@",__func__,params);
    return YES;
}
- (void)afterCallingAPIWithParams:(NSDictionary *)params
{
    [super afterCallingAPIWithParams:params];
    NSLog(@"%s,%@",__func__,params);
}















@end
