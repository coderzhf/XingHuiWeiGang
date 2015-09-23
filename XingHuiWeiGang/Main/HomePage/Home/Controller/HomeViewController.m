//
//  HomeViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "HomeViewController.h"
#import "HomePageHeaderView.h"
#import "HomeSegmentView.h"
#import "HeaderSearchView.h"
#import "SearchListView.h"
#import "DishesTableViewCell.h"
#import "BaseTableViewController.h"
#import "DishesViewController.h"
#import "BusinessViewController.h"
#import "DishesSearchViewController.h"
#import "BusinessSearchViewController.h"
#import "PromotionViewController.h"
#import "DishesTableViewCell.h"
#import "DishDetailViewController.h"
#import "MBProgressHUD+MJ.h"
#import "DishTool.h"
#import "DiscountViewController.h"
#import "PackageViewController.h"

@interface HomeViewController ()<HomeSegementViewDelegate>
@property(nonatomic,strong)HomeSegmentView *sgementView;
@property(nonatomic,strong)HomePageHeaderView *headerView;
@property(nonatomic,strong)HeaderSearchView *searchView;
@property(nonatomic,strong)SearchListView *listView;
@property(nonatomic,assign)NSInteger selectTag;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)loadView {
    [super loadView];
}
- (void)viewDidLoad {
    self.cellClass=[DishesTableViewCell class];

    [super viewDidLoad];

    [self setupHeaderView];
    
    [self setupNav];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchOptionClick:) name:SearchOptionNotification object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    self.listView.hidden = YES;

}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark init
-(void)setupNav{
    self.title = @"首页";
    self.navigationItem.titleView = [UIButton buttonWithType:UIButtonTypeCustom];
    HeaderSearchView *searchView=[[HeaderSearchView alloc]init];
    searchView.frame=CGRectMake(KScreenWidth-200, KnavHeight-50, KScreenWidth-70, 44);
    searchView.placeholderText=@"请输入搜索内容";
    [searchView.textField addTarget:self action:@selector(textFieldSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [searchView.optionButton addTarget:self action:@selector(optionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:searchView];
    self.searchView = searchView;
    
    SearchListView *listView = [SearchListView listView];
    listView.hidden = YES;
    listView.userInteractionEnabled = YES;
    //[self.navigationController.navigationBar addSubview:listView];
    UIWindow *mainWindow = [[UIApplication sharedApplication].windows lastObject];
    [mainWindow addSubview:listView];
    listView.top = self.navigationController.navigationBar.height;
    self.listView = listView;
    
    UIButton *search=[UIButton buttonWithType:UIButtonTypeCustom];
    [search setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [search addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    search.width=25;
    search.height=25;
    search.contentMode=UIViewContentModeCenter;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:search];

}
-(void)setupHeaderView{
  
    HomePageHeaderView *header = [HomePageHeaderView headerView];
    self.tableView.tableHeaderView = header;
    self.headerView=header;
    
   [header.dishButton addTarget:self action:@selector(dishesButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [header.businessButton addTarget:self action:@selector(businessButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [header.salesButton addTarget:self action:@selector(salesButtonClick) forControlEvents:UIControlEventTouchUpInside];
     [header.discountButton addTarget:self action:@selector(discountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [header.pickButton addTarget:self action:@selector(pickButtonClick) forControlEvents:UIControlEventTouchUpInside];
    header.segementView.delegate = self;
   
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

#pragma mark HomeSegementViewDelegate
-(void)HomeSegementWithTag:(NSInteger)tag{

    ShowDishesParam *param = [[ShowDishesParam alloc]init];
    if (tag == HomeSegmentHotDishes) {
        param.isHot = @1;

    } else if(tag == HomeSegmentHotBusiness) {
        param.isRecommend = @1;

    }
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

#pragma action
//点击点菜按钮
-(void)dishesButtonClick{
    DishesViewController *dishes=[[DishesViewController alloc]init];
    [self.navigationController pushViewController:dishes animated:YES];
}
//点击商铺按钮
-(void)businessButtonClick{
    BusinessViewController *dishes=[[BusinessViewController alloc]init];
    [self.navigationController pushViewController:dishes animated:YES];
}
//点击促销按钮
- (void)salesButtonClick {
    
    PromotionViewController *promotion=[[PromotionViewController alloc]init];
    [self.navigationController pushViewController:promotion animated:YES];
}
//点击优惠券按钮
-(void)discountButtonClick{
    DiscountViewController *discounts=[[DiscountViewController alloc]init];
    //从首页入口进优惠券，显示所有商家的优惠券
    discounts.isAll = YES;
    [self.navigationController pushViewController:discounts animated:YES];
}

//点击打包按钮
- (void)pickButtonClick {
    PackageViewController *package=[[PackageViewController alloc]init];
    [self.navigationController pushViewController:package animated:YES];
}
//点击搜索按钮
-(void)messageClick{

    [self textFieldSearch:self.searchView.textField];
}
- (void)textFieldSearch:(UITextField *)field {
    if (field.text == nil || field.text.length ==0) {
        [MBProgressHUD showError:@"请输入搜索的关键词"];
        return;
    }

    if ([self.searchView.optionLabel.text isEqualToString:@"菜品"]) {
        NSString *dishName = [NSString stringWithFormat:@"%@",[field.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        DishesSearchViewController *dishSearchVc = [[DishesSearchViewController alloc]init];
        dishSearchVc.dishName = dishName;
        [self.navigationController pushViewController:dishSearchVc animated:YES];
    }else {
        NSString *shopName = [NSString stringWithFormat:@"%@",[field.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        BusinessSearchViewController *bussinessSearchVc = [[BusinessSearchViewController alloc]init];
        bussinessSearchVc.shopName = shopName;
        [self.navigationController pushViewController:bussinessSearchVc animated:YES];
    }
}
- (void)optionButtonClick {
    
    self.listView.hidden = !self.listView.isHidden;
}
- (void)searchOptionClick:(NSNotification *)note {
    self.searchView.optionLabel.text = note.userInfo[SearchOptionName];
    [self optionButtonClick];
}
@end
