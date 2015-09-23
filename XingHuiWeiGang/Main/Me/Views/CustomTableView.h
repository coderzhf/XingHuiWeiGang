//
//  CustomTableView.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSInteger, tableViewStyle){
    AccountStyle,
    MessageStyle,
    DiscountStyle,
};

@interface CustomTableView : UITableView<UITableViewDelegate ,UITableViewDataSource>

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,assign)tableViewStyle styleFlag;//为yes时是优惠券，为no时是消息

@end
