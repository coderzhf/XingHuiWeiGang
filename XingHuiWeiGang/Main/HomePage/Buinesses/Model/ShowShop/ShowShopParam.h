//
//  ShowShopParam.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowShopParam : NSObject
@property(nonatomic,strong)NSNumber *pageNoStr;
@property(nonatomic,strong)NSNumber *pageSizeStr;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,strong)NSNumber *isHot;
@property(nonatomic,strong)NSNumber *isPromote;//促销

@end
/*
 pageNoStr
 pageSizeStr
 shopName
 */