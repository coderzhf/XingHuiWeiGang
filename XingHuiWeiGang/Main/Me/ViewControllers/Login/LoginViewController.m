//
//  LoginViewController.m
//  login
//
//  Created by 张锋 on 15/7/8.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "FindPwdViewController.h"
#import "LoginViews.h"

@interface LoginViewController ()
{
    UIScrollView *scrollView;
    LoginViews *view;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgView = [UQFactory imageViewWithFrame:KFrame(0, 0, KScreenWidth, KScreenHeight/3+10) image:KImage(@"yx_login_Bg") contentMode:0 userInteractionEnabled:YES];
    [self.view addSubview:bgView];
    UILabel *titleLabel = [UQFactory labelWithFrame:KFrame((KScreenWidth-100)/2, KnavHeight-35,100 , 20) text:@"登录" textColor:[UIColor whiteColor] fontSize:18 center:YES];
    [bgView addSubview:titleLabel];
    UIButton *backButton = [UQFactory buttonWithFrame:KFrame(15, KnavHeight-35, 11, 20) backgroundImage:KImage(@"yx_return_Btn")];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:backButton];
    
    scrollView = [[UIScrollView alloc] initWithFrame:KFrame(0, bgView.bottom, KScreenWidth, KScreenHeight*2/3)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight*1.3);
    [self.view addSubview:scrollView];

    view = [LoginViews instanceWithFrame:KFrame(0, 0, KScreenWidth, KScreenHeight*2/3)];
    view.isSelected = YES;
    [scrollView addSubview:view];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [view textFieldResign];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}



@end
