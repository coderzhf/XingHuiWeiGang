//
//  AccountTableViewCell.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *customerTitle;
@property (weak, nonatomic) IBOutlet UILabel *customerContent;
@property (weak, nonatomic) IBOutlet UIImageView *customerImg;
@property (weak, nonatomic) IBOutlet UILabel *customerTime;

@end
