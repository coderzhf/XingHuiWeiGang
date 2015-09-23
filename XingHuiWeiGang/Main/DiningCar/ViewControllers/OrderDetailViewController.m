//
//  OrderDetailViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/29.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "PayViewController.h"
#import "DinnerCartTool.h"
@interface OrderDetailViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *orderSn;
@property (weak, nonatomic) IBOutlet UILabel *bookingDate;
@property (weak, nonatomic) IBOutlet UILabel *personCount;
@property (weak, nonatomic) IBOutlet UILabel *adviceLabel;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;

@property(nonatomic,strong)showOrderResult *OrderResult;
@end

@implementation OrderDetailViewController
/*
 @property(nonatomic,strong)NSNumber *actualPayPrice;
 @property(nonatomic,strong)NSNumber *dishesId;
 @property(nonatomic,strong)NSNumber *orderId;
 @property(nonatomic,strong)NSNumber *personCount;
 @property(nonatomic,copy)NSString *bookingDate;
 @property(nonatomic,assign)long long  orderSn;
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    [self loadOrderDetail];

}
- (void)loadOrderDetail {
    if (self.isWaiting) {//排号
        self.adviceLabel.text = @"您好，您排号成功，详情如下:";
        [self.NextButton setTitle:@"确定"forState:UIControlStateNormal];
    }else{//下单、打包  预约成功
        self.orderSn.text = [NSString stringWithFormat:@"%lld",self.OrderResult.orderSn];
        self.bookingDate.text = self.OrderResult.bookingDate;
        if (self.isPack) {//打包
            self.personCount.text = @"打包订单";
        } else{//下单、预约
            self.personCount.text = [NSString stringWithFormat:@"%@人",self.OrderResult.personCount];
        }
    }
    
}
- (void)setResult:(addOrderResult *)result {
    
    _result = result;
    
    __weak typeof (self) Weakself = self;
    if (self.isWaiting)//如果是排号界面
    {
        addWaitingNumberParam *waitingParam = [[addWaitingNumberParam alloc]init];
        waitingParam.orderId = _result.obj;
        waitingParam.userId = @27;
        [DinnerCartTool addWaitingNumberWithParam:waitingParam success:^(id json) {
            if ([json[@"code"] integerValue]) {
                
                return ;
            }
            showWaitingNumberParam *showParam = [[showWaitingNumberParam alloc]init];
            showParam.waitingNumberId = json[@"obj"];
            [DinnerCartTool showWaitingNumberWithParam:showParam success:^(id json) {
                
                if ([json[@"code"] integerValue]) {
                    return ;
                }
                showWaitingNumberResult *result = [showWaitingNumberResult objectWithKeyValues:json[@"obj"]];
                Weakself.orderSn.text = [NSString stringWithFormat:@"%@",result.waitingNo];
                Weakself.bookingDate.text = result.bookingDate;
                
                Weakself.personCount.text = [NSString stringWithFormat:@"%@人",result.personCount];

                
            } failure:^(NSError *error) {
            }];

        } failure:^(NSError *error) {
        }];
        return;
    }
    //下单、打包  预约成功
    showOrderParam *param = [[showOrderParam alloc]init];
    param.orderId = _result.obj;
    [DinnerCartTool showOrderWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        showOrderResult *OrderResult = [showOrderResult objectWithKeyValues:json[@"obj"]];
        Weakself.OrderResult = OrderResult;
        [Weakself loadOrderDetail];

    } failure:^(NSError *error) {
    }];

}

- (IBAction)returnToModify {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)payNow {
    if (self.isWaiting) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    PayViewController *pay = [[PayViewController alloc]init];
    pay.OrderResult = self.OrderResult;
    [self.navigationController pushViewController:pay animated:YES];
}
- (void)leftBtnEvent:(UIButton *)btn {
    NSLog(@"fsdfag");
}
#pragma mark - UINavigationBarDelegate

@end
