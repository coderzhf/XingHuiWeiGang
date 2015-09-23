//
//  showWillPayOrder.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showWillPayOrder : NSObject
@property (nonatomic, assign) NSInteger actualPayPrice;
@property (nonatomic, copy) NSString *bookingDate;
@property (nonatomic, strong) NSNumber *personCount;
@property (nonatomic, copy) NSString *changCi;
@property (nonatomic, copy) NSString *issueTime;

@property (nonatomic, strong) NSNumber *orderId;
@property (nonatomic, strong) NSNumber *orderSn;

@property (nonatomic, strong) NSArray *dishesInfoList;
@end
/*
 
 {"code":0,"list":[
 {"actualPayPrice":2956,"bookingDate":"2015-08-19","changCi":"晚餐","dishesId":0,"dishesInfoList":[
 {"count":25,"dishesInfoId":49,"dishesName":"辣子鸡丁","isAttention":0,"isOnSale":1,"isPack":0,"isPraise":0,"orderDishesId":"1429","saleType":2,"score":0,"shopId":0,"shopPrice":58.00,"thumbUrl":"upload/images/dishesImg/largerimg/1439799080956_s.png"},
 {"count":4,"dishesInfoId":42,"dishesName":"正宗重庆酸辣粉","isAttention":0,"isOnSale":1,"isPack":0,"isPraise":0,"orderDishesId":"1430","saleType":5,"score":0,"shopId":0,"shopPrice":10.00,"thumbUrl":"upload/images/dishesImg/1439536013941_938697_f3602a.jpg"},
 {"count":14,"dishesInfoId":48,"dishesName":"西红柿炒蛋盖浇饭","isAttention":0,"isOnSale":1,"isPack":0,"isPraise":0,"orderDishesId":"1431","saleType":5,"score":0,"shopId":0,"shopPrice":103.00,"thumbUrl":"upload/images/dishesImg/largerimg/1439799123419_s.png"},
 {"count":2,"dishesInfoId":41,"dishesName":"青椒肉丝盖浇饭","isAttention":0,"isOnSale":1,"isPack":0,"isPraise":0,"orderDishesId":"1432","saleType":4,"score":0,"shopId":0,"shopPrice":12.00,"thumbUrl":"upload/images/dishesImg/1439535912433_2.png"}
 ],"issueTime":"2015-08-19","orderId":615,"orderSn":"425154806077","status":1}],"msg":"订单查询成功"}
 */