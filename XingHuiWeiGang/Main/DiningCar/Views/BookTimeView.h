//
//  BookTimeView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^bookTimeBlcok)(NSNumber *ID ,NSString *typeName);
@interface BookTimeView : UIView

@property (nonatomic, strong)NSArray *modelArray;
@property (nonatomic, copy) bookTimeBlcok block;
+ (instancetype)bookTimeView;
- (void)showBookTimeViewToView:(UIView *)superView;

@end
