//
//  NSArray+CXNetworkingMethods.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "NSArray+CXNetworkingMethods.h"

@implementation NSArray (CXNetworkingMethods)

- (NSString *)paramsString
{
    NSMutableString *paramString = [[NSMutableString alloc] init];
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (paramString.length == 0) {
            [paramString appendFormat:@"%@",obj];
        } else {
            [paramString appendFormat:@"&%@",obj];
        }
    }];
    return paramString.copy;
}



























@end
