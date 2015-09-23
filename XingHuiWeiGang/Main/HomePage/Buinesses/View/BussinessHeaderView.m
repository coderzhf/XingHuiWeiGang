//
//  BussinessHeaderView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BussinessHeaderView.h"
@interface BussinessHeaderView()

@end
@implementation BussinessHeaderView

+(instancetype)headerView{
    return [[[NSBundle mainBundle]loadNibNamed:@"BussinessHeaderView" owner:self options:nil]firstObject];
}


@end
