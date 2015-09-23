//
//  CustomPickView.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/4.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationSpring.h"

typedef NS_OPTIONS(NSInteger, NSUserInforOptions ){
    genderOptions,
    tasteOptions,
};

typedef void(^changeInforBlock)(NSString *infor);

@interface PopupView : UIView
@property (nonatomic ,strong)  UIView *bgView;
@property (nonatomic, weak)UIViewController *parentVC;

@property (nonatomic ,assign) NSUserInforOptions options;
@property (nonatomic ,strong)  NSString *str;
@property (nonatomic ,strong)  NSArray *dataArray;//填充pickview的数据
@property (nonatomic ,strong)  changeInforBlock changeSussessBlock;

+ (instancetype)defaultPopupView;

- (void)addSubviewWithOptions:(NSUserInforOptions)options;
- (void)hadChangeSuccess:(changeInforBlock)successBlock;
@end
