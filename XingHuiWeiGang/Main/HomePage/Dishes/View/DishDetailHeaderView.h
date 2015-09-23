//
//  DishDetailHeaderView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DishDetailResult.h"
@interface DishDetailHeaderView : UIView
+(instancetype)HeaderView;
@property(nonatomic,strong)DishDetailResult *DetailResult;
@property(nonatomic,copy)void (^enterShopBlcok)(DishDetailResult *);
@end
