//
//  PayWithAccountViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/26.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "PayWithAccountViewController.h"
#import "TradeView.h"
@interface PayWithAccountViewController ()<TradeViewDelegate,UIAlertViewDelegate>

@end

@implementation PayWithAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"支付";
    self.view.backgroundColor = YXRGB(230, 230, 230);
    UIImageView *imageView = [UQFactory imageViewWithFrame:KFrame(0, 0, KScreenWidth, KScreenHeight/2) image:nil];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
    
   TradeView *tradeView = [TradeView tradeView];
    tradeView.delegate = self;
    [tradeView showInView:self.view];
}
#pragma paySuccessDelegate
- (void)finish:(NSString *)pwd
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"orderId"] = self.OrderResult.orderId;
    dic[@"payPwd"]= pwd;
    if (_isAppointment) {
        dic[@"payPwd"]= pwd;
    }
    [Utils post:payMoney params: dic success:^(id json) {
        NSString *tint;
        if ([json[@"code"] integerValue]) {//密码错误
            tint = @"确定";
        }else if ([json[@"code"] integerValue]){//余额不足
            tint = @"充值";
        }else{//成功
            tint = @"确定";
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:json[@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:tint, nil];
        [alertView show];
        [Notifier UQToast:self.view text:json[@"msg"] timeInterval:NyToastDuration];

    } failure:^(NSError *error) {
        [Notifier UQToast:self.view text:@"支付失败" timeInterval:NyToastDuration];

    }];
}

#pragma alertViewDeleate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"充值"]) {
        NSLog(@"去充值");
    }
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
