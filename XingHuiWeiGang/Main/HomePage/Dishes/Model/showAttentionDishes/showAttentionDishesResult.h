//
//  showAttentionDishesResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/11.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface showAttentionDishesResult : NSObject
@property(nonatomic,strong)NSNumber *userAttentionId;
@property(nonatomic,strong)NSNumber *count;
@property(nonatomic,strong)NSNumber *dishesInfoId;
@property(nonatomic,strong)NSNumber *saleType;
@property(nonatomic,strong)NSNumber *score;
@property(nonatomic,strong)NSNumber *shopId;

@property(nonatomic,copy)NSString *dishesName;
@property(nonatomic,copy)NSString *thumbUrl;
@property(nonatomic,assign)CGFloat shopPrice;
@property(nonatomic,assign)BOOL isOnSale;
@property(nonatomic,assign)BOOL isPraise;
@property(nonatomic,assign)BOOL isAttention;
@property(nonatomic,assign)BOOL isPack;

@end
/*
 {"code":0,"list":[
 {"count":0,"dishesInfoId":22,"dishesName":"酸辣土豆丝","isAttention":0,"isOnSale":1,"isPack":0,"isPraise":0,"saleType":2,"score":0,"shopId":0,"shopPrice":12.00,"thumbUrl":"/images/tds4.jpg","userAttentionId":"49"},
 {"count":0,"dishesInfoId":5,"dishesName":"浙菜凉菜1","isAttention":0,"isOnSale":1,"isPack":0,"isPraise":0,"saleType":5,"score":0,"shopId":0,"shopPrice":30.00,"thumbUrl":"images/danta.jpg","userAttentionId":"52"}],"msg":"查看关注菜品成功"}
 
*/