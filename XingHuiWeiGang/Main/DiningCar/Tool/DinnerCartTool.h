//
//  DinnerCartTool.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/27.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "addUserCartParam.h"
#import "deleteUserCartParam.h"
#import "showUserCartParam.h"
#import "showUserCartResult.h"
#import "addOrderParam.h"
#import "addOrderResult.h"
#import "showSysTypeParam.h"
#import "bookTimeResult.h"
#import "showOrderParam.h"
#import "showOrderResult.h"
#import "addWaitingNumberParam.h"
#import "addWaitingNumberResult.h"
#import "showWaitingNumberParam.h"
#import "showWaitingNumberResult.h"
#import "addPtOrderParam.h"
#import "addPtOrderResult.h"
#import "MJExtension.h"
#import "DishTypes.h"
@interface DinnerCartTool : NSObject
+(void)showUserCartWithParam:(showUserCartParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)addUserCartWithParam:(addUserCartParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)deleteUserCartWithParam:(deleteUserCartParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)addOrderWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)showSysTypeWithParam:(showSysTypeParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)showOrderWithParam:(showOrderParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)addWaitingNumberWithParam:(addWaitingNumberParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)showWaitingNumberWithParam:(showWaitingNumberParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)addPtOrderWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)addWmOrderWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)showBookMessageWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
