//
//  CXNetworkingConfiguration.h
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXURLResponse;

typedef void(^CXURLResponseCallBlock)(CXURLResponse *response);

typedef NS_ENUM(NSUInteger, CXURLResponseStautsType) {
    CXURLResponseStatusTypeSuccess,
    CXURLResponseStatusTypeTimeOut,
    CXURLResponseStatusTypeNoNetwork            // 超时以外的错误都是无网络
} ;




UIKIT_EXTERN NSTimeInterval kCXNetworkingTimeoutSeconds;





