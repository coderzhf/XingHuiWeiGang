//
//  CollectionViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/12.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "CollectionViewController.h"
#import "WMPageController.h"
#import "DishesCollectionViewController.h"
#import "ShopsCollectionViewController.h"
@interface CollectionViewController ()

@end

@implementation CollectionViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self setupControllers];
    
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
    for (int i = 0; i < 2; i++) {
        Class vcClass;
        NSString *title;
        switch (i) {
            case 0:
                vcClass = [DishesCollectionViewController class];
                title = @"菜品";
                break;
            case 1:
                vcClass = [ShopsCollectionViewController class];
                title = @"商铺";
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
