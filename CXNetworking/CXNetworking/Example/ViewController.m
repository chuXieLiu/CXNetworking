//
//  ViewController.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "ViewController.h"
#import "CXCoreProxy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[CXCoreProxy shareManager] getWithURLString:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html"];
}


@end
