//
//  ViewController.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "ViewController.h"
#import "CXCoreProxy.h"
#import "CXUserDefaults.h"
#import "AFNetworkReachabilityManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CXUserDefaults setObject:@"6831" forKey:kAppUidStringKey];
    [CXUserDefaults setObject:@"57ksmtk8up4me85c4u3d0a5t95" forKey:kAppSidStringKey];
    [CXUserDefaults setObject:@"15920428067" forKey:kAppUserStringKey];
    [CXUserDefaults setObject:@"deb64e86bb631640e8ee473144abbd31e993991f1a36e68cb75126988d0db715" forKey:kAppDeviceTokenStringKey];
    [CXUserDefaults setObject:@"广州市" forKey:kAppCityStringKey];
    [CXUserDefaults setObject:@"113.328681,23.130497" forKey:kAppPoiStringkey];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%d",[self isReachable]);
    
    NSNumber *a = nil;
    NSArray *arra = [[NSArray alloc] init];
    NSLog(@"%d",[arra containsObject:a]);
}

/*

 typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
 AFNetworkReachabilityStatusUnknown          = -1,
 AFNetworkReachabilityStatusNotReachable     = 0,
 AFNetworkReachabilityStatusReachableViaWWAN = 1,
 AFNetworkReachabilityStatusReachableViaWiFi = 2,
 };
 */
- (NSInteger)isReachable
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    NSLog(@"isReachable=%d",[[AFNetworkReachabilityManager sharedManager] isReachable]);
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
   
//    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
//        return YES;
//    } else {
//        return [[AFNetworkReachabilityManager sharedManager] isReachable];
//    }
    
    
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        
//        switch (status) {
//                
//            case AFNetworkReachabilityStatusNotReachable:{
//                
//                NSLog(@"无网络");
//                
//                break;
//                
//            }
//                
//            case AFNetworkReachabilityStatusReachableViaWiFi:{
//                
//                NSLog(@"WiFi网络");
//                
//                break;
//                
//            }
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN:{
//                
//                NSLog(@"无线网络");
//                
//                break;
//                
//            }
//                
//            default:
//                
//                break;
//                
//        }
//        
//    }];
//    return YES;
    
}

@end
