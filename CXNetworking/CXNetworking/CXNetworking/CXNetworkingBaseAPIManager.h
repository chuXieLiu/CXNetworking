//
//  CXNetworkingBaseAPIManager.h
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXNetworkingBaseAPIManager;

// 通过该key值在返回的参数列表中拿到requestID
extern NSString * const KCXNetworkingManagerRequestID;

// api 回调
@protocol CXNetworkingAPIManagerCallBackDelegate <NSObject>

@required
- (void)managerCallAPIDidSuccess:(CXNetworkingBaseAPIManager *)manager;
- (void)managerCallAPIDidFailed:(CXNetworkingBaseAPIManager *)manager;
@end

// 重新组装API数据对象
@protocol CXNetworkingAPIManagerCallBackDataReformer <NSObject>

@required
- (id)manager:(CXNetworkingBaseAPIManager *)manager reformData:(NSDictionary *)data;
@end

// 验证器，验证api返回的数据或调用api的参数是否正确
@protocol CXNetworkingAPIManagerVAlidator <NSObject>

@required
- (BOOL)manager:(CXNetworkingBaseAPIManager *)manager isCorrectWithCallBackDada:(NSDictionary *)data;
- (BOOL)manager:(CXNetworkingBaseAPIManager *)manager isCorrectWithParamsDada:(NSDictionary *)data;

@end

// 让manager能够获取调用api所需要的数据
@protocol CXNetworkingAPIManagerParamSourceDelegate <NSObject>

@required
- (NSDictionary *)paramsForApi:(CXNetworkingBaseAPIManager *)manager;

@end

/*
 当产品要求返回数据不正确或者为空的时候显示一套UI，请求超时和网络不通的时候显示另一套UI时，使用这个enum来决定使用哪种UI。
 你不应该在回调数据验证函数里面设置这些值，事实上，在任何派生的子类里面你都不应该自己设置manager的这个状态，baseManager已经帮你搞定了。
 强行修改manager的这个状态有可能会造成程序流程的改变，容易造成混乱。
 */
typedef NS_ENUM (NSUInteger, CXNetworkingAPIManagerErrorType){
    CXNetworkingAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    CXNetworkingAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    CXNetworkingAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    CXNetworkingAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    CXNetworkingAPIManagerErrorTypeTimeout,       //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    CXNetworkingAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, CXNetworkingAPIManagerRequestType){
    CXNetworkingAPIManagerRequestTypeGet,
    CXNetworkingAPIManagerRequestTypePost,
};

// CXNetworkingBaseAPIManager的派生类必须符合这些protocal
@protocol CXNetworkingAPIManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (CXNetworkingAPIManagerRequestType)requestType;

@optional
// 给api添加额外的参数
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
- (BOOL)shouldCache;

@end

// 拦截器
@protocol CXNetworkingAPIManagerInterceptor <NSObject>

- (BOOL)manager:(CXNetworkingBaseAPIManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(CXNetworkingBaseAPIManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;

@end


@interface CXNetworkingBaseAPIManager : NSObject

@property (weak,nonatomic) id<CXNetworkingAPIManagerCallBackDelegate> delegate;
@property (weak,nonatomic) id<CXNetworkingAPIManagerParamSourceDelegate> paramSource;
@property (weak,nonatomic) id<CXNetworkingAPIManagerVAlidator> validator;
@property (weak,nonatomic) id<CXNetworkingAPIManagerInterceptor> interceptor;
@property (weak,nonatomic) NSObject<CXNetworkingAPIManager> *child;

// baseManager是不会去设置errorMessage的，子类可能需要给VC提供错误信息
@property (nonatomic,copy,readonly) NSString *errorMessage;
@property (nonatomic,assign,readonly) CXNetworkingAPIManagerErrorType errorType;

@property (nonatomic,assign,readonly) BOOL isReachable;
@property (nonatomic,assign,readonly) BOOL isLoading;

- (id)fetchDataWithReformer:(id<CXNetworkingAPIManagerCallBackDataReformer>)reformer;

// 尽量使用loadData方法，该方法会通过param Source来获取参数，这使得参数的生成逻辑位于controller中的固定位置
- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestID:(NSInteger)requestID;

/*
 用于给继承的类做重载，在调用API之前额外添加一些参数,但不应该在这个函数里面修改已有的参数。
 子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
 RTAPIBaseManager会先调用这个函数，然后才会调用到 id<RTAPIManagerValidator> 中的 manager:isCorrectWithParamsData:
 所以这里返回的参数字典还是会被后面的验证函数去验证的。
 
 假设同一个翻页Manager，ManagerA的paramSource提供page_size=15参数，ManagerB的paramSource提供page_size=2参数
 如果在这个函数里面将page_size改成10，那么最终调用API的时候，page_size就变成10了。然而外面却觉察不到这一点，因此这个函数要慎用。
 
 这个函数的适用场景：
 当两类数据走的是同一个API时，为了避免不必要的判断，我们将这一个API当作两个API来处理。
 那么在传递参数要求不同的返回时，可以在这里给返回参数指定类型*/

- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
- (BOOL)shouldCache;


@end








