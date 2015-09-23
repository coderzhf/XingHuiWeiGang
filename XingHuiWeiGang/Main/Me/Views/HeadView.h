//
//  HeadView.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/7.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView

@property (nonatomic ,strong) UIImageView *headImg;
@property (nonatomic ,strong) UIButton *btn;
@property (nonatomic ,strong) UIButton *nameBtn;
-(instancetype )initWithFrame:(CGRect)frame withTitle:(NSString *)title;
@end
