//
//  CXBaseAPIManager.h
//  CXNetworking
//
//  Created by c_xie on 15/9/16.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXNetworkingConst.h"
#import "CXCoreResponse.h"
@class CXBaseAPIManager;

UIKIT_EXTERN NSString * const KCXNetworkingManagerRequestIDKey;


/**
 *  继承CXBaseAPIManager必须实现的协议，用来配置网络连接
 */
@protocol CXAPIManager <NSObject>

@required
- (NSString *)methodName;                           // 接口方法
- (CXNetWorkingServiceType)serviceType;             // 接口类型
- (CXNetWorkingHTTPRequestType)requestType;         // 请求方式
@end


/**
 *  外部参数协议
 */
@protocol CXAPIManagerParamSource <NSObject>

@optional
- (NSDictionary *)paramForAPI:(CXBaseAPIManager *)manager;      // 外部提供附加参数
@end


/**
 *  访问网络回调
 */
@protocol CXAPIManagerCallBackDelegate <NSObject>

@required
- (void)APIMamagerDidSuccessCallBack:(CXBaseAPIManager *)manager;
- (void)APIManagerDidFailureCallBack:(CXBaseAPIManager *)manager;
@end


/**
 *  拦截器
 */
@protocol CXAPIManagerInterceptor <NSObject>

@optional
- (void)manager:(CXBaseAPIManager *)manager beforeCallBackSuccessedResponse:(CXCoreResponse *)response;
- (void)manager:(CXBaseAPIManager *)manager afterCallBackSuccessedResponse:(CXCoreResponse *)response;

- (void)manager:(CXBaseAPIManager *)manager beforeCallBackFailuredResponse:(CXCoreResponse *)response;
- (void)manager:(CXBaseAPIManager *)manager afterCallBackFailuredResponse:(CXCoreResponse *)response;

- (BOOL)manager:(CXBaseAPIManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(CXBaseAPIManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;
@end


/**
 *  参数，返回数据验证器
 */
@protocol CXAPIManagerValidator <NSObject>

@optional
- (BOOL)manager:(CXBaseAPIManager *)manager isCorrectWithParams:(NSDictionary *)params;
- (BOOL)manager:(CXBaseAPIManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
@end

/**
 *  对接口返回数据进行转换处理
 */
@protocol CXAPIManagerResponseDataReformer <NSObject>

@required
- (id)manager:(CXBaseAPIManager *)manager reformData:(id)data;
@end

/*
 * manager状态
 */
typedef NS_ENUM (NSUInteger, CXAPIManagerStatusType){
    CXAPIManagerStatusTypeDefault,              //没有产生过API请求。
    CXAPIManagerStatusTypeSuccess,              //API请求成功且返回数据正确
    CXAPIManagerStatusTypeResponseError,        //API请求成功但返回数据不正确
    CXAPIManagerStatusTypeParamsError,          //参数错误
    CXAPIManagerStatusTypeTimeout,              //请求超时
    CXAPIManagerStatusTypeNoNetWork             //网络不通
};


@interface CXBaseAPIManager : NSObject

@property (nonatomic,weak) NSObject<CXAPIManager> *child;                 // 配置
@property (nonatomic,weak) id<CXAPIManagerParamSource> paramSource;       // 参数
@property (nonatomic,weak) id<CXAPIManagerInterceptor> interceptor;       // 拦截
@property (nonatomic,weak) id<CXAPIManagerValidator> validator;           // 验证
@property (nonatomic,weak) id<CXAPIManagerCallBackDelegate> delegate;     // 回调

@property (nonatomic,assign,readonly) BOOL isLoading;
@property (nonatomic,assign,readonly) BOOL isReachable;
@property (nonatomic,assign,readonly) CXAPIManagerStatusType statusType;


- (NSNumber *)loadData;
- (void)cancelAllRequest;
- (void)cancelRequestWithID:(NSNumber *)requestID;
- (id)fetchDataWithReformer:(id<CXAPIManagerResponseDataReformer>)reformer;


// 需要调用super
- (void)beforeCallBackSuccessedResponse:(CXCoreResponse *)response;
- (void)afterCallBackSuccessedResponse:(CXCoreResponse *)response;

- (void)beforeCallBackFailuredResponse:(CXCoreResponse *)response;
- (void)afterCallBackFailuredResponse:(CXCoreResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;





@end
