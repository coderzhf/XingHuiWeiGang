//
//  DishFilterView.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/26.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DishFilterViewDelegate <NSObject>

@optional
/**
 *  点击tableview，过滤id
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withId:(NSNumber *)ID withName:(NSString *)name isCuisine:(BOOL )isCuisine;

@end

@interface DishFilterView : UIView
+ (instancetype)filterView;
@property (nonatomic, assign) BOOL isCuisine;
@property (nonatomic, weak) id <DishFilterViewDelegate> delegate;
@end
