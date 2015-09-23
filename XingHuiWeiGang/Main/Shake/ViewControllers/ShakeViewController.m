//
//  PackageViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "ShakeViewController.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ShakeView.h"
#import "ShakeViewControllerHelp.h"


@interface ShakeViewController ()
{
    SystemSoundID soundID;
}
@property (nonatomic ,strong)UIImageView *shakeImg;
@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIImageView *img = [UQFactory imageViewWithFrame:KFrame(0, 0, KScreenWidth, KScreenHeight-KTarBarHeight) image:KImage(@"yx_shake_bottom")];
    [self.view addSubview:img];
    self.shakeImg = img;
    
    UIButton *ruleBtn = [UQFactory buttonWithFrame:KFrame(5, 20, 50, 50) backgroundImage:KImage(@"yx_rule_btn")];
    [ruleBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ruleBtn];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)action
{
    ShakeViewControllerHelp *shakeVCInstance = [ShakeViewControllerHelp shareShakeVCHelp];
    [shakeVCInstance showLeftView];
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //检测用户是否登陆，登陆成功可体验摇一摇检测到摇动
    NSLog(@"检测到摇动");
    if ([UserDefaults objectForKey:@"isLogin"]) {
        if (event.subtype == UIEventSubtypeMotionShake) {
            [self addAnimations];
            AudioServicesPlaySystemSound (soundID);}
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没登陆不能体验摇一摇功能，请先登陆" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动结束
    NSLog(@"摇动结束");
    //获取随机数，，请求接口
    if ([UserDefaults objectForKey:@"isLogin"]) {
      int count = arc4random() % 1000;
      [Utils post:yaoDishesInfo params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:count],@"count",[UserDefaults objectForKey:@"userId"],@"userId", nil] success:^(id json) {
          if ([[json objectForKey:@"code"] unsignedIntValue] == -1 ){
              [Notifier UQToast:AppWindow text:@"系统错误，请您稍后再试" timeInterval:NyToastDuration];}
          
          ShakeView *shakeView = [[ShakeView alloc] initWithFrame:KFrame((KScreenWidth-300)/2, 0, 300, 380)];
          shakeView.center = self.view.center;
          [self.view addSubview:shakeView];
   
        if ([[json objectForKey:@"code"] unsignedIntValue] == 1 ) {//菜品
                shakeView.flag = 1;
                shakeView.listArray = [json objectForKey:@"list"];
                [shakeView.listTableView reloadData];
        }else if ([[json objectForKey:@"code"] unsignedIntValue] == 2){//优惠券
            NSDictionary *dic = [json objectForKey:@"list"];
            shakeView.denomination = dic[@"denomination"];
            shakeView.startTime = dic[@"startTime"];
            shakeView.stopTime = dic[@"stopTime"];
            shakeView.desc = dic[@"desc"];

            shakeView.flag = 2;
        }else if([[json objectForKey:@"code"] unsignedIntValue] == -2){//空
            shakeView.flag = -2;
            
        }
        
     }failure:^(NSError *error) {
        [Notifier UQToast:AppWindow text:@"系统错误，请您稍后再试" timeInterval:NyToastDuration];}];
      }
}

-(void)addAnimations
{
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    translation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_4, 0, 0, 100)];
    
    translation.duration = 0.15;
    translation.repeatCount = 2;
    translation.autoreverses = YES;
    
    [_shakeImg.layer addAnimation:translation forKey:@"translation"];
}

- (BOOL)canBecomeFirstResponder {//默认是NO，所以得重写此方法，设成YES
    NSLog(@"%@",self);
    return YES;
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
