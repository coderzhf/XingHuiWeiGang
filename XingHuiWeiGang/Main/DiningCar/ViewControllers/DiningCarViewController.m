//
//  HomeViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DiningCarViewController.h"
#import "BookViewController.h"
#import "OrderDetailViewController.h"
#import "BookDescViewController.h"
#import "PtOrderViewController.h"
#import "PayViewController.h"
#import "DinnerCarCell.h"
#import "DinnerCarSectionHeaderView.h"
#import "DinnerCarSectionBottomView.h"
#import "TotalBottomView.h"
#import "DinnerCartTool.h"
#import "dishInfoList.h"
#import "JSONKit.h"
#import "MBProgressHUD+MJ.h"
@interface DiningCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableDictionary *dataDict;
@property (nonatomic ,strong) NSMutableDictionary *moneyDict;
@property (nonatomic ,strong) NSMutableDictionary *packDict;
@property(nonatomic,strong)NSArray *dishInfoLists;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)TotalBottomView *bottomView;
@property(nonatomic,assign) BOOL isPacked;
@end

@implementation DiningCarViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableDictionary *)dataDict {
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}
- (NSMutableDictionary *)moneyDict {
    if (!_moneyDict) {
        _moneyDict = [NSMutableDictionary dictionary];
    }
    return _moneyDict;
}
- (NSMutableDictionary *)packDict {
    if (!_packDict) {
        _packDict = [NSMutableDictionary dictionary];
    }
    return _packDict;
}
- (NSArray *)dishInfoLists {
    if (!_dishInfoLists) {
        _dishInfoLists = [[NSArray alloc]init];
    }
    return _dishInfoLists;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订餐车";
    [self setupBottomView];
    [self setupTableView];

    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self LoadNewData];
}
- (void)LoadNewData {
    showUserCartParam *param = [[showUserCartParam alloc]init];
    param.userId = @27;
    __weak typeof(self) Weakself=self;
    [DinnerCartTool showUserCartWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSArray *data = json[@"list"];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in data) {
            showUserCartResult *result = [showUserCartResult objectWithKeyValues:dict];
            [tempArray addObject:result];
        }
        [Weakself.dataDict removeAllObjects];
        [Weakself.moneyDict removeAllObjects];
        [Weakself.packDict removeAllObjects];
        
        Weakself.dataArray =tempArray;
        [Weakself.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    tableView.rowHeight = 100;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomView withOffset:0];
}
- (void)setupBottomView {
    TotalBottomView *bottomView = [TotalBottomView bottomView];
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];
    [bottomView.totalOptionButton addTarget:self action:@selector(totalOptionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.bookButton addTarget:self action:@selector(bookButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.PtOrderButton addTarget:self action:@selector(ptOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.packButton addTarget:self action:@selector(packButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    self.bottomView = bottomView;
    [bottomView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [bottomView autoSetDimension:ALDimensionHeight toSize:44];
    
}
#pragma mark - UITableViewDelegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//   
//    return 1;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DinnerCarCell * cell = [DinnerCarCell cellWithTableView:tableView];
    cell.result = self.dataArray[indexPath.row];
    cell.selButton.selected = !self.bottomView.totalOptionButton.isSelected;
    __weak typeof(self) Weakself = self;
    cell.NumActionBlock = ^(NSInteger num ,CGFloat money ,NSNumber *key,BOOL isPack) {
        CGFloat addend  =num *money;
         [Weakself.dataDict setObject:[NSString stringWithFormat:@"%f",addend] forKey:[NSString stringWithFormat:@"%@",key]];
         [Weakself.moneyDict setObject:[NSString stringWithFormat:@"%f",money] forKey:[NSString stringWithFormat:@"%@",key]];
        [Weakself.packDict setObject:[NSString stringWithFormat:@"%@",isPack?@"YES":@"NO"] forKey:[NSString stringWithFormat:@"%@",key]];
        //得到词典中所有KEY值
        NSEnumerator * enumeratorKey = [self.dataDict keyEnumerator];
        //遍历所有KEY的值
        CGFloat total=0;
        NSInteger totalSingularInt = 0;
        NSInteger totalNums = 0;
        Weakself.isPacked = YES;
        NSMutableArray *temp = [NSMutableArray array];
        for (NSObject *object in enumeratorKey) {
            total+=[Weakself.dataDict[object] floatValue];
            totalNums +=1;
            if ([Weakself.dataDict[object] integerValue] !=0) {
                if (![Weakself.packDict[object] boolValue]) self.isPacked = NO;
                totalSingularInt +=1;
                dishInfoList *dish = [[dishInfoList alloc]init];
                dish.dishesInfoId =(NSNumber *) object;
                dish.shopPrice = [Weakself.moneyDict[object] floatValue];
                NSInteger count = [Weakself.dataDict[object] floatValue]/[Weakself.moneyDict[object] floatValue];
                dish.count = [NSNumber numberWithInteger:count];
                [temp addObject:dish];
            }
        }
        Weakself.dishInfoLists = temp;
        if (totalNums == totalSingularInt) {
            Weakself.bottomView.totalOptionButton.selected = YES;
        }else {
            Weakself.bottomView.totalOptionButton.selected = NO;
        }
        Weakself.bottomView.totalPriceLabel.text = [NSString stringWithFormat:@"%.1f",total];

    };
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        deleteUserCartParam *param = [[deleteUserCartParam alloc]init];
        showUserCartResult *result = self.dataArray[indexPath.row];
        param.userCartId = result.userCartsId;
        __weak typeof(self) Weakself=self;
       
        [DinnerCartTool deleteUserCartWithParam:param success:^(id json) {
            if ([json[@"code"] integerValue]) {
                //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
                return ;
            }
            [MBProgressHUD showSuccess:@"删除成功"];
            [Weakself.dataDict removeObjectForKey:[NSString stringWithFormat:@"%@",result.dishesInfoId]];
            [Weakself.moneyDict removeObjectForKey:[NSString stringWithFormat:@"%@",result.dishesInfoId]];
            [Weakself.dataArray removeObjectAtIndex:indexPath.row];
            if (!Weakself.dataArray.count) {
                Weakself.bottomView.totalPriceLabel.text = @"0.0";

            }
            [Weakself.tableView reloadData];
        } failure:^(NSError *error) {
        }];
    }
    
}
//设置编辑文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    return [DinnerCarSectionHeaderView headerView];
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 32;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//     return [DinnerCarSectionBottomView bottomView];
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//   
//    return 32;
//}
#pragma mark - action
- (void)totalOptionButtonClick:(UIButton *)btn {
    if (btn.isSelected) {
        btn.selected = NO;
        self.bottomView.totalPriceLabel.text = @"0.0";
    }else {
        btn.selected = YES;

    }
    [self.tableView reloadData];
}
- (void)bookButtonClick:(UIButton *)btn {
    
    BookDescViewController *decribe = [[BookDescViewController alloc]init];
    decribe.modalPresentationStyle = UIModalPresentationOverFullScreen;
    __weak typeof(self) Weakself = self;
    decribe.willBookBlock = ^{
        BookViewController *book = [[BookViewController alloc]init];
        book.dishInfoLists = Weakself.dishInfoLists;
        book.userCarts = [[self.dataArray valueForKeyPath:@"userCartsId"] componentsJoinedByString:@","];
        [Weakself.navigationController pushViewController:book animated:YES];
    };
    [self presentViewController:decribe animated:YES completion:nil];
}
- (void)ptOrderButtonClick:(UIButton *)btn {
    
    PtOrderViewController *order = [[PtOrderViewController alloc]init];
    order.modalPresentationStyle = UIModalPresentationOverFullScreen;
    __weak typeof(self) Weakself = self;
    order.willPayBlock = ^(NSString *text){
        addPtOrderParam *param = [[addPtOrderParam alloc]init];
        param.dishesInfoList = Weakself.dishInfoLists;
        param.tableNo = text;
        param.userId = @27;
        NSString * json = [NSString stringWithFormat:@"%@",[[param.keyValues JSONString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:json,@"json", nil];
        [DinnerCartTool addPtOrderWithParam:dict success:^(id json) {
            if ([json[@"code"] integerValue]) {
               UIAlertView *submitView = [[UIAlertView alloc] initWithTitle:nil message:json[@"msg"] delegate:Weakself cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [submitView show];
                return ;
            }
            addPtOrderResult *result = [[addPtOrderResult alloc]init];
            result.obj = json[@"obj"];
            
            OrderDetailViewController *orderVc = [[OrderDetailViewController alloc]init];
            orderVc.isPack = NO;
            orderVc.result = result;
            [self.navigationController pushViewController:orderVc animated:YES];

        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];

    };
    [self presentViewController:order animated:YES completion:nil];
}
- (void)packButtonClick:(UIButton *)btn {
    if (!self.isPacked) [MBProgressHUD showError:@"您选中有不可打包的菜品"];
    addPtOrderParam *param = [[addPtOrderParam alloc]init];
    param.dishesInfoList = self.dishInfoLists;
    param.userId = @27;
    NSString * json = [NSString stringWithFormat:@"%@",[[param.keyValues JSONString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:json,@"json", nil];
    [DinnerCartTool addWmOrderWithParam:dict success:^(id json) {
        if ([json[@"code"] integerValue]) {
            return ;
        }
        addPtOrderResult *result = [[addPtOrderResult alloc]init];
        result.obj = json[@"obj"];
        
        OrderDetailViewController *orderVc = [[OrderDetailViewController alloc]init];
        orderVc.isPack = YES;
        orderVc.result = result;
        [self.navigationController pushViewController:orderVc animated:YES];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

}

@end

