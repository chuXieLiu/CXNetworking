//
//  CXRequestContext.m
//  CXNetworking
//
//  Created by c_xie on 15/8/29.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import "CXRequestContext.h"
#import "AFNetworkReachabilityManager.h"
#import "CommonCrypto/CommonDigest.h"
#import "VCTools.h"

@interface CXRequestContext ()

@property (nonatomic,copy,readwrite) NSString *v;
@property (nonatomic,copy,readwrite) NSString *t;
@property (nonatomic,copy,readwrite) NSString *sign;
@property (nonatomic,copy,readwrite) NSString *deviceid;
@property (nonatomic,copy,readwrite) NSString *appid;
@property (nonatomic,copy,readwrite) NSString *termcode;
@property (nonatomic,copy,readwrite) NSString *uid;
@property (nonatomic,copy,readwrite) NSString *user;
@property (nonatomic,copy,readwrite) NSString *sid;
@property (nonatomic,copy,readwrite) NSString *city;
@property (nonatomic,copy,readwrite) NSString *poi;
@property (nonatomic,copy,readwrite) NSString *role;

@end

@implementation CXRequestContext

+ (instancetype)shareManager
{
    static CXRequestContext *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSNumber *)v
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)m
{
    #pragma mark - test
    return @"special/companylist";
}



- (NSString *)t
{
    NSDate *date = [NSDate date];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%li",(long)timestamp];
}

- (NSString *)sign
{
    // md5(v+m+t+TOKEN)
    NSString *token = @"1idj2in3Zk$09#d019i";
    NSString *md5LCStr=[self md5:[NSString stringWithFormat:@"%@%@%@%@",self.v,self.m, self.t, token]];
    
    return md5LCStr;
}

- (NSString *)deviceid
{
    return [VCTools deviceToken];
}

- (NSString *)appid
{
    return @"e5761ee33441713bfcc062f2";
}

- (NSString *)termcode
{
    return @"ios-7.0000-iphone4s";
}

- (NSString *)uid
{
    #pragma mark - 截取用户uid
    return nil;
}

- (NSString *)user
{
    //user	用户帐号	可选	username,可以是中文昵称或邮箱或手机号码。uid，user,sid在登录后必传,登录前传空值
    return nil;
}

- (NSString *)sid
{
    //sid	session id	可选	用户登录后session id
    return nil;
}

- (NSString *)city
{
    //city	城市名称	可选
    return @"广州";
}

- (NSString *)poi
{
    //poi	经度，纬度	可选
    return @"";
}


- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}




- (NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}














@end
