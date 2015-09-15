//
//  CXCoreService.m
//  CXNetworking
//
//  Created by c_xie on 15/9/8.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXCoreService.h"

NSString * const kDebugEnvironmentDidChangeNotification = @"kDebugEnvironmentDidChangeNotification";
NSString * const kCurrentDebugEnvironmentIsTestKey = @"kCurrentDebugEnvironmentIsTestKey";

@interface CXCoreService ()

@property (nonatomic,assign,readwrite)  BOOL isTest;
@property (nonatomic,strong,readwrite) NSString *apiBaseURL;
@property (nonatomic,weak,readwrite)  NSObject<CXCoreServiceProtocol> *child;

@end

@implementation CXCoreService

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(CXCoreServiceProtocol)]) {
            self.child = (id<CXCoreServiceProtocol>)self;
        } else {
            NSAssert(NO, @"必须遵守<CXCoreServiceProtocol>协议");
        }
        [self setupCurrentDebugEnvironment];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(debugEnvironmentDidChange:) name:kDebugEnvironmentDidChangeNotification object:nil];
    }
    return self;
}

#pragma mark - target action

- (void)debugEnvironmentDidChange:(NSNotification *)note
{
    [self setupCurrentDebugEnvironment];
}

#pragma mark - setter getter

- (NSString *)apiBaseURL
{
    return self.isTest ? self.child.testApiBaseURL : self.child.productApiBaseURL;
}


#pragma mark - private method

- (void)setupCurrentDebugEnvironment
{
    NSNumber *isTest = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentDebugEnvironmentIsTestKey];
    if (isTest == nil || [isTest boolValue]) {  // 测试环境
        self.isTest = YES;
    } else {
        self.isTest = NO;
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}








@end
