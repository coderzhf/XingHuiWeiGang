//
//  addUserCartParam.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/24.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addUserCartParam : NSObject
@property(nonatomic,strong)NSNumber *dishesId;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,copy)NSString *count;
@end
/*
 dishesId	Int		菜品编号
 userId	Int		用户编号
 count	String		数量
 */