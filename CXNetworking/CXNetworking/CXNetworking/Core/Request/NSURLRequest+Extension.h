//
//  NSURLRequest+Extension.h
//  CXNetworking
//
//  Created by c_xie on 15/9/16.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSURLRequest (Extension)

@property (nonatomic,strong) NSDictionary *requestParams;
@property (nonatomic,strong) NSString *requestURL;


@end
