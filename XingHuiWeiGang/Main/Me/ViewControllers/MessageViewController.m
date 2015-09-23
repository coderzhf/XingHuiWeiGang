//
//  MessageViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
//@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,assign) BOOL system;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息通知";
    _system = YES;
    
    UIView *headerView = [UQFactory viewWithFrame:KFrame(0, 0, KScreenWidth, 60) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:headerView];
    UISegmentedControl *segmentCtrl = [UQFactory segmentWithFrame:KFrame((KScreenWidth-160)/2, 15, 160, 30) items:@[@"系统消息",@"促销消息"]];
    [segmentCtrl addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:segmentCtrl];
    
    self.customTableView.frame = KFrame(0, headerView.bottom, KScreenWidth, KScreenHeight-headerView.bottom);
    self.customTableView.styleFlag = MessageStyle;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"吃货节优惠券",@"title",@"19.70",@"price",@"订单满90.00使用",@"detail", @"2015.01.15",@"date",nil];
    self.customTableView.array = @[dic];
    
}

- (void)chooseAction:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSInteger x = control.selectedSegmentIndex;
    if (x == 0) {//系统消息
        _system = YES;
    }else{//促销消息
        _system = NO;
    }
    [self.dataArray removeAllObjects];
    self.customTableView.array = self.dataArray;
    [self.customTableView reloadData];
}

- (void)LoadNewData
{
    NSString *url;
    if (_system) {
        url = nil;
    }else{
        url = nil;
    }
    [Utils post:url params:[NSDictionary dictionaryWithObjectsAndKeys:[UserDefaults objectForKey:@"userId"],@"userId",nil] success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
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
