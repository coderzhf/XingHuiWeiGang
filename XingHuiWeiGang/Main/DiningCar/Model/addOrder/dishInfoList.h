//
//  dishInfoList.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/29.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dishInfoList : NSObject
@property(nonatomic,strong)NSNumber *dishesInfoId;
@property(nonatomic,assign)CGFloat shopPrice;
@property(nonatomic,strong)NSNumber *count;

@end
/*
 DishesInfoId 菜品编号
 ShopPrice 单价
 Count 数量
 */