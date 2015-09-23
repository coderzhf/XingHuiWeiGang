//
//  ShakeDishTableViewCell.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
@interface ShakeDishTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishes;
@property (weak, nonatomic) IBOutlet StarView *startView;

@property (weak, nonatomic)  NSString  *imgStr;
@property (weak, nonatomic)  NSString  *dishStr;
@property (nonatomic ,strong) NSNumber *rate;

@end
