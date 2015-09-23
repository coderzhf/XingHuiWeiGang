//
//  WWSideslipViewController.m
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "ShakeViewControllerHelp.h"
#import "LeftViewController.h"
#import "ViewController.h"

@interface ShakeViewControllerHelp ()<UIGestureRecognizerDelegate>
@end

@implementation ShakeViewControllerHelp
@synthesize speedf,pan,sideslipTapGes;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

+ (ShakeViewControllerHelp *)shareShakeVCHelp
{
    static ShakeViewControllerHelp *shareShakeInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareShakeInstance = [[self alloc] init];
    });
    return shareShakeInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        speedf = 0.001;

        LeftViewController *leftVC = [[LeftViewController alloc] init];
        ViewController *mainVC = [[ViewController alloc] init];
        leftControl = leftVC;
        mainControl = mainVC;
        UIImageView * imgview = [UQFactory imageViewWithFrame:[UIScreen mainScreen].bounds image:KImage(@"yx_shake_black")];
        [self.view addSubview:imgview];
        //滑动手势
        pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        
        //单击手势
        sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        sideslipTapGes.delegate = self;
        [sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.view addSubview:leftControl.view];
        [self.view addSubview:mainControl.view];

    }
    return self;
}

#pragma mark - 滑动手势
//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    
    scalef = (point.x*speedf+scalef);

    //根据视图位置判断是左滑还是右边滑动
    if (rec.view.frame.origin.x>=0){
        rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-scalef/1000,1-scalef/1000);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
    }    //手势结束后修正位置
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (scalef>140*speedf){
            [self showLeftView];
        }else{
            [self showMainView];
            scalef = 0;}
    }
}

#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self showMainView] ;
        scalef = 0;}
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%@",NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.75,0.75);
    mainControl.view.center = CGPointMake(300,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

- (BOOL)prefersStatusBarHidden
{
    return YES; //返回NO表示要显示，返回YES将hiden
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
