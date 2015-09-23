//
//  BaseViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/13.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<MJRefreshBaseViewDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomTableView *tableView = [[CustomTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _customTableView = tableView;
    [self.view addSubview:tableView];
    
    [self setupRefreshView];
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    _customTableView.array = _dataArray;
}
//刷新控件
-(void)setupRefreshView{
    //顶部 下拉控件
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.customTableView;
    header.delegate=self;
    self.header=header;
    //初次登陆加载数据
    [self LoadNewData];
    //底部 上拉控件
    MJRefreshFooterView *foot=[MJRefreshFooterView footer];
    foot.scrollView=self.customTableView;
    foot.delegate=self;
    self.foot=foot;
    
}

- (void)setCustomTableView:(CustomTableView *)customTableView
{
    _customTableView = customTableView;
    //每次有新数据传递过来就刷新表视图
    [_customTableView reloadData];
}
#pragma mark MJRefreshBaseViewDelegate
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {//加载更多数据 上拉
        [self LoadMoreData];
    }else{//加载更新数据 下拉
        [self LoadNewData];
    }
}
//上拉加载更多数据
-(void)LoadMoreData{
    [self.foot endRefreshing];
    
}
-(void)LoadNewData{
    
}

-(void)dealloc{
    //释放上拉刷新控件
    [self.foot free];
    [self.header free];
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
