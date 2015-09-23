//
//  OrderViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderViewController.h"
#import "WMPageController.h"
#import "OrderDidCancelViewController.h"
#import "OrderDidFinishViewController.h"
#import "OrderDidPayViewController.h"
#import "OrderDidRefundViewController.h"
#import "OrderWillPayViewController.h"
@interface OrderViewController ()

@end

@implementation OrderViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    [self setupControllers];
     [[NSNotificationCenter defaultCenter]postNotificationName:OrderTypeNotification object:nil userInfo:@{@"OrderType":@"18"}];

}

- (void)setupControllers {
    WMPageController *pageController = [self getDefaultController];
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 15;
    pageController.titleColorSelected = YXRGB(246, 84, 18);
    pageController.menuBGColor = [UIColor whiteColor];
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    
    [pageController.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}


- (WMPageController *)getDefaultController{
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [OrderWillPayViewController class];
                title = @"待付款";
                break;
            case 1:
                vcClass = [OrderDidPayViewController class];
                title = @"已付款";
                break;
            case 2:
                vcClass = [OrderDidFinishViewController class];
                title = @"已完成";
                break;
            case 3:
                vcClass = [OrderDidRefundViewController class];
                title = @"已退款";
                break;
            case 4:
                vcClass = [OrderDidCancelViewController class];
                title = @"已取消";
                break;
            default:
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.pageAnimatable = YES;
    pageVC.menuItemWidth = KScreenWidth/5;
    return pageVC;
}
@end
