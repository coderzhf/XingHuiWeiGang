//
//  PackageViewController.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/24.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) IBOutlet UIButton *defalutBtn;
@property (weak, nonatomic) IBOutlet UIButton *salesBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@end
