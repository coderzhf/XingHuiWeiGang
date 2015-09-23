//
//  BaseTableViewController.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface BaseTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *dataArray;
@property(nonatomic,strong)MJRefreshFooterView *foot;
@property(nonatomic,strong)MJRefreshHeaderView *header;
@property (nonatomic, assign) NSInteger sectionsNumber;
@property (nonatomic, copy) Class cellClass;
@property (nonatomic, copy) Class cellModelClass;
@property (nonatomic, copy) Class cellClassTwo;
@property (nonatomic, copy) Class cellModelClassTwo;
@property (nonatomic,assign) BOOL cellOneHiden;
@property (nonatomic,assign) BOOL cellTwoHiden;
//上拉加载更多数据
-(void)LoadMoreData;
//下拉更新数据
-(void)LoadNewData;
@end
