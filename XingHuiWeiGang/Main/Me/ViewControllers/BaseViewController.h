//
//  BaseViewController.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/13.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableView.h"

@interface BaseViewController : UIViewController
@property (nonatomic ,strong) CustomTableView *customTableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;

@property(nonatomic,strong)MJRefreshFooterView *foot;
@property(nonatomic,strong)MJRefreshHeaderView *header;
@property(nonatomic,assign)NSInteger pageNum;

//上拉加载更多数据
-(void)LoadMoreData;
//下拉更新数据
-(void)LoadNewData;

@end
