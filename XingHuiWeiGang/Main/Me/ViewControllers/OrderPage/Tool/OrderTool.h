//
//  OrderTool.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "showMyOrderParam.h"
#import "showWillPayOrder.h"
#import "updateOrderParam.h"
#import "deleteDishParam.h"
#import "deleteOrderParam.h"
#import "addCommentParam.h"
@interface OrderTool : NSObject
+(void)showMyOrderWithParam:(showMyOrderParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)updateOrderWithParam:(updateOrderParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)deleteDishWithParam:(deleteDishParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)deleteOrderWithParam:(deleteOrderParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)addCommentWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
