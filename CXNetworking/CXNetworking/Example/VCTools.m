//
//  VCTools.m
//  CXNetworking
//
//  Created by c_xie on 15/9/6.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "VCTools.h"

NSString * const kCurrentDeviceTokenKey = @"kCurrentDeviceTokenKey";

@implementation VCTools

+ (void)setDeviceToken:(NSString *)deviceToken
{
    NSString *deviceTokenStr =[[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    #pragma mark - C语言，遍历所有字符
    [[NSUserDefaults standardUserDefaults] setObject:deviceTokenStr forKey:kCurrentDeviceTokenKey];
    
}

+ (NSString *)deviceToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentDeviceTokenKey];
}

@end
