//
//  CXNetworking.h
//  CXNetworking
//
//  Created by c_xie on 15/9/20.
//  Copyright © 2015年 c_xie. All rights reserved.
//

/****************************
 *该工具类存在的意义在于当需要进行简单的网络请求时可以快速调用并获取数据
 ****************************/

#import "AFHTTPSessionManager.h"

@interface CXNetworking : AFHTTPSessionManager

+ (instancetype)shareManager;

@end
