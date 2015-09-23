//
//  OrderTool.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderTool.h"
#import "HttpTool.h"
@implementation OrderTool
+(void)showMyOrderWithParam:(showMyOrderParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:showMyOrder params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+(void)updateOrderWithParam:(updateOrderParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:updateOrder params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+(void)deleteDishWithParam:(deleteDishParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:deleteDishes params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)deleteOrderWithParam:(deleteOrderParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:deleteOrder params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+(void)addCommentWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    
    [HttpTool postWithURL:addComment json:param success:^(id rejson) {
        if (success) {
            success(rejson);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}
@end
