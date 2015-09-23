//
//  ViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "ShakeViewController.h"
#import "DiningCarViewController.h"
#import "MeViewController.h"
#import "BaseNavViewController.h"
#import "PackageViewController.h"
#import "ChangeInforViewController.h"
#import "LoginViewController.h"

#import "ShakeViewControllerHelp.h"

@interface ViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate>
{
    UIScrollView *_scrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建tarBar
    [self initTabbarView];
    //创建子控制器
    [self initViewControllers];
    //启动欢迎页
    [self initWelcomePage];
}

- (void)initTabbarView
{
    _tabbarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KScreenHeight - KTarBarHeight, KScreenWidth, KTarBarHeight)];
    _tabbarView.image = [UIImage imageNamed:@"tabbar_bottom"];
    _tabbarView.userInteractionEnabled = YES;
    [self.view addSubview:_tabbarView];
    
    float itemWidth = KScreenWidth/4;
    NSArray *itemsNormal = @[@"bar_home_unselected",
                             @"bar_order_unselected",
                             @"bar_dinnercar_unselected",
                             @"bar_mine_unselected"];
    
    NSArray *itemsHighLight =   @[@"bar_home_selected",
                                  @"bar_order_selected",
                                  @"bar_dinnercar_selected",
                                  @"bar_mine_selected"];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*itemWidth, 0, itemWidth, KTarBarHeight);
        [button setBackgroundImage:[UIImage imageNamed:itemsNormal[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:itemsHighLight[i]] forState:UIControlStateDisabled];
        [button setBackgroundImage:[UIImage imageNamed:itemsNormal[i]] forState:UIControlStateHighlighted];
        if (i == 0) {
            button.enabled = NO;
        }
        button.tag = 100 + i;
        [button addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
    }
}

- (void) initViewControllers
{
    HomeViewController *homePageVC = [[HomeViewController alloc] init];
    ShakeViewController *shakeVC = [[ShakeViewController alloc] init];
    DiningCarViewController *diningVC = [[DiningCarViewController alloc] init];
    MeViewController *meVC = [[MeViewController alloc] init];
    NSArray *controllers = @[homePageVC,shakeVC,diningVC,meVC];
    
    for (UIViewController *vc in controllers) {
        BaseNavViewController *navVC = [[BaseNavViewController alloc] initWithRootViewController:vc];
        navVC.delegate = self;
        [self addChildViewController:navVC];
    }
    UIViewController *firstVC = [self.childViewControllers objectAtIndex:0];
    
    //最开始时使首页显示出来
    [self.view insertSubview:firstVC.view belowSubview:_tabbarView];
}

- (void)changeVC:(UIButton *)item
{
    self.selectedIndex = item.tag - 100;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    UIButton *button = (UIButton *)[self.view viewWithTag:selectedIndex + 100];
    button.enabled = NO;
    UIButton *Prebutton = (UIButton *)[self.view viewWithTag:_selectedIndex + 100];
    if (selectedIndex != _selectedIndex) {
        
        Prebutton.enabled = YES;
        //获取点击之前显示的控制器
        UIViewController *previousVC = [self.childViewControllers objectAtIndex:self.selectedIndex];
        UIViewController *currentVC = [self.childViewControllers objectAtIndex:selectedIndex];
        [self.view insertSubview:currentVC.view belowSubview:_tabbarView];
        [UIView transitionFromView:previousVC.view toView:currentVC.view duration:.35 options:UIViewAnimationOptionTransitionNone completion:^(BOOL finished) {
            //之前显示的控制器从父视图移除
            [previousVC.view removeFromSuperview];
        }];
        
    }
    _selectedIndex = selectedIndex;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[HomeViewController class]]|| [viewController isKindOfClass:[ShakeViewController class]] || [viewController isKindOfClass:[DiningCarViewController class]] || [viewController isKindOfClass:[MeViewController class]] || [viewController isKindOfClass:[PackageViewController class]]) {
        navigationController.view.height = KScreenHeight-KTarBarHeight;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        [self.view addSubview:_tabbarView];
        [UIView commitAnimations];
        
    }else {
        navigationController.view.height = KScreenHeight;
        [UIView beginAnimations:Nil context:Nil];
        [UIView setAnimationDuration:.5];
        [_tabbarView removeFromSuperview];
        [UIView commitAnimations];
    }
    if ([viewController isKindOfClass:[MeViewController class]] ||[viewController isKindOfClass:[ChangeInforViewController class]] ||[viewController isKindOfClass:[LoginViewController class]]||[viewController isKindOfClass:[ShakeViewController class]]) {
        navigationController.navigationBarHidden = YES;
    }else{
        navigationController.navigationBarHidden = NO;
    }
    if ([viewController isKindOfClass:[ShakeViewController class]]) {
        ShakeViewControllerHelp *shakeHelpInstance = [ShakeViewControllerHelp shareShakeVCHelp];
        [viewController.view addGestureRecognizer:shakeHelpInstance.pan];
        [viewController.view addGestureRecognizer:shakeHelpInstance.sideslipTapGes];
    }
    
}

- (void)initWelcomePage
{
    NSString *value = [UserDefaults objectForKey:@"isFirstLogin"];
    if (value == nil) {
        _tabbarView.hidden = YES;
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        [self.view addSubview:_scrollView];
        _scrollView.contentSize=CGSizeMake(KScreenWidth*3, KScreenHeight);
        for (int i=0; i<3; i++) {
            NSString *imageName=[NSString stringWithFormat:@"guide%d",i+1];
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.width*i, 0, self.view.width, self.view.height) ];
            imageView.image=[UIImage imageNamed:imageName];
            [_scrollView addSubview:imageView];
        }
        _scrollView.pagingEnabled=YES;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.delegate=self;
        
         [UserDefaults setObject:@"YES" forKey:@"isFirstLogin"];
    }
}

#pragma - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x/self.view.width;
    if (index >1) {
        [self performSelector:@selector(removeFromSuperviewTwo) withObject:Nil afterDelay:.2];
    }
}

- (void)removeFromSuperviewTwo
{
    [_scrollView removeFromSuperview];
    _tabbarView.hidden = NO;;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
