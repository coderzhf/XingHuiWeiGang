//
//  DiscountView.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/21.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "ShakeDiscountView.h"

@implementation ShakeDiscountView

+ (ShakeDiscountView *)instanceWithFrame:(CGRect)frame
{
    ShakeDiscountView *view = [[NSBundle mainBundle] loadNibNamed:@"ShakeDiscountView" owner:self options:nil][0];
    view.frame = frame;
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
