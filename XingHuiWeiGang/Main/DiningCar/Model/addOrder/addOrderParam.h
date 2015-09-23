//
//  addOrderParam.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/29.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dishInfoList.h"
@interface addOrderParam : NSObject
@property(nonatomic,strong)NSNumber *personCount;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSNumber *changCi;
@property(nonatomic,copy)NSString *bookingDate;
@property(nonatomic,strong)NSArray *dishesInfoList;
@property(nonatomic,copy)NSString *userCarts;
@end
/*
 personCount 就餐人数
 bookingDate 就餐日期
 changCi 就餐场次
 userId 用户编号
 List<DishesInfoBean> dishesInfoList;菜品列表集合
 DishesInfoId 菜品编号
 ShopPrice 单价
 Count 数量
 userCarts; //点餐车编号
 在点菜车里下单的时候要传点菜车的编号，如果有多个就用逗号拼起来
 */