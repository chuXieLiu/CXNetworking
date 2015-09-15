//
//  CXCoreService.h
//  CXNetworking
//
//  Created by c_xie on 15/9/8.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CXCoreServiceProtocol <NSObject>

@property (nonatomic,copy) NSString *testApiBaseURL;
@property (nonatomic,copy) NSString *productApiBaseURL;

@end

@interface CXCoreService : NSObject
@property (nonatomic,assign,readonly)  BOOL isTest;
@property (nonatomic,strong,readonly) NSString *apiBaseURL;
@property (nonatomic,weak,readonly)  NSObject<CXCoreServiceProtocol> *child;

@end
