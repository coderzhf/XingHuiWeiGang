//
//  showMyOrderParam.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showMyOrderParam : NSObject
@property (nonatomic, copy) NSString *pageNoStr;
@property (nonatomic, copy) NSString *pageSizeStr;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *orderType;
@end
/*
 pageNoStr	string
 pageSizeStr	string
 userId	Int
 status	Int

 1待付款 2已付款 4已完成 16已退款 32已取消
 */