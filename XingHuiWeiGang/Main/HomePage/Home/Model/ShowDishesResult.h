//
//  ShowDishesResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/17.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//4.1显示菜式（模糊查询，条件查询）

#import <Foundation/Foundation.h>

@interface ShowDishesResult : NSObject
/*收藏数*/
@property(nonatomic,strong)NSNumber *collectCount;

@property(nonatomic,strong)NSNumber *count;
/*菜品id*/
@property(nonatomic,strong)NSNumber *dishesInfoId;
/*菜品所在商铺id*/
@property(nonatomic,strong)NSNumber *shopId;
/*评价数*/
@property(nonatomic,strong)NSNumber *remarkCount;
/*销量*/
@property(nonatomic,strong)NSNumber *saleCount;
/*销售类型*/
@property(nonatomic,strong)NSNumber *saleType;
/*评分*/
@property(nonatomic,strong)NSNumber *score;
/*价格*/
@property(nonatomic,assign)CGFloat shopPrice;

@property(nonatomic,assign)CGFloat promotePrice;
/*菜品名称*/
@property(nonatomic,copy)NSString *dishesName;
/*菜品图片*/
@property(nonatomic,copy)NSString *thumbUrl;
/*是否在销*/
@property(nonatomic,assign)BOOL isOnSale;

@property(nonatomic,assign)BOOL isPack;

@end
/*
 
 {"code":0,"list":[
 {"collectCount":65,"count":0,"dishesInfoId":1,"dishesName":"川菜热菜1","isOnSale":0,"remarkCount":0,"saleCount":234,"saleType":1,"score":5,"shopId":1,"shopPrice":30.00,"thumbUrl":"images/danta.jpg"},
 {"collectCount":234,"count":0,"dishesInfoId":7,"dishesName":"川菜热菜3","isOnSale":1,"remarkCount":34,"saleCount":424,"saleType":2,"score":3,"shopId":4,"shopPrice":23.00,"thumbUrl":"images/danda.jpg"}
 ],"msg":"菜式查询成功"}
 
 {"collectCount":0,"count":0,"dishesInfoId":37,"dishesName":"八仙过海闹罗汉","isAttention":0,"isOnSale":1,"isPack":0,"isPraise":0,"promotePrice":1024.00,"remarkCount":0,"saleCount":0,"saleType":0,"score":4,"shopId":6,"shopPrice":1024.00,"thumbUrl":"upload/images/dishesImg/1439534916120_2.png"}
 
 */