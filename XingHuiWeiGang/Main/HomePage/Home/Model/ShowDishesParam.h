//
//  ShowDishesParam.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowDishesParam : NSObject
@property(nonatomic,strong)NSNumber *pageNoStr;
@property(nonatomic,strong)NSNumber *pageSizeStr;
@property(nonatomic,strong)NSNumber *cuisineId;
@property(nonatomic,strong)NSNumber *shopId;
@property(nonatomic,strong)NSNumber *tasteId;
@property(nonatomic,copy)NSString *dishesName;
@property(nonatomic,strong)NSNumber *dishesType;
@property(nonatomic,strong)NSNumber *isHot;
@property(nonatomic,strong)NSNumber *isPrice;
@property(nonatomic,strong)NSNumber *isNew;
@property(nonatomic,strong)NSNumber *isPack;
@property(nonatomic,strong)NSNumber *isSale;
@property(nonatomic,strong)NSNumber *isRecommend;//大厨推荐
@property(nonatomic,strong)NSNumber *isPromote;//促销

@end
/*
 pageNoStr
 pageSizeStr
 dishesName 菜式名称（搜索时传）
 dishesType 菜品类型编号（条件查询传）
 cuisineId  菜系编号（条件查询传）
 shopId  商铺编号（查看商铺菜品传）
 isHot  是否是热门
 isPrice
 tasteId 口味
 isNew
 isPack
 isSale
 */