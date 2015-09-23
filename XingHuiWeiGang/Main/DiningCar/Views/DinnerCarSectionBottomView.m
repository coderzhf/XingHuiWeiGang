//
//  DinnerCarSectionBottomView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/23.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DinnerCarSectionBottomView.h"

@implementation DinnerCarSectionBottomView

+ (instancetype)bottomView {
    return [[[NSBundle mainBundle]loadNibNamed:@"DinnerCarSectionBottomView" owner:self options:nil]firstObject];
}

@end
