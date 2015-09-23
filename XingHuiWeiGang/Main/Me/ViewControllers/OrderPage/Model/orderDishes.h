//
//  orderDishes.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "showUserCartResult.h"

@interface orderDishes : showUserCartResult
@property (nonatomic, strong) NSNumber *orderDishesId;
@property (nonatomic, assign) BOOL isComment;//是否为评价界面
@end
/*
  {"count":25,"dishesInfoId":49,"dishesName":"辣子鸡丁","isAttention":0,"isOnSale":1,"isPack":0,"isPraise":0,"orderDishesId":"1429","saleType":2,"score":0,"shopId":0,"shopPrice":58.00,"thumbUrl":"upload/images/dishesImg/largerimg/1439799080956_s.png"},
 */