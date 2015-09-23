//
//  SettingViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YXRGB(240, 240, 240);
    if (self.flag == 1) {//帮助
        self.title = @"帮助信息";
    }else if (self.flag == 2){//平台
        self.title = @"平台简介";
    }else{//投诉
        self.title = @"投诉建议";
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:KFrame(0, 0, KScreenWidth, 250)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
