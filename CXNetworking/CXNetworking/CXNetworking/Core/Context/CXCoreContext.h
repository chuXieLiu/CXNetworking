//
//  CXCoreContext.h
//  CXNetworking
//
//  Created by c_xie on 15/9/14.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCoreContext : NSObject

@property (nonatomic,copy,readonly) NSString *v;
@property (nonatomic,copy,readonly) NSString *t;
@property (nonatomic,copy,readonly) NSString *sign;
@property (nonatomic,copy,readonly) NSString *deviceid;
@property (nonatomic,copy,readonly) NSString *appid;
@property (nonatomic,copy,readonly) NSString *termcode;
@property (nonatomic,copy,readonly) NSString *uid;
@property (nonatomic,copy,readonly) NSString *user;
@property (nonatomic,copy,readonly) NSString *sid;
@property (nonatomic,copy,readonly) NSString *city;
@property (nonatomic,copy,readonly) NSString *poi;
@property (nonatomic,copy,readonly) NSString *role;

@end
