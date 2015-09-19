//
//  ViewController.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "ViewController.h"
#import "TeHuiAPIManager.h"
#import "TeHuiListReformer.h"


@interface ViewController ()
<
    CXAPIManagerInterceptor,
    CXAPIManagerCallBackDelegate
>

@property (nonatomic,strong) TeHuiAPIManager *api;
@property (nonatomic,strong) TeHuiListReformer *teHuiListReformer;
@property (nonatomic,copy) NSNumber *requestID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.api.interceptor = self;
    self.api.delegate = self;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    BOOL isLoading = self.api.isLoading;
    if (isLoading) {
        [self.api cancelRequestWithID:self.requestID];
        return;
    }
    self.requestID = [self.api loadData];
    NSLog(@"manager isLoading = %@",isLoading ? @"YES" : @"NO");
    
}


#pragma mark - CXAPIManagerCallBackDelegate
/*
typedef NS_ENUM (NSUInteger, CXAPIManagerStatusType){
    CXAPIManagerStatusTypeDefault,              //  没有产生过API请求。
    CXAPIManagerStatusTypeSuccess,              //  API请求成功且返回数据正确
    CXAPIManagerStatusTypeResponseError,        //  API请求成功但返回数据不正确
    CXAPIManagerStatusTypeParamsError,          //  参数错误
    CXAPIManagerStatusTypeTimeout,              //  请求超时
    CXAPIManagerStatusTypeOperationBeCancelled, //  操作被取消
    CXAPIManagerStatusTypeNoNetWork             //  网络不通
};*/

- (void)APIMamagerDidSuccessCallBack:(CXBaseAPIManager *)manager
{
    NSLog(@"%s,statusType = %zd",__func__,manager.statusType);
    NSDictionary *data = [manager fetchDataWithReformer:self.teHuiListReformer];
    NSLog(@"data=%@",data);
}

- (void)APIManagerDidFailureCallBack:(CXBaseAPIManager *)manager
{
    NSLog(@"%s,statusType = %zd",__func__,manager.statusType);
}

#pragma mark - CXAPIManagerInterceptor

- (void)manager:(CXBaseAPIManager *)manager beforeCallBackSuccessedResponse:(CXCoreResponse *)response
{
    NSLog(@"%s,requestID = %@,requestURL = %@",__func__,response.requestID,response.requestURL);
}

- (void)manager:(CXBaseAPIManager *)manager afterCallBackSuccessedResponse:(CXCoreResponse *)response
{
    NSLog(@"%s,requestID = %@,requestURL = %@",__func__,response.requestID,response.requestURL);;
}

- (void)manager:(CXBaseAPIManager *)manager beforeCallBackFailuredResponse:(CXCoreResponse *)response
{
    NSLog(@"%s,requestID = %@,requestURL = %@",__func__,response.requestID,response.requestURL);
}

- (void)manager:(CXBaseAPIManager *)manager afterCallBackFailuredResponse:(CXCoreResponse *)response
{
    NSLog(@"%s,requestID = %@,requestURL = %@",__func__,response.requestID,response.requestURL);
}

- (BOOL)manager:(CXBaseAPIManager *)manager shouldCallAPIWithParams:(NSDictionary *)params
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",params);
    return YES;
}

- (void)manager:(CXBaseAPIManager *)manager afterCallingAPIWithParams:(NSDictionary *)params
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",params);
}

#pragma mark - getter

- (TeHuiAPIManager *)api
{
    if (_api == nil) {
        _api = [[TeHuiAPIManager alloc] init];
    }
    return _api;
}

- (TeHuiListReformer *)teHuiListReformer
{
    if (_teHuiListReformer == nil) {
        _teHuiListReformer = [[TeHuiListReformer alloc] init];
    }
    return _teHuiListReformer;
}


@end
