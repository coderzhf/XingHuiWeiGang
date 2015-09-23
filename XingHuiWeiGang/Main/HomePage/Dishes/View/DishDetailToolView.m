//
//  DishDetailToolView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishDetailToolView.h"

@implementation DishDetailToolView

+(instancetype)ToolView{
    return [[[NSBundle mainBundle]loadNibNamed:@"DishDetailToolView" owner:nil options:nil]firstObject];
}
- (void)awakeFromNib {
    self.addDinnerCarButton.layer.cornerRadius = 15;
    self.addDinnerCarButton.clipsToBounds = YES;
}
@end
