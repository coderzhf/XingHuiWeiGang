//
//  PromotionViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/24.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "PromotionViewController.h"
#import "DishPromtionViewController.h"
#import "BusinessPromoteViewController.h"
@interface PromotionViewController ()

@end

@implementation PromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"促销";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (IBAction)dishPromotion {
    
    DishPromtionViewController *dish = [[DishPromtionViewController alloc]init];
    [self.navigationController pushViewController:dish animated:YES];
}
- (IBAction)bussinessPromotion {
    
    BusinessPromoteViewController *business = [[BusinessPromoteViewController alloc]init];
    [self.navigationController pushViewController:business animated:YES];

}
- (IBAction)platformPromotion {
    
}
@end
