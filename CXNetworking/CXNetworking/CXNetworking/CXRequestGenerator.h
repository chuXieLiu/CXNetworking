//
//  CXRequestGenerator.h
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXRequestGenerator : NSObject

+ (instancetype)shareManager;

- (NSURLRequest *)GETRequestWithParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

- (NSURLRequest *)POSTRequestWithParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

@end
