//
//  CustomButton.m
//  ZhenMeiShiDaiApp
//
//  Created by zx on 15/6/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "CustomControl.h"

@implementation CustomControl

- (id)initWithFrame:(CGRect)frame WithTitle:(NSString *)title withImage:(UIImage *)image
{
    if(self = [super initWithFrame:frame]){
        
            UIImageView *button = [UQFactory imageViewWithFrame:CGRectMake((self.width-50)/2,(self.height-50)/2, 50, 50) image:image];
            button.userInteractionEnabled = NO;
            [self addSubview:button];
            UILabel *label = [UQFactory labelWithFrame:CGRectMake(button.left+10, button.bottom, 80, 20) text:title textColor:[UIColor darkGrayColor] fontSize:14 center:NO];
            [self addSubview:label];
     }
    return self;
}


@end
