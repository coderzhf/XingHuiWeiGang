//
//  BookDateView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^bookDateBolck) (NSDate *selcetedDate);
@interface BookDateView : UIView

@property (nonatomic, copy)bookDateBolck dateBlock;
+ (instancetype)bookDateView;
- (void)showBookDateViewToView:(UIView *)superView;

@end
