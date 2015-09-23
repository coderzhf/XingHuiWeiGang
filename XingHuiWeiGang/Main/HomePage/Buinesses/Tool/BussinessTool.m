//
//  BussinessTool.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BussinessTool.h"
#import "HttpTool.h"
@implementation BussinessTool
+(void)shopsWithParam:(ShowShopParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:showShop params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)shopDetailWithParam:(ShopDetailParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:findShop params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
