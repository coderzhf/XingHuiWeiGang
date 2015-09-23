//
//  Utils.m
//  ZhenMeiShiDaiApp
//
//  Created by zx on 15/6/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "Utils.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <AdSupport/AdSupport.h>
#import <netdb.h>
#import "AFNetworking.h"


@implementation Utils

+ (BOOL)isNetworkConnected
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    //1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 设置超时时间
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 30.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];//设置相应内容类型
    //2.发送Post请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary*responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
                    }
    }];
}

+ (CGFloat)getContentHeight:(NSString *)comment width:(CGFloat)width
{
    CGFloat contentHight = [comment boundingRectWithSize:CGSizeMake(300, width) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
    return contentHight;
}

- (CGSize)getSizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andString:(NSString *)str
{
    NSDictionary *arrts = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil];
    return rect.size;
}

@end
