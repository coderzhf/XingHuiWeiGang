//
//  BookOrderViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/27.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//
NSString * const OrderTypeNotification = @"OrderTypeNotification";
#import "BookOrderViewController.h"
#import "WMPageController.h"
#import "OrderWillPayViewController.h"
#import "OrderDidPayViewController.h"
@interface BookOrderViewController ()
@property (nonatomic, strong) WMPageController *pageController;
@end

@implementation BookOrderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    [self setupControllers];
    [[NSNotificationCenter defaultCenter]postNotificationName:OrderTypeNotification object:nil userInfo:@{@"OrderType":[NSString stringWithFormat:@"%@",self.orderType]}];
    
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
    self.pageController = pageController;
    
    //self.pageController.currentViewController
}


- (WMPageController *)getDefaultController{
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
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
                      default:
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.pageAnimatable = YES;
    pageVC.menuItemWidth = KScreenWidth/2;
    return pageVC;
}


@end
