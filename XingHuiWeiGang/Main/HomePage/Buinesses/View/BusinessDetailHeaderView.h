//
//  BusinessDetailHeaderView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailResult.h"
@interface BusinessDetailHeaderView : UIView
+(instancetype)headerView;
@property(nonatomic,strong)ShopDetailResult *DetailResult;
@end
