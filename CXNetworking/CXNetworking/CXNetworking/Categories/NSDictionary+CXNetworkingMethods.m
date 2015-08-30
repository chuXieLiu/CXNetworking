//
//  NSDictionary+CXNetworkingMethods.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "NSDictionary+CXNetworkingMethods.h"
#import "NSArray+CXNetworkingMethods.h"

@implementation NSDictionary (CXNetworkingMethods)

- (NSString *)URLParamsString
{
    NSArray *sortedArray = [self reformURLParamsArray];
    return [sortedArray paramsString];
}


- (NSArray *)reformURLParamsArray
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@",obj];
        }
        // 对参数中的特殊字符!*'();:@&;=+$,/?%#[]进行转义
        obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)obj, NULL, (CFStringRef)@"!*'();:@&;=+$,/?%#[]", kCFStringEncodingUTF8));
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}


















































@end
