//
//  BaseTableViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewCell.h"
@interface BaseTableViewController ()<MJRefreshBaseViewDelegate>

@end

@implementation BaseTableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.rowHeight=100;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:(245 / 255.0) green:(245 / 255.0) blue:(245 / 255.0) alpha:1];
    self.dataArray=[[NSArray alloc]init];
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:[self.cellClass description]];
    if (self.cellClassTwo) {
        [self.tableView registerClass:self.cellClassTwo forCellReuseIdentifier:[self.cellClassTwo description]];
    }
    [self setupRefreshView];
    
    
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
   // [self.tableView registerClass:self.cellClass forCellReuseIdentifier:[self.cellClass description]];
    [self.header endRefreshing];
    [self.foot endRefreshing];
    [self.tableView reloadData];
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return (self.sectionsNumber)?self.sectionsNumber:1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!self.dataArray.count) {
        return 0;
    }
     NSInteger number = (self.sectionsNumber==0) ? self.dataArray.count : [self.dataArray[section] count];
    return number;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell;
    if (self.sectionsNumber == 0) {
        cell= [tableView dequeueReusableCellWithIdentifier:[self.cellClass description]forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
    } else{
        if (indexPath.section==0) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:[self.cellClass description]forIndexPath:indexPath];
            cell.hidden = self.cellOneHiden;
            cell.model = [self.dataArray[0] objectAtIndex:indexPath.row];

        } else if (indexPath.section==1){
            cell = [tableView dequeueReusableCellWithIdentifier:[self.cellClassTwo description]forIndexPath:indexPath];
            cell.hidden = self.cellTwoHiden;
            cell.model = [self.dataArray[1] objectAtIndex:indexPath.row];
        }
        
    }

    return cell;
}
#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

//刷新控件
-(void)setupRefreshView{
    //顶部 下拉控件
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.tableView;
    header.delegate=self;
    self.header=header;
    //初次登陆加载数据
    [self LoadNewData];
    //底部 上拉控件
    MJRefreshFooterView *foot=[MJRefreshFooterView footer];
    foot.scrollView=self.tableView;
    foot.delegate=self;
    self.foot=foot;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}
-(void)dealloc{
    //释放上拉刷新控件
    [self.foot free];
    [self.header free];
}
#pragma mark MJRefreshBaseViewDelegate
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {//加载更多数据 上拉

        [self LoadMoreData];
    }else{//加载更新数据 下拉
       // [self.header beginRefreshing];
        [self LoadNewData];

    }
}
//上拉加载更多数据
-(void)LoadMoreData{
    
}
-(void)LoadNewData{
    
}

@end
