//
//  NSDictionary+Request.m
//  CXNetworking
//
//  Created by c_xie on 15/9/15.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "NSDictionary+Request.h"
#import "NSArray+Request.h"

@implementation NSDictionary (Request)

- (NSString *)paramsString
{
    NSArray *array = [self reformParamsArray];
    return [array paramsString];
}


- (NSArray *)reformParamsArray
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if (![value isKindOfClass:[NSString class]]) {
            value = [NSString stringWithFormat:@"%@",value];
        }
        // 对参数中的特殊字符!*'();:@&;=+$,/?%#[]进行转义
        value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)value, NULL, (CFStringRef)@"!*'();:@&;=+$,/?%#[]", kCFStringEncodingUTF8));
        if ([value length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}
@end
