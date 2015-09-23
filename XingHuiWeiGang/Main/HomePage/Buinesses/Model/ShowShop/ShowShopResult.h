//
//  ShowShopResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/17.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//  5.1商户（模糊搜索）

#import <Foundation/Foundation.h>

@interface ShowShopResult : NSObject
/*人均*/
@property(nonatomic,strong)NSNumber *avgAmount;
/*收藏数*/
@property(nonatomic,strong)NSNumber *collectCount;
/*点赞数*/
@property(nonatomic,strong)NSNumber *praiseCount;
/*评价数*/
@property(nonatomic,strong)NSNumber *remarkCount;
/*得分*/
@property(nonatomic,strong)NSNumber *score;
/*店铺id*/
@property(nonatomic,strong)NSNumber *shopId;
/*图片*/
@property(nonatomic,copy)NSString *imgUrl;
/*图片*/
@property(nonatomic,copy)NSString *picUrl;
/*店铺名称*/
@property(nonatomic,copy)NSString *shopName;


@end
/*
 {"code":0,"list":[
 {"avgAmount":50,"collectCount":10,"imgUrl":"/images/dp.jpg","picUrl":"/images/dp1.jpg,/images/dp2.jpg","praiseCount":10,"remarkCount":0,"score":50,"shopId":1,"shopName":"美食屋1"},
 {"avgAmount":40,"collectCount":20,"imgUrl":"/images/dp.jpg","picUrl":"/images/dp1.jpg,/images/dp2.jpg","praiseCount":20,"remarkCount":0,"score":40,"shopId":4,"shopName":"美食屋4"}
 ],"msg":"商铺查看成功"}
 */