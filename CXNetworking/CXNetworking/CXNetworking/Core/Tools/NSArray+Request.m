//
//  NSArray+Request.m
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "NSArray+Request.h"

@implementation NSArray (Request)

- (NSString *)paramsString;
{
    NSMutableString *paramsString = [[NSMutableString alloc] init];
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (paramsString.length == 0) {
            [paramsString appendFormat:@"%@",obj];
        } else {
            [paramsString appendFormat:@"&%@",obj];
        }
    }];
    return paramsString.copy;
}

@end
