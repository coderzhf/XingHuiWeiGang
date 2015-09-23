//
//  addPtOrderParam.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/4.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "dishInfoList.h"
@interface addPtOrderParam : NSObject
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,copy)NSString *tableNo;
@property(nonatomic,strong)NSArray *dishesInfoList;
@end
