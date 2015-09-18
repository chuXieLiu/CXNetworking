//
//  AppDelegate.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "CXUserDefaults.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupAFNetworking];
    [self setupUserData];
    return YES;
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
}


#pragma mark - private method 

- (void)setupAFNetworking
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:cache];
}

- (void)setupUserData
{
    [CXUserDefaults setObject:@"6831" forKey:kAppUidStringKey];
    [CXUserDefaults setObject:@"57ksmtk8up4me85c4u3d0a5t95" forKey:kAppSidStringKey];
    [CXUserDefaults setObject:@"15920428067" forKey:kAppUserStringKey];
    [CXUserDefaults setObject:@"deb64e86bb631640e8ee473144abbd31e993991f1a36e68cb75126988d0db715" forKey:kAppDeviceTokenStringKey];
    [CXUserDefaults setObject:@"广州市" forKey:kAppCityStringKey];
    [CXUserDefaults setObject:@"113.328681,23.130497" forKey:kAppPoiStringkey];
}

@end
