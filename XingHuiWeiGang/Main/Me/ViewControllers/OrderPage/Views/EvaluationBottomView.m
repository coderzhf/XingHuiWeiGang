//
//  EvaluationBottomView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/25.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "EvaluationBottomView.h"

@implementation EvaluationBottomView

+ (instancetype)bottomView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]firstObject];
}

@end
