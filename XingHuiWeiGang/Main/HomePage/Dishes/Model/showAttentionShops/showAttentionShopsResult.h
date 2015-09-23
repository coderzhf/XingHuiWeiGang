//
//  showAttentionShopsResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/11.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showAttentionShopsResult : NSObject
@property(nonatomic,strong)NSNumber *userAttentionId;
@property(nonatomic,strong)NSNumber *avgAmount;
@property(nonatomic,strong)NSNumber *score;
@property(nonatomic,strong)NSNumber *shopId;
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,assign)BOOL isPraise;
@property(nonatomic,assign)BOOL isAttention;

@end
/*
 
 {"code":0,"list":[{"avgAmount":50,"imgUrl":"/images/dp.jpg","isAttention":0,"isPraise":0,"score":0,"shopId":1,"shopName":"美食屋1","userAttentionId":"3"},{"avgAmount":500,"imgUrl":"/images/dp.jpg","isAttention":0,"isPraise":0,"score":0,"shopId":2,"shopName":"美食屋2","userAttentionId":"8"},{"avgAmount":5000,"imgUrl":"/images/dp.jpg","isAttention":0,"isPraise":0,"score":0,"shopId":3,"shopName":"美食屋3","userAttentionId":"9"},{"avgAmount":40,"imgUrl":"/images/dp.jpg","isAttention":0,"isPraise":0,"score":0,"shopId":4,"shopName":"美食屋4","userAttentionId":"10"}],"msg":"查看关注商铺成功"}
 */