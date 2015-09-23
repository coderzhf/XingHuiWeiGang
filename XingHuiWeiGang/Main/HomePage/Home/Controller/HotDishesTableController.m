//
//  HotDishesTableController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "HotDishesTableController.h"
#import "DishesTableViewCell.h"
#import "DishDetailViewController.h"
#import "DishTool.h"
@interface HotDishesTableController ()

@end

@implementation HotDishesTableController

- (void)viewDidLoad {
    self.cellClass=[DishesTableViewCell class];
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
}
- (void)LoadNewData {
    
    ShowDishesParam *param = [[ShowDishesParam alloc]init];
    param.isHot = @1;
    __weak typeof(self) Weakself=self;
    [DishTool dishesWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSArray *data = json[@"list"];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in data) {
            ShowDishesResult *result = [ShowDishesResult objectWithKeyValues:dict];
            [tempArray addObject:result];
        }
        Weakself.dataArray =tempArray;
    } failure:^(NSError *error) {
        
    }];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    ShowDishesResult *result = self.dataArray[indexPath.row];
    DishDetailViewController *dv=[[DishDetailViewController alloc]init];
    dv.dishesInfoId = result.dishesInfoId;
    [self.navigationController pushViewController:dv animated:YES];
}
@end
