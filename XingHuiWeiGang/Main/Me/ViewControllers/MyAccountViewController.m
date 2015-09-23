//
//  MyAccountViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "MyAccountViewController.h"
#import "PayViewController.h"

@interface MyAccountViewController ()
{
    UILabel *balance;
}
@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YXRGB(240, 240, 240);
    self.title = @"我的账户";
    
    UIView *header = [UQFactory viewWithFrame:KFrame(0, 0, KScreenWidth, 100) backgroundColor:[UIColor whiteColor]];
    UIImageView *img = [UQFactory imageViewWithFrame:KFrame(10, 20, 85, 60) image:KImage(@"yx_accountBalance_Img")];
    [header addSubview:img];
    UILabel *label = [UQFactory labelWithFrame:KFrame((KScreenWidth-80)/2, 20, 80, 20) text:@"账户余额" textColor:[UIColor blackColor] fontSize:17 center:YES];
    [header addSubview:label];
    balance = [UQFactory labelWithFrame:KFrame((KScreenWidth-100)/2, label.bottom+15, 100, 25) text:@"￥30.00" textColor:YXRGB(210, 105, 30) fontSize:24 center:YES];
    [header addSubview:balance];
    UIButton *btn = [UQFactory buttonWithFrame:KFrame(balance.right+20, balance.top, 60, 25) image:nil title:@"立即充值" titleColor:[UIColor darkGrayColor] fontSize:14];
    [btn addTarget:self action:@selector(chargeAction:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    UIImageView *imgView = [UQFactory imageViewWithFrame:KFrame(0, 93, KScreenWidth, 9) image:KImage(@"home_border")];
    [header addSubview:imgView];
    [self.view addSubview:header];

    self.customTableView.frame = KFrame(0, header.bottom+10, KScreenWidth, KScreenHeight-header.bottom-10);
    self.customTableView.styleFlag = AccountStyle;

}
#warning pay
- (void)chargeAction:(UIButton *)button
{//去充值
    PayViewController *pay = [[PayViewController alloc]init];
    [self.navigationController pushViewController:pay animated:NO];
}

- (void)LoadNewData
{
    self.pageNum = 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"] = [UserDefaults objectForKey:@"userId"];
    dic[@"pageSizeStr"] = @"10";
    dic[@"pageNoStr"] = [NSNumber numberWithInteger:self.pageNum];

    [Utils post:showConsume params:dic success:^(id json) {
        if ([[json objectForKey:@"code"] boolValue]) {
            [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        self.pageNum++;
        NSDictionary *dic = [json objectForKey:@"obj"];
        balance.text = [dic objectForKey:@"amount"];
        self.dataArray = [dic objectForKey:@"list"];
        
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        [self.header endRefreshing];
        [Notifier UQToast:self.view text:@"请求出错，请稍后再试" timeInterval:NyToastDuration];

    }];
}

- (void)LoadMoreData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"] = [UserDefaults objectForKey:@"userId"];
    dic[@"pageSizeStr"] = @"10";
    dic[@"pageNoStr"] = [NSNumber numberWithInteger:self.pageNum];
    [Utils post:showConsume params:dic success:^(id json) {
        if (![[json objectForKey:@"code"] boolValue]) {
            [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        self.pageNum++;
        balance.text = [json objectForKey:@"amount"];
        NSArray *array = [[NSArray alloc] init];
        array = [json objectForKey:@"list"];
        [self.dataArray addObjectsFromArray:array];
        [self.customTableView reloadData];
        
        [self.foot endRefreshing];
    } failure:^(NSError *error) {
        [self.foot endRefreshing];
        [Notifier UQToast:self.view text:@"请求出错，请稍后再试" timeInterval:NyToastDuration];
        
    }];

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
