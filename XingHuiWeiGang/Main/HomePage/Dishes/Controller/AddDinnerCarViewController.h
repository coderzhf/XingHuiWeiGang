//
//  AddDinnerCarViewController.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/21.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DishDetailResult.h"
@interface AddDinnerCarViewController : UIViewController
@property(nonatomic,strong)DishDetailResult *dishDetailResult;
@property (strong, nonatomic) IBOutlet UIImageView *thumbPic;
@end
