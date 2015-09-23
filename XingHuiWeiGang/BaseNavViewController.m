//
//  BaseNavViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

+(void)initialize{
    //1.设置导航栏主题
    //appearance得到导航栏外观属性，可同时修改属性
    UINavigationBar *bar=[UINavigationBar appearance];
    NSMutableDictionary *title=[NSMutableDictionary dictionary];
    title[NSFontAttributeName]=[UIFont boldSystemFontOfSize:16];
    title[NSForegroundColorAttributeName]=[UIColor whiteColor];
    [bar setBackgroundImage:[UIImage imageNamed:@"yx_nav_Bg"] forBarMetrics:UIBarMetricsDefault];
    bar.tintColor=[UIColor whiteColor];
    
    [bar setTitleTextAttributes:title];
    
    //2.设置导航栏按钮主题
    UIBarButtonItem *button=[UIBarButtonItem appearance];
    NSMutableDictionary *Btntitle=[NSMutableDictionary dictionary];
    Btntitle[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    Btntitle[NSForegroundColorAttributeName]=[UIColor orangeColor];
    Btntitle[NSForegroundColorAttributeName]=[UIColor whiteColor];
    [button setTitleTextAttributes:Btntitle forState:UIControlStateNormal];
    
//    UIButton *rightButton = [UQFactory buttonWithFrame:KFrame(0, 0, 40, 30) backgroundImage:KImage(@"")];
//    [rightButton addTarget:self action:@selector(popToRootVC) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    UINavigationItem *button1=[UINavigationItem appearance];
//    button1.rightBarButtonItem = item;
//
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)popToRootVC
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //排除根控制器以外的push控制器对象
    if (self.viewControllers.count>0) {
        //隐藏push新控制器的底部导航栏
       // viewController.hidesBottomBarWhenPushed=YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
