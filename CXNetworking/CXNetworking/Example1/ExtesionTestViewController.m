//
//  ExtesionTestViewController.m
//  CXNetworking
//
//  Created by c_xie on 15/9/21.
//  Copyright © 2015年 c_xie. All rights reserved.
//

#import "ExtesionTestViewController.h"
#import "CXAppMenuArguments.h"
#import "CXNetworking.h"

@implementation ExtesionTestViewController

+ (instancetype)ExtesionTestViewController
{
    return [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil].instantiateInitialViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self argsTest];
}

#pragma mark - test

- (void)argsTest
{
    CXAppMenuArguments *args = [[CXAppMenuArguments alloc] init];
    NSLog(@"%@",[args generateURLString]);
    [[CXNetworking shareManager] GET:[args generateURLString] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
