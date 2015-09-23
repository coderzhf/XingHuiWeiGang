//
//  TotalBottomView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/27.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "TotalBottomView.h"
@interface TotalBottomView ()

@end
@implementation TotalBottomView

+ (instancetype)bottomView {
    return [[[NSBundle mainBundle]loadNibNamed:@"TotalBottomView" owner:self options:nil]firstObject];

}

- (void)setGroundColor:(UIColor *)groundColor{
    
    self.backgroundColor = groundColor;
}
@end
