//
//  showUserCartResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/27.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showUserCartResult : NSObject
@property(nonatomic,strong)NSNumber *collectCount;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSNumber *dishesInfoId;
@property(nonatomic,strong)NSNumber *remarkCount;
@property(nonatomic,strong)NSNumber *praiseCount;
@property(nonatomic,strong)NSNumber *saleCount;
@property(nonatomic,strong)NSNumber *saleType;
@property(nonatomic,strong)NSNumber *shopId;
@property(nonatomic,strong)NSNumber *userCartsId;
@property(nonatomic,copy)NSString *dishesName;
@property(nonatomic,copy)NSString *thumbUrl;
@property(nonatomic,assign)CGFloat score;
@property(nonatomic,assign)CGFloat shopPrice;
@property(nonatomic,assign)CGFloat promotePrice;
@property(nonatomic,assign) CGFloat totalPrice;
@property(nonatomic,assign)BOOL isAttention;
@property(nonatomic,assign)BOOL isOnSale;
@property(nonatomic,assign)BOOL isPraise;
@property ( nonatomic, assign) BOOL isPack;
@end
/*
 UserCartsId 点菜车编号
 DishesInfoId 菜式编号
 ThumbUrl 缩略图
 DishesName 菜品名称
 ShopPrice 商铺价格
 RemarkCount 评论数
 praiseCount 点赞数
 SaleCount 总销售数量
 Count 购买数量
 CollectCount 收藏数
 Score 星级评分
 IsOnSale 1正常 0已售罄
 
 {"code":0,"list":[
 {"collectCount":36,"count":3,"dishesInfoId":2,"dishesName":"粤菜热菜1","isAttention":0,"isOnSale":1,"isPraise":0,"praiseCount":33,"remarkCount":0,"saleCount":797,"saleType":0,"score":4.5,"shopId":0,"shopPrice":30.00,"thumbUrl":"images/danta.jpg","userCartsId":"24"},
 {"collectCount":235,"count":1,"dishesInfoId":7,"dishesName":"川菜热菜3","isAttention":0,"isOnSale":1,"isPraise":0,"praiseCount":34,"remarkCount":34,"saleCount":424,"saleType":0,"score":3,"shopId":0,"shopPrice":23.00,"thumbUrl":"images/danda.jpg","userCartsId":"28"}
 ],"msg":"我的点菜车"}
 */