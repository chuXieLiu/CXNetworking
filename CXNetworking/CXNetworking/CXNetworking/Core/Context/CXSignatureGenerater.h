//
//  CXSignatureGenerater.h
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXSignatureGenerater : NSObject

+ (NSString *)signatureWithSigParams:(NSDictionary *)sigParams MethodName:(NSString *)methodName;

@end
