//
//  DetailUserInforViewController.h
//  XingHuiWeiGang
//
//  Created by zx on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeUserBlock)(NSString *infor);

@interface DetailUserInforViewController : UIViewController

@property (nonatomic ,strong) NSString *flagStr;
@property (nonatomic ,strong) NSString *userName;
//是否为忘记密码
@property (nonatomic ,assign) BOOL loginPsw;

@property (nonatomic ,strong)  changeUserBlock changeSussessBlock;

- (void)hadChangeSuccess:(changeUserBlock)successBlock;

@end
