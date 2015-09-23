//
//  DishDetailResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/17.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//  4.2显示菜品详情

#import <Foundation/Foundation.h>

@interface DishDetailResult : NSObject
@property(nonatomic,strong)NSNumber *count;
@property(nonatomic,strong)NSNumber *dishesInfoId;
@property(nonatomic,strong)NSNumber *remarkCount;
@property(nonatomic,strong)NSNumber *praiseCount;
@property(nonatomic,strong)NSNumber *collectCount;
@property(nonatomic,strong)NSNumber *saleCount;
@property(nonatomic,strong)NSNumber *saleType;
@property(nonatomic,strong)NSNumber *score;
@property(nonatomic,strong)NSNumber *shopId;
#warning description 为系统字段
@property(nonatomic,copy)NSString *descrip;
@property(nonatomic,copy)NSString *dishesName;
@property(nonatomic,copy)NSString *imgUrl1;
@property(nonatomic,copy)NSString *thumbUrl;
@property(nonatomic,assign)CGFloat shopPrice;
@property(nonatomic,assign)CGFloat promotePrice;
@property(nonatomic,assign)BOOL isOnSale;
@property(nonatomic,assign)BOOL isPraise;
@property(nonatomic,assign)BOOL isAttention;
@end


/*
 {"code":0,"msg":"菜品详情查看成功","obj":
 {"count":0,"description":"麻婆豆腐是四川省汉族传统名菜之一，属于川菜系。主要原料为配料和豆腐，材料主要有豆腐、牛肉末（也可以用猪肉）、辣椒和花椒等。麻来自花椒，辣来自辣椒，这道菜突出了川菜“麻辣”的特点。","dishesInfoId":1,"dishesName":"川菜热菜1","imgUrl1":"/images/tp1.jpg,/images/tp2.jpg,/images/tp3.jpg","isOnSale":0,"praiseCount":5654,"remarkCount":0,"saleCount":234,"saleType":0,"score":0,"shopId":1,"shopPrice":30.00,"thumbUrl":"images/danta.jpg"}
 }
 
 {"code":0,"msg":"菜品详情查看成功","obj":
 {"collectCount":67,"count":0,"description":"麻婆豆腐是四川省汉族传统名菜之一，属于川菜系。主要原料为配料和豆腐，材料主要有豆腐、牛肉末（也可以用猪肉）、辣椒和花椒等。麻来自花椒，辣来自辣椒，这道菜突出了川菜“麻辣”的特点。","dishesInfoId":1,"dishesName":"川菜热菜1","imgUrl1":"/images/tp1.jpg,/images/tp2.jpg,/images/tp3.jpg","isAttention":0,"isOnSale":0,"isPraise":0,"praiseCount":5655,"remarkCount":5,"saleCount":234,"saleType":0,"score":0,"shopId":1,"shopPrice":30.00,"thumbUrl":"images/danta.jpg"}}
 */