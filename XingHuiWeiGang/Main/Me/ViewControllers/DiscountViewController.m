//
//  DiscountViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DiscountViewController.h"
#import "ShakeDiscountModel.h"

@interface DiscountViewController ()
@property (nonatomic ,assign) BOOL isExpired;

@end

@implementation DiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  YXRGB(240, 240, 240);
    self.title = @"优惠券";
    
    self.customTableView.frame = KFrame(0, 0, KScreenWidth, KScreenHeight);
    self.customTableView.styleFlag = DiscountStyle;
    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"吃货节优惠券",@"title",@"19.70",@"price",@"订单满90.00使用",@"detail", @"2015.01.15",@"date",nil];
    //self.customTableView.array = @[dic];

    if (!self.isAll) {
        _isExpired = NO;
        
        UIView *headerView = [UQFactory viewWithFrame:KFrame(0, 0, KScreenWidth, 60) backgroundColor:[UIColor whiteColor]];
        [self.view addSubview:headerView];
        
        UISegmentedControl *segmentCtrl = [UQFactory segmentWithFrame:KFrame((KScreenWidth-160)/2, 15, 160, 30) items:@[@"全部",@"即将过期"]];
        [segmentCtrl addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventValueChanged];
        [headerView addSubview:segmentCtrl];
        self.customTableView.top = headerView.bottom;
        self.customTableView.height = KScreenHeight-headerView.bottom;
 
    }
}

- (void)chooseAction:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSInteger x = control.selectedSegmentIndex;
    if (x == 0) {//全部
        _isExpired = NO;
    }else{//即将过期
        _isExpired = YES;
    }
    [self.dataArray removeAllObjects];
    self.customTableView.array = self.dataArray;
    [self.customTableView reloadData];
    [self LoadNewData];
}

- (void)LoadNewData
{
    NSString *url;
    self.pageNum = 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([UserDefaults objectForKey:@"isLogin"]) {
        dic[@"userId"] = [UserDefaults objectForKey:@"userId"];
    }
    if (_isAll) {
        url = showAllCoupon;
    }else{
    if (!_isExpired) {
        url = showAllCoupon;
    }else{
        url = showMyCoupon;
        dic[@"pageSizeStr"] = @"10";
        dic[@"pageNoStr"] = [NSNumber numberWithInteger:self.pageNum];}
    }
    
    [Utils post:url params:dic success:^(id json) {
        if ([[json objectForKey:@"code"] boolValue]) {
            [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        self.pageNum++;
        NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in [json objectForKey:@"list"]) {
            ShakeDiscountModel *model = [[ShakeDiscountModel alloc] initWithDic:dic];
            [temp addObject:model];
        }
        self.dataArray = temp;
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        [self.header endRefreshing];
        [Notifier UQToast:self.view text:@"请求出错，请稍后再试" timeInterval:NyToastDuration];

    }];
}

- (void)LoadMoreData
{
    NSString *url;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"] = [UserDefaults objectForKey:@"userId"];
        url = showMyCoupon;
        dic[@"pageSizeStr"] = @"10";
        dic[@"pageNoStr"] = [NSNumber numberWithInteger:self.pageNum];
    
    [Utils post:url params:dic success:^(id json) {
        if ([[json objectForKey:@"code"] boolValue]) {
            [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        self.pageNum++;
        NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in [json objectForKey:@"list"]) {
            ShakeDiscountModel *model = [[ShakeDiscountModel alloc] initWithDic:dic];
            [temp addObject:model];
        }
        [self.dataArray addObjectsFromArray:temp];
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
