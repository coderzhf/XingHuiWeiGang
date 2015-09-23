//
//  BusinessViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BusinessViewController.h"
#import "BussinessViewCell.h"
#import "BussinessHeaderView.h"
#import "BusinessDetailViewController.h"
#import "BussinessTool.h"

@interface BusinessViewController ()
@end

@implementation BusinessViewController

- (void)viewDidLoad {
    self.cellClass = [BussinessViewCell class];
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
    self.title=@"商铺列表";
   // [self setupHeaderView];
}
- (void)setupHeaderView {
    BussinessHeaderView *header = [BussinessHeaderView headerView];
    self.tableView.tableHeaderView = header;


}

- (void)LoadNewData {
    __weak typeof(self) Weakself=self;
    [BussinessTool shopsWithParam:nil success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSArray *data = json[@"list"];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in data) {
            ShowShopResult *result = [ShowShopResult objectWithKeyValues:dict];
            [tempArray addObject:result];
        }
        Weakself.dataArray =tempArray;
    } failure:^(NSError *error) {
        
    }];
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowShopResult *result = self.dataArray[indexPath.row];
    BusinessDetailViewController *bv=[[BusinessDetailViewController alloc]init];
    bv.ShowShop=result;
    [self.navigationController pushViewController:bv animated:YES];
}
#pragma mark - action

@end
