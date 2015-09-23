//
//  PackageViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/24.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "PackageViewController.h"
#import "HeaderSearchView.h"
#import "DishDetailViewController.h"

#import "DishesSearchViewController.h"
#import "DishesTableViewCell.h"
#import "ShowDishesResult.h"

@interface PackageViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
@property(nonatomic,strong)HeaderSearchView *searchView;
@property (nonatomic,strong) NSMutableArray  *dataArray;//菜品列表数据
@property (nonatomic,strong) NSArray  *kindArray;//菜种类列表数据

@property (nonatomic,strong) UIButton  *lastBtn;
@property (nonatomic,strong) NSMutableDictionary  *mDic;

@property(nonatomic,strong)MJRefreshFooterView *foot;
@property(nonatomic,strong)MJRefreshHeaderView *header;
@property(nonatomic,assign)NSInteger pageNum;

@end

@implementation PackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _mDic = [NSMutableDictionary dictionary];
    [self setupNav];
    [self setupViews];
    [self loadKindData];
    [self setupRefreshView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchView.textField resignFirstResponder];
}

- (void)setupNav
{
    self.navigationItem.titleView = [UIButton buttonWithType:UIButtonTypeCustom];
    HeaderSearchView *searchView=[[HeaderSearchView alloc]init];
    searchView.frame=CGRectMake(KScreenWidth-200, KnavHeight-50, KScreenWidth-80, 44);
    searchView.placeholderText=@"搜索菜名";
    searchView.optionButton.hidden = YES;
    searchView.optionLabel.hidden = YES;
    [searchView.textField addTarget:self action:@selector(textFieldSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:searchView];
    self.searchView = searchView;
    
    UIButton *package=[UQFactory buttonWithFrame:KFrame(0, 0, 11, 20) backgroundImage:KImage(@"yx_return_Btn")];
    [package addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:package];
}

- (void)setupViews
{
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.height = KScreenHeight-50-KTarBarHeight;
    self.lastBtn = self.defalutBtn;
    self.defalutBtn.enabled = NO;
    [self.defalutBtn addTarget:self action:@selector(selectViewControllers:) forControlEvents:UIControlEventTouchUpInside];
    [self.salesBtn addTarget:self action:@selector(selectViewControllers:) forControlEvents:UIControlEventTouchUpInside];
    [self.priceBtn addTarget:self action:@selector(selectViewControllers:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)loadKindData
{
    [Utils post:showDishesType params:nil success:^(id json) {
        if ([[json objectForKey:@"code"] boolValue]) {
            [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        self.kindArray = [json objectForKey:@"list"];
        self.leftTableView.height = 50*_kindArray.count;
        [self.leftTableView reloadData];
    } failure:^(NSError *error) {
        [Notifier UQToast:self.view text:@"请求出错，请稍后再试" timeInterval:NyToastDuration];

    }];
}

- (void)LoadNewData
{
    self.mDic[@"pageNoStr"]=@1;
    self.mDic[@"pageSizeStr"]= @10;
    self.mDic[@"isPack"]=@"Yes";
    [Utils post:showAllDishesInfo params:self.mDic success:^(id json) {
        if ([[json objectForKey:@"code"] boolValue]) {
            [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in [json objectForKey:@"list"]) {
            ShowDishesResult *result = [ShowDishesResult objectWithKeyValues:dic];
            [temp addObject:result];
        }
        self.dataArray = temp;

        self.pageNum++;
        [self.mDic removeAllObjects];
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        [Notifier UQToast:self.view text:@"请求出错，请稍后再试" timeInterval:NyToastDuration];
    }];
}

- (void)loadMoreData
{
    self.mDic[@"pageNoStr"]=[NSNumber numberWithInteger:self.pageNum];
    self.mDic[@"pageSizeStr"]= @10;
    self.mDic[@"isPack"]=@"Yes";
    [Utils post:showAllDishesInfo params:self.mDic success:^(id json) {
        if ([[json objectForKey:@"code"] boolValue]) {
            [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in [json objectForKey:@"list"]) {
            ShowDishesResult *result = [ShowDishesResult objectWithKeyValues:dic];
            [temp addObject:result];
        }
        [self.dataArray addObjectsFromArray:temp];
        self.pageNum++;
        [self.mDic removeAllObjects];
        [self.foot endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}

- (void)selectViewControllers:(UIButton *)btn
{
    self.lineLabel.left = btn.left;
    self.lastBtn.enabled = YES;
    switch (btn.tag) {
        case 2://默认
            break;
        case 3://销量
            //self.mDic[]
            break;
            
        case 4://价格
           self.mDic[@"isPrice"]= @"Yes";
           self.mDic[@"isSale"]= @"Yes";

            break;
            
        default:
            break;
    }
    self.lastBtn = btn;
    self.lastBtn.enabled = NO;
    [self LoadNewData];

}
- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    [self.rightTableView reloadData];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView.tag==10 ? self.kindArray.count : _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==10) {
        static NSString *ID = @"tasteCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            UILabel *grayLabel = [[UILabel alloc] initWithFrame:KFrame(0, 50, 80, 1)];
            grayLabel.backgroundColor = YXRGB(230, 230, 230);
            [cell.contentView addSubview:grayLabel];
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:UIEdgeInsetsZero];}
            
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsZero];}
        }
        NSString *text = [self.kindArray[indexPath.row] objectForKey:@"typeName"];
        cell.textLabel.text = text;
        return cell;
    }else
    {
        static NSString *ID = @"tabkeOutLeftCell";
        DishesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[DishesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
}
#pragma mark - tableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 10) {
        UIImageView *headImg = [UQFactory imageViewWithFrame:KFrame(0, 0, 80, 50) image:nil];
        UILabel *label = [UQFactory labelWithFrame:KFrame(0, 10, 80, 30) text:@"推荐菜品"textColor:[UIColor darkGrayColor] fontSize:16 center:YES];
        [headImg addSubview:label];
        UILabel *orangeLabel = [[UILabel alloc] initWithFrame:KFrame(0, 5, 2, 40)];
        orangeLabel.backgroundColor = YXRGB(246, 84, 18);
        [headImg addSubview:orangeLabel];
        UILabel *grayLabel = [[UILabel alloc] initWithFrame:KFrame(0, 50, 80, 1)];
        grayLabel.backgroundColor = YXRGB(230, 230, 230);
        [headImg addSubview:grayLabel];
        return headImg;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 10) {
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.tag== 10 ? 50:100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag ==10) {
        //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
       // cell.contentView.backgroundColor = [UIColor orangeColor];
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        NSNumber *typeId = [self.kindArray[indexPath.row] objectForKey:@"id"];
        self.mDic[@"tasteId"] = typeId;
        [self LoadNewData];
    }else {
        ShowDishesResult *result = self.dataArray[indexPath.row];
        DishDetailViewController *detail = [[DishDetailViewController alloc] init];
        detail.dishesInfoId=result.dishesInfoId;
        [self.navigationController pushViewController:detail animated:NO];
    }
}

//刷新控件
-(void)setupRefreshView{
    //顶部 下拉控件
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.rightTableView;
    header.delegate=self;
    self.header=header;
    //初次登陆加载数据
    [self LoadNewData];
    //底部 上拉控件
    MJRefreshFooterView *foot=[MJRefreshFooterView footer];
    foot.scrollView=self.rightTableView;
    foot.delegate=self;
    self.foot=foot;
}

#pragma mark MJRefreshBaseViewDelegate
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {//加载更多数据 上拉
        
        [self loadMoreData];
    }else{//加载更新数据 下拉
        // [self.header beginRefreshing];
        [self LoadNewData];
        
    }
}

-(void)dealloc{
    //释放上拉刷新控件
    [self.foot free];
    [self.header free];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldSearch:(UITextField *)field {
    
    NSString *dishName = [NSString stringWithFormat:@"%@",[field.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    DishesSearchViewController *dishSearchVc = [[DishesSearchViewController alloc]init];
    dishSearchVc.dishName = dishName;
    [self.navigationController pushViewController:dishSearchVc animated:YES];
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
