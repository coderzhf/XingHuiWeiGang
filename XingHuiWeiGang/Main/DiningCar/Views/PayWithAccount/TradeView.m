//
//  ZCTradeView.m
//  直销银行
//
//  Created by 塔利班 on 15/4/30.
//  Copyright (c) 2015年 联创智融. All rights reserved.
//

// 自定义Log
#ifdef DEBUG // 调试状态, 打开LOG功能
#define ZCLog(...) NSLog(__VA_ARGS__)
#define ZCFunc ZCLog(@"%s", __func__);
#else // 发布状态, 关闭LOG功能
#define ZCLog(...)
#define ZCFunc
#endif

// 设备判断
/**
 iOS设备宽高比
 4\4s {320, 480}  5s\5c {320, 568}  6 {375, 667}  6+ {414, 736}
 0.66             0.56              0.56          0.56
 */
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define ios8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define ios6 ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 7.0)
#define ios5 ([[UIDevice currentDevice].systemVersion doubleValue] < 6.0)
#define iphone5  ([UIScreen mainScreen].bounds.size.height == 568)
#define iphone6  ([UIScreen mainScreen].bounds.size.height == 667)
#define iphone6Plus  ([UIScreen mainScreen].bounds.size.height == 736)
#define iphone4  ([UIScreen mainScreen].bounds.size.height == 480)
#define ipadMini2  ([UIScreen mainScreen].bounds.size.height == 1024)

#import "TradeView.h"
#import "TradeKeyboard.h"
#import "TradeInputView.h"

@interface TradeView () <UIAlertViewDelegate>
/** 键盘 */
@property (nonatomic, weak) TradeKeyboard *keyboard;
/** 输入框 */
@property (nonatomic, weak) TradeInputView *inputView;
/** 响应者 */
@property (nonatomic, weak) UITextField *responsder;
/** 键盘状态 */
@property (nonatomic, assign, getter=isKeyboardShow) BOOL keyboardShow;
/** 返回密码 */
@property (nonatomic, copy) NSString *passWord;
@end

@implementation TradeView
/** 快速创建 */
+ (instancetype)tradeView
{
    return [[self alloc] init];
}

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:KScreenBounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        /** 键盘 */
        [self setupkeyboard];
        /** 输入框 */
        [self setupInputView];
        /** 响应者 */
        [self setupResponsder];
    }
    return self;
}

/** 输入框 */
- (void)setupInputView
{
    TradeInputView *inputView = [TradeInputView tradeInputView];
    [self addSubview:inputView];
    self.inputView = inputView;
    
    /** 注册取消按钮点击的通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancle) name:TradeInputViewCancleButtonClick object:nil];
    /** 注册确定按钮点击的通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputViewOk:) name:TradeInputViewOkButtonClick object:nil];
}

/** 响应者 */
- (void)setupResponsder
{
    UITextField *responsder = [[UITextField alloc] init];
    [self addSubview:responsder];
    self.responsder = responsder;
}

/** 键盘 */
- (void)setupkeyboard
{
    TradeKeyboard *keyboard = [[TradeKeyboard alloc] init];
    [self addSubview:keyboard];
    self.keyboard = keyboard;
    
    // 注册确定按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ok) name:TradeKeyboardOkButtonClick object:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.isKeyboardShow) {  // 键盘是弹出状态
        [self hidenKeyboard:nil];
    } else {  // 键盘是隐藏状态
        [self showKeyboard];
    }
  
}

/** 键盘弹出 */
- (void)showKeyboard
{
    self.keyboardShow = YES;
    
    CGFloat marginTop;
    if (iphone4) {
        marginTop = 42;
    } else if (iphone5) {
        marginTop = 100;
    } else if (iphone6) {
        marginTop = 120;
    } else {
        marginTop = 140;
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.keyboard.transform = CGAffineTransformMakeTranslation(0, -self.keyboard.height);
        //self.inputView.transform = CGAffineTransformMakeTranslation(0, marginTop - self.inputView.top);
    } completion:^(BOOL finished) {
        
    }];
}

/** 键盘退下 */
- (void)hidenKeyboard:(void (^)(BOOL finished))completion
{
    self.keyboardShow = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.keyboard.transform = CGAffineTransformIdentity;
        self.inputView.transform = CGAffineTransformIdentity;
    } completion:completion];
}

/** 键盘的确定按钮点击 */
- (void)ok
{
    [self hidenKeyboard:nil];
}

/** 输入框的取消按钮点击 */
- (void)cancle
{
    [self hidenKeyboard:^(BOOL finished) {
        //self.inputView.hidden = YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否退出?" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alertView show];
   
    }];
}

/** 输入框的确定按钮点击 */
- (void)inputViewOk:(NSNotification *)note
{
    // 获取密码
    NSString *pwd = note.userInfo[TradeInputViewPwdKey];
    // 通知代理\传递密码
    if ([self.delegate respondsToSelector:@selector(finish:)]) {
        [self.delegate finish:pwd];
    }
}

#pragma mark - Public Interface


/** 弹出 */
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showInView:(UIView *)view
{
    // 浮现
    [view addSubview:self];
    
    /** 键盘起始frame */
    self.keyboard.left = 0;
    self.keyboard.top = KScreenHeight;
    self.keyboard.width = KScreenWidth;
    self.keyboard.height = KScreenWidth * 0.85;
    
    /** 输入框起始frame */
    self.inputView.height = 220;
    self.inputView.top = 30;
    self.inputView.width = KScreenWidth -60;
    self.inputView.left = 30;
    
    /** 弹出键盘 */
    [self showKeyboard];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    ZCLog(@"dealloc---");
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.inputView.hidden = NO;
    if (buttonIndex == 0) {  // 否按钮点击
        [self showKeyboard];
    } else {  // 是按钮点击
        // 清空num数组
//        NSMutableArray *nums = [self.inputView valueForKeyPath:@"nums"];
//        [nums removeAllObjects];
//        [self removeFromSuperview];
//        [self.inputView setNeedsDisplay];
        [[self viewController].navigationController popViewControllerAnimated:NO];
    }
}

@end
