//
//  showWillPayOrder.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "showWillPayOrder.h"
#import "MJExtension.h"
#import "orderDishes.h"
@implementation showWillPayOrder
-(NSDictionary *)objectClassInArray
{
    return @{@"dishesInfoList" : [orderDishes class]};
}
@end
