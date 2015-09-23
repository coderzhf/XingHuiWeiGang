//
//  PayViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/5.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "PayViewController.h"
#import "PayWithAccountViewController.h"
@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)aliPay:(id)sender {
}

- (IBAction)weChatPay:(id)sender {
}
- (IBAction)webPay:(id)sender {
}
- (IBAction)accountPay:(id)sender {
    PayWithAccountViewController *accountVC = [[PayWithAccountViewController alloc] init];
    accountVC.OrderResult = self.OrderResult;
    [self.navigationController pushViewController:accountVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
