//
//  BusinessSearchViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/23.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BusinessSearchViewController.h"
#import "BussinessTool.h"
#import "BussinessViewCell.h"
#import "BusinessDetailViewController.h"
@interface BusinessSearchViewController ()

@end

@implementation BusinessSearchViewController
- (void)viewDidLoad {
    self.cellClass=[BussinessViewCell class];
    [super viewDidLoad];
    self.title = @"店铺搜索";
    self.tableView.rowHeight = 100;

}

- (void)setShopName:(NSString *)shopName{
    _shopName = [shopName copy];
    ShowShopParam *param = [[ShowShopParam alloc]init];
    param.shopName = shopName;
    __weak typeof(self) Weakself=self;
    [BussinessTool shopsWithParam:param success:^(id json) {
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
    BusinessDetailViewController *dv=[[BusinessDetailViewController alloc]init];
    dv.ShowShop = result;
    [self.navigationController pushViewController:dv animated:YES];
}

@end
