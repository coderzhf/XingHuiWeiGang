//
//  OrderBaseTableViewController.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString * const OrderTypeNotification;
typedef NS_ENUM(NSInteger, OrderStatus)
{
    OrderStatusWillPay           = 1,
    OrderStatusDidPay            = 1 << 1,
    OrderStatusDidFinished       = 1 << 2,
    OrderStatusDidRefund         = 1 << 4,
    OrderStatusDidCancel         = 1 << 5
};

typedef NS_ENUM(NSInteger, OrderType)
{
    OrderTypeCommen    = 18,
    OrderTypeAddNu     = 19,
    OrderTypePick      = 20,
    OrderBook          = 21,
};
@interface OrderBaseTableViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *markArray;
@property (nonatomic, copy) Class cellClass;
@property (nonatomic, assign)OrderStatus orderStatus;
@property (nonatomic, strong) UITableView *tableView;

@end
