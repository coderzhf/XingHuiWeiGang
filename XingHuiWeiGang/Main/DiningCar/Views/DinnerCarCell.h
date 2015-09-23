//
//  DinnerCarCell.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/23.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "showUserCartResult.h"
@interface DinnerCarCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)showUserCartResult *result;
@property(nonatomic,assign)BOOL isSelected;
@property (nonatomic , copy) void (^NumActionBlock)(NSInteger num ,CGFloat money ,NSNumber * key,BOOL isPack);
@property (weak, nonatomic) IBOutlet UIButton *selButton;

@end
