//
//  DinnerCartTool.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/27.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DinnerCartTool.h"
#import "HttpTool.h"
@implementation DinnerCartTool
+(void)showUserCartWithParam:(showUserCartParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:showUserCart params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)addUserCartWithParam:(addUserCartParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:addUserCart params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)deleteUserCartWithParam:(deleteUserCartParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [HttpTool getWithURL:deleteUserCart params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)addOrderWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    
    [HttpTool postWithURL:addOrder json:param success:^(id rejson) {
        if (success) {
            success(rejson);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }

    }];
}
+(void)showSysTypeWithParam:(showSysTypeParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:showSysType params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)showOrderWithParam:(showOrderParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:showOrder params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)addWaitingNumberWithParam:(addWaitingNumberParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:addWaitingNumber params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)showWaitingNumberWithParam:(showWaitingNumberParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool getWithURL:showWaitingNumber params:param.keyValues success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)addPtOrderWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    
    [HttpTool postWithURL:addPtOrder json:param success:^(id rejson) {
        if (success) {
            success(rejson);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}
+(void)addWmOrderWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    
    [HttpTool postWithURL:addWmOrder json:param success:^(id rejson) {
        if (success) {
            success(rejson);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}
+(void)showBookMessageWithParam:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [HttpTool postWithURL:showBookMsg json:param success:^(id rejson) {
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
