//
//  ShakeView.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakeDiscountView.h"

@interface ShakeView : UIImageView <UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic ,strong) UIView *view;

@property (nonatomic ,assign) unsigned int flag;

@property (nonatomic ,strong) UITableView *listTableView;
@property (nonatomic ,strong) NSArray *listArray;//菜品用


@property (nonatomic ,strong)ShakeDiscountView *discountView;//优惠券用
@property (nonatomic ,strong) NSString *discountStr;
@property (nonatomic ,strong) NSString *desc ;

@property (nonatomic ,strong) NSNumber *denomination ;
@property (nonatomic ,strong) NSNumber *startTime;
@property (nonatomic ,strong) NSNumber *stopTime ;
@property (nonatomic ,strong) NSNumber *couponType;
- (instancetype)initWithFrame:(CGRect)frame;
@end
