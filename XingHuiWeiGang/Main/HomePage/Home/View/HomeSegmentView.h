//
//  HomeSegmentView.h
//  ZhenMeiShiDaiApp
//
//  Created by 张锋 on 15/6/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleButton;
typedef enum{
    HomeSegmentHotDishes,//热门菜式0
    HomeSegmentHotBusiness,//热门商户1
    BussinessHotDishes,//店铺 - 热门菜系
    BussinessNewDishes,//最新排序
    BussinessPriceDishes,//价格排序
    BussinessChoiceDishes//筛选

}HomeSegmentButtonType;

@protocol HomeSegementViewDelegate <NSObject>

@optional
-(void)HomeSegementWithTag:(NSInteger)tag;

@end
@interface HomeSegmentView : UIView
@property(nonatomic,weak)id<HomeSegementViewDelegate>delegate;
-(void)AddButtonWithTitle:(NSString *)title Type:(HomeSegmentButtonType)type;
+(instancetype)initButtonWithTitleArray:(NSArray *)titles type:(NSArray *)types;
@property(nonatomic,copy) void(^chooceTypeBlock)(BOOL isSelcted);
@property(nonatomic,strong) TitleButton *choiceButton;

@end
