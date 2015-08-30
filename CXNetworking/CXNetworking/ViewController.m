//
//  ViewController.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+CXNetworkingMethods.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = @{
                           @"a":@"1",
                           @"z":@"2",
                           @"c":@"3&",
                           @"q":@"1",
                           @"h":@"2",
                           @"i":@"3&"
                           };
    NSLog(@"==>%@",dict);
    NSLog(@"%@",[dict URLParamsString]);
    NSString *str = @"123&123";
    NSString *temp = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",temp);
}



@end
