//
//  DishesSearchViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/23.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishesSearchViewController.h"
#import "DishesTableViewCell.h"
#import "DishDetailViewController.h"
#import "DishTool.h"
@interface DishesSearchViewController ()

@end

@implementation DishesSearchViewController

- (void)viewDidLoad {
    self.cellClass=[DishesTableViewCell class];
    [super viewDidLoad];
    self.title = @"菜品搜索";
    self.tableView.rowHeight = 100;

}

- (void)setDishName:(NSString *)dishName {
    _dishName = [dishName copy];
    ShowDishesParam *param = [[ShowDishesParam alloc]init];
    param.dishesName = dishName;
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
