//
//  CXAppUtils.h
//  CXNetworking
//
//  Created by c_xie on 15/9/14.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXAppUtils : NSObject

+ (NSString *)generateTermcode;
+ (NSString *)md5:(NSString *)inputString;

@end
