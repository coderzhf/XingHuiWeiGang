//
//  OrderRefundView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/24.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderRefundView.h"
#import "OrderTool.h"
#import "MBProgressHUD+MJ.h"
@interface OrderRefundView()
@property (nonatomic, strong) UIButton *maxCoverBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
@implementation OrderRefundView


+ (instancetype)orderRefundView {
    
    OrderRefundView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    return view;
}

- (void)awakeFromNib {
    _maxCoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxCoverBtn.frame = [UIScreen mainScreen].bounds;
    [_maxCoverBtn setBackgroundColor:[UIColor blackColor]];
    [_maxCoverBtn setAlpha:0.3];
    [_maxCoverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)showRefundViewToView{
    UIWindow *wind = [UIApplication sharedApplication].keyWindow;
    [wind addSubview:self.maxCoverBtn];
    self.center = CGPointMake(KScreenWidth*0.5, KScreenHeight*0.5-70);
    [wind addSubview:self];
    
}
- (void)coverClick {
    [self.maxCoverBtn removeFromSuperview];
    [self removeFromSuperview];
}
- (IBAction)buttonClick {
    
    deleteOrderParam *param = [[deleteOrderParam alloc]init];
    param.orderId = self.order.orderId;
    param.memo = self.textView.text;
    [OrderTool deleteOrderWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            return ;
        }
        [MBProgressHUD showSuccess:json[@"msg"]];
        
    } failure:^(NSError *error) {
        
    }];
    [self coverClick];


}
@end
