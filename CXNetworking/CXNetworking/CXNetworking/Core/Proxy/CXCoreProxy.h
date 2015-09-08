//
//  CXCoreProxy.h
//  CXNetworking
//
//  Created by c_xie on 15/9/6.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCoreProxy : NSObject

+ (instancetype)shareManager;
- (NSNumber *)getWithURLString:(NSString *)URLString;

@end
