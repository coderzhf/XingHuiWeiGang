//
//  showWaitingNumberResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/30.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showWaitingNumberResult : NSObject
@property (nonatomic, copy)NSString *bookingDate;
@property (nonatomic, copy)NSString *waitingNo;
@property (nonatomic, copy)NSString *personCount;
@end
/*
{"code":0,"msg":"排号信息查看成功","obj":{"actualPayPrice":0,"bookingDate":"2015-08-19 00:00","dishesId":0,"orderId":626,"personCount":"2","status":0,"waitingNo":"A20001"}}
 */