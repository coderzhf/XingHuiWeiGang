//
//  DishDetailViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishDetailViewController.h"
#import "DishDetailHeaderView.h"
#import "DishDetailCell.h"
#import "DishDetailToolView.h"
#import "dishInfoList.h"
#import "DishTool.h"
#import "MJExtension.h"
#import "BusinessDetailViewController.h"
#include "AddDinnerCarViewController.h"
#import "BookViewController.h"
#import "ShowShopResult.h"
#import "MBProgressHUD+MJ.h"
@interface DishDetailViewController ()
@property(nonatomic,strong)DishDetailToolView *toolView;
@property(nonatomic,strong)DishDetailHeaderView *headerView;
@property(nonatomic,strong)DishDetailResult *dishDetailResult;
@end

@implementation DishDetailViewController

- (void)viewDidLoad {
    self.cellClass=[DishDetailCell class];
    self.headerView=[DishDetailHeaderView HeaderView];
    self.tableView.tableHeaderView=self.headerView;
    __weak typeof(self) Weakself=self;
    self.headerView.enterShopBlcok=^(DishDetailResult *result){
        BusinessDetailViewController *bussiness = [[BusinessDetailViewController alloc]init];
        ShowShopResult *ShowShop = [[ShowShopResult alloc]init];
        ShowShop.shopId = result.shopId;
        bussiness.ShowShop = ShowShop;
        [Weakself.navigationController pushViewController:bussiness animated:YES];
    };
    [super viewDidLoad];
    self.tableView.rowHeight=123;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupToolView];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.toolView removeFromSuperview];
}
- (void)setupToolView {
    self.toolView=[DishDetailToolView ToolView];
    [self.toolView.addDinnerCarButton addTarget:self action:@selector(addDinnerCarButtonClick) forControlEvents:UIControlEventTouchUpInside];
      UIWindow *window =[[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.toolView];
    [self.toolView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.toolView autoSetDimension:ALDimensionHeight toSize:44];
}
- (void)setDishesInfoId:(NSNumber *)dishesInfoId{
    _dishesInfoId=dishesInfoId;
    DishDetailParam *parma = [[DishDetailParam alloc]init];
    parma.dishesInfoId=dishesInfoId;
    parma.userId = @27;
    __weak typeof(self) Weakself=self;
    [DishTool dishesDetailWithParam:parma success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSDictionary *dataDict = json[@"obj"];
        Weakself.dishDetailResult = [DishDetailResult objectWithKeyValues:dataDict];
        Weakself.dishDetailResult.descrip = dataDict[@"description"];
        Weakself.headerView.DetailResult =Weakself.dishDetailResult;
        Weakself.title=Weakself.dishDetailResult.dishesName;
       
    } failure:^(NSError *error) {
        
    }];
}
- (void)LoadNewData {
    ShowCommentParam *param = [[ShowCommentParam alloc]init];
    param.dishesInfoId = self.dishesInfoId;
    __weak typeof(self) Weakself=self;
    [DishTool dishesCommentWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSArray *data = json[@"list"];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in data) {
            ShowCommentResult *result = [ShowCommentResult objectWithKeyValues:dict];
            [tempArray addObject:result];
        }
        Weakself.dataArray =tempArray;
    } failure:^(NSError *error) {
        
    }];
}
- (void)addDinnerCarButtonClick {
    if (!self.dishDetailResult.isOnSale) {
        [MBProgressHUD showError:@"菜品已售罄"];
        return;
    }
    AddDinnerCarViewController *dinner = [[AddDinnerCarViewController alloc]init];
    dinner.modalPresentationStyle = UIModalPresentationOverFullScreen;
   
    [self presentViewController:dinner animated:YES completion:nil];
     dinner.dishDetailResult = self.dishDetailResult;
}

@end
