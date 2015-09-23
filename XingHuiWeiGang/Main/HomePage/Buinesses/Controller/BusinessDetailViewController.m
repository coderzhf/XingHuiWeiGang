//
//  BusinessDetailViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "DishDetailViewController.h"
#import "BussinessDishInfoViewController.h"
#import "BusinessDetailHeaderView.h"
#import "BussinessHeaderView.h"
#import "DishesTableViewCell.h"
#import "BussinessTool.h"
#import "DishDetailCell.h"
#import "MJExtension.h"
#import "DishTool.h"
@interface BusinessDetailViewController ()
@property(nonatomic,strong)BusinessDetailHeaderView *headerView;
@property(nonatomic,strong)BussinessHeaderView *SectionOneView;
@property(nonatomic,strong)BussinessHeaderView *SectionTwoView;
@end

@implementation BusinessDetailViewController
- (BussinessHeaderView *)SectionOneView {
    if (!_SectionOneView) {
        _SectionOneView = [BussinessHeaderView headerView];
    }
    return _SectionOneView;
}
- (BussinessHeaderView *)SectionTwoView {
    if (!_SectionTwoView) {
        _SectionTwoView = [BussinessHeaderView headerView];
    }
    return _SectionTwoView;
}
- (void)viewDidLoad {
    self.headerView=[BusinessDetailHeaderView headerView];
    self.tableView.tableHeaderView=self.headerView;
    self.cellClass=[DishesTableViewCell class];
    self.cellClassTwo=[DishDetailCell class];
    self.sectionsNumber=2;
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)setShowShop:(ShowShopResult *)ShowShop {
    _ShowShop=ShowShop;
    ShopDetailParam *parma = [[ShopDetailParam alloc]init];
    parma.shopId=ShowShop.shopId;
    parma.userId = @27;
    __weak typeof(self) Weakself=self;
    [BussinessTool shopDetailWithParam:parma success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSDictionary *dataDict = json[@"obj"];
        ShopDetailResult *result = [ShopDetailResult objectWithKeyValues:dataDict];
        result.descrip = dataDict[@"description"];
        Weakself.headerView.DetailResult =result;
        Weakself.title=result.shopName;
        Weakself.ShowShop.shopName = result.shopName;
    } failure:^(NSError *error) {
        
    }];

}
- (void)LoadNewData {
  
    ShowDishesParam *param = [[ShowDishesParam alloc]init];
    param.shopId=self.ShowShop.shopId;

    __weak typeof(self) Weakself=self;
    NSMutableArray *ShowDishestempArray=[NSMutableArray array];
    [DishTool dishesWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSArray *data = json[@"list"];
        for (NSDictionary *dict in data) {
            ShowDishesResult *result = [ShowDishesResult objectWithKeyValues:dict];
            [ShowDishestempArray addObject:result];
        }
    } failure:^(NSError *error) {
        
    }];
    
    ShowCommentParam *CommentParam  = [[ShowCommentParam alloc]init];
    CommentParam.shopId = self.ShowShop.shopId;
    NSMutableArray *CommentempArray=[NSMutableArray array];
    [DishTool dishesCommentWithParam:CommentParam  success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSArray *data = json[@"list"];
        for (NSDictionary *dict in data) {
            ShowCommentResult *result = [ShowCommentResult objectWithKeyValues:dict];
            [CommentempArray addObject:result];
        }
      
        Weakself.dataArray=@[ShowDishestempArray,CommentempArray];
         } failure:^(NSError *error) {
        
    }];

    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
   
    if (section==0) {
        [self.SectionOneView.titlebutton setTitle:@"菜品列表" forState:UIControlStateNormal];
        [self.SectionOneView.titlebutton setImage:[UIImage imageNamed:@"yx_introduce_Img"] forState:UIControlStateNormal];
        [self.SectionOneView.showButton setImage:[UIImage imageNamed:@"yx_book_changeMsg"] forState:UIControlStateNormal];
        [self.SectionOneView.showButton addTarget:self action:@selector(dinnerShow:) forControlEvents:UIControlEventTouchUpInside];
        self.SectionOneView.titleLabel.text = @"更多菜品";
        return self.SectionOneView;
        
    }else{
        [self.SectionTwoView.titlebutton setTitle:@"店铺评价" forState:UIControlStateNormal];
        [self.SectionTwoView.titlebutton setImage:[UIImage imageNamed:@"yx_adjudgement_Img"] forState:UIControlStateNormal];
        [self.SectionTwoView.showButton addTarget:self action:@selector(ShowShop:) forControlEvents:UIControlEventTouchUpInside];
        [self.SectionTwoView.showButton setImage:[UIImage imageNamed:@"yx_areaChoose_up"] forState:UIControlStateNormal];
         [self.SectionTwoView.showButton setImage:[UIImage imageNamed:@"yx_areaChoose_down"] forState:UIControlStateSelected];
        self.SectionTwoView.titleLabel.text = @"查看";

        return self.SectionTwoView;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return (!self.cellOneHiden)?75:0;
    }else{
        
        return 116;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ShowDishesResult *result = [self.dataArray[0] objectAtIndex:indexPath.row];
        DishDetailViewController *dv=[[DishDetailViewController alloc]init];
        dv.dishesInfoId = result.dishesInfoId;
        [self.navigationController pushViewController:dv animated:YES];
    }
  
}

#pragma mark - action
- (void)dinnerShow:(UIButton *)btn {

    BussinessDishInfoViewController *dishInfo = [[BussinessDishInfoViewController alloc]init];
    dishInfo.ShowShop = self.ShowShop;
    [self.navigationController pushViewController:dishInfo animated:YES];
    
}

- (void)ShowShop:(UIButton *)btn {
    
    btn.selected = !btn.isSelected;
    self.cellTwoHiden = btn.selected ;
    [self.tableView reloadData];
    
}
@end
