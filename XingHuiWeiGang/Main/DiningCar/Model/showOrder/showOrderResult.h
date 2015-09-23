//
//  showOrderResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/30.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showOrderResult : NSObject
@property(nonatomic,strong)NSNumber *actualPayPrice;
@property(nonatomic,strong)NSNumber *dishesId;
@property(nonatomic,strong)NSNumber *orderId;
@property(nonatomic,strong)NSNumber *personCount;
@property(nonatomic,copy)NSString *bookingDate;
@property(nonatomic,assign)long long  orderSn;

@end
/*
 {"code":0,"msg":"订单详情查看成功","obj":{"actualPayPrice":0,"bookingDate":"2015-07-31 00","dishesId":0,"orderId":127,"orderSn":"184607301620","personCount":"8"}}
 */