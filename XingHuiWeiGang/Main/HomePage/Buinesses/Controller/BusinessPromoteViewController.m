//
//  BusinessPromoteViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/24.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BusinessPromoteViewController.h"
#import "BussinessViewCell.h"
#import "BussinessHeaderView.h"
#import "BusinessDetailViewController.h"
#import "BussinessTool.h"
@interface BusinessPromoteViewController ()

@end

@implementation BusinessPromoteViewController


- (void)viewDidLoad {
    self.cellClass = [BussinessViewCell class];
    [super viewDidLoad];
    self.title=@"商铺促销";
}

- (void)LoadNewData {
    ShowShopParam *param = [[ShowShopParam alloc]init];
    param.isPromote = @1;
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

@end
