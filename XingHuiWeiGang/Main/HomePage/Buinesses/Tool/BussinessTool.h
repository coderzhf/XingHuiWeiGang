//
//  BussinessTool.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowShopParam.h"
#import "ShopDetailParam.h"
#import "ShopDetailResult.h"
#import "ShowShopResult.h"
#import "MJExtension.h"
@interface BussinessTool : NSObject
+(void)shopsWithParam:(ShowShopParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)shopDetailWithParam:(ShopDetailParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
