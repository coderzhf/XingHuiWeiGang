//
//  DishTool.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishTool.h"
#import "HttpTool.h"
@implementation DishTool
+(void)dishesWithParam:(ShowDishesParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:showAllDishesInfo params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)dishesWithdict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:showAllDishesInfo params:dict success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+(void)dishesDetailWithParam:(DishDetailParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:showDishesInfo params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)dishesCommentWithParam:(ShowCommentParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:showComment params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)dishesShowCuisinesuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:showCuisine params:nil success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)dishesTypesuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:showDishesType params:nil success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)addUserAttentionWithParam:(addUserAttentionParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [HttpTool getWithURL:addUserAttention params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+(void)addUserPraiseWithParam:(addUserPraiseParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [HttpTool getWithURL:addUserPraise params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)showAttentionDishesWithParam:(showAttentionDishesParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [HttpTool getWithURL:showDishesAttention params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+(void)showAttentionShopsWithParam:(showAttentionShopsParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [HttpTool getWithURL:showShopAttention params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+(void)updateUserAttentionWithParam:(updateUserAttentionParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [HttpTool getWithURL:updateUserAttention params:param.keyValues success:^(id json) {
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
