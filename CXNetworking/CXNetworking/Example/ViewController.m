//
//  ViewController.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "ViewController.h"
#import "TeHuiAPIManager.h"


@interface ViewController ()
<
    CXAPIManagerInterceptor,
    CXAPIManagerCallBackDelegate
>

@property (nonatomic,strong) TeHuiAPIManager *api;

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
        return;
    }
    [self.api loadData];
    NSLog(@"manager isLoading = %@",isLoading ? @"YES" : @"NO");
}


#pragma mark - CXAPIManagerCallBackDelegate

/*
 CXAPIManagerStatusTypeDefault = 0,              //没有产生过API请求。
 CXAPIManagerStatusTypeSuccess,  = 1            //API请求成功且返回数据正确
 CXAPIManagerStatusTypeResponseError, = 2        //API请求成功但返回数据不正确
 CXAPIManagerStatusTypeParamsError, = 3         //参数错误
 CXAPIManagerStatusTypeTimeout, =4             //请求超时
 CXAPIManagerStatusTypeNoNetWork  =5           //网络不通
 */

- (void)APIMamagerDidSuccessCallBack:(CXBaseAPIManager *)manager
{
    NSLog(@"%s,statusType = %zd",__func__,manager.statusType);
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


@end
