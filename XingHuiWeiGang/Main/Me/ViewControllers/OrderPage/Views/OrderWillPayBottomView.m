//
//  OrderBottomView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderWillPayBottomView.h"
#import "showWillPayOrder.h"
#import "orderDishes.h"
@interface OrderWillPayBottomView()
@property (weak, nonatomic) IBOutlet UILabel *actualPayPrice;
@property (weak, nonatomic) IBOutlet UILabel *bookingDate;
@property (weak, nonatomic) IBOutlet UILabel *changCi;
@property (weak, nonatomic) IBOutlet UIButton *personCount;
@property (weak, nonatomic) IBOutlet UILabel *packOrder;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@end
@implementation OrderWillPayBottomView

+ (instancetype)bottomView {
    return [[[NSBundle mainBundle]loadNibNamed:@"OrderWillPayBottomView" owner:self options:nil]firstObject];
}
- (void)setOrderFooter:(showWillPayOrder *)orderFooter {
    
    _orderFooter = orderFooter;
    CGFloat totalPrice = 0;
    for (orderDishes *dish in orderFooter.dishesInfoList) {
        
        [dish addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        totalPrice = totalPrice + dish.totalPrice;
    }
    self.actualPayPrice.text = [NSString stringWithFormat:@"￥%.1f",totalPrice];
    if (!orderFooter.personCount) {
        self.packOrder.hidden = NO;
        self.bookingDate.hidden = YES;
        self.changCi.hidden = YES;
        self.personCount.hidden = YES;
        self.timeButton.hidden = YES;
        return;
    }
    if (!orderFooter.bookingDate) {
         self.bookingDate.text = orderFooter.issueTime;
    } else {
        self.bookingDate.text = orderFooter.bookingDate;
    }
    self.changCi.text = orderFooter.changCi;
    [self.personCount setTitle:[NSString stringWithFormat:@"%@人",orderFooter.personCount] forState:UIControlStateNormal];

}
- (void)awakeFromNib {
    
}
- (void)dealloc {
    for (orderDishes *dish in self.orderFooter.dishesInfoList) {
        
        [dish removeObserver:self forKeyPath:@"count"];
    }

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"count"]) {
      //  NSLog(@"%@",change);
        CGFloat totalPrice = 0;
        for (orderDishes *dish in self.orderFooter.dishesInfoList) {
            
            totalPrice = totalPrice + dish.totalPrice;
        }
        self.actualPayPrice.text = [NSString stringWithFormat:@"￥%.1f",totalPrice];


    }
    
}
@end
