//
//  DishTool.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowDishesParam.h"
#import "DishDetailParam.h"
#import "ShowCommentParam.h"
#import "ShowCommentResult.h"
#import "DishDetailResult.h"
#import "ShowDishesResult.h"
#import "showCuisineResult.h"
#import "showDishesTypeResult.h"
#import "addUserAttentionParam.h"
#import "addUserPraiseParam.h"
#import "showAttentionDishesParam.h"
#import "showAttentionShopsParam.h"
#import "showAttentionShopsResult.h"
#import "updateUserAttentionParam.h"
#import "MJExtension.h"
@interface DishTool : NSObject
+(void)dishesWithParam:(ShowDishesParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)dishesWithdict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)dishesDetailWithParam:(DishDetailParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)dishesCommentWithParam:(ShowCommentParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)dishesShowCuisinesuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)dishesTypesuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)addUserAttentionWithParam:(addUserAttentionParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)addUserPraiseWithParam:(addUserPraiseParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)showAttentionDishesWithParam:(showAttentionDishesParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)showAttentionShopsWithParam:(showAttentionShopsParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)updateUserAttentionWithParam:(updateUserAttentionParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
