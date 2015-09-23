//
//  OrderWillPayCell.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/19.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//
NSString * const DeleteDishNotification = @"DeleteDishNotification";
#import "OrderWillPayCell.h"
#import "orderDishes.h"
#import "OrderTool.h"
#import "MBProgressHUD+MJ.h"
@interface OrderWillPayCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbUrl;
@property (weak, nonatomic) IBOutlet UILabel *dishesName;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *promotePrice;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (nonatomic, strong)orderDishes *result;

@end
@implementation OrderWillPayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    OrderWillPayCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderWillPayCell" owner:nil options:nil] lastObject];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//不能被选中
    return cell;
}
- (void)setModel:(NSObject *)model {
    
    [super setModel:model];
    
    orderDishes *result = (orderDishes *)model;
    self.dishesName.text = result.dishesName;
    
    if (result.promotePrice != result.shopPrice) {
        self.shopPrice.hidden = NO;
        self.shopPrice.text=[NSString stringWithFormat:@"%.0f",result.shopPrice];
        
        NSUInteger length = [[NSString stringWithFormat:@"%.0f",result.shopPrice] length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f",result.shopPrice] ];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [self.shopPrice setAttributedText:attri];
        
    }else {
        self.shopPrice.hidden = YES;
    }
    self.promotePrice.text=[NSString stringWithFormat:@"￥%.1f",result.promotePrice];
    self.count.text = [NSString stringWithFormat:@"%ld",(long)result.count];
    [self.thumbUrl sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:result.thumbUrl]] placeholderImage:[UIImage imageNamed:@"regist_bg"]];
    self.result = result;
}

#pragma mark - action
- (IBAction)increaseClick:(id)sender {
    
    self.result.count += 1;
    self.count.text = [NSString stringWithFormat:@"%ld",(long)self.result.count];
    
}
- (IBAction)decreaseClick:(id)sender {
    
    if (self.result.count==0) {
        //[self deleteDishButton];
        return;
    }
    self.result.count -= 1;
    self.count.text = [NSString stringWithFormat:@"%ld",(long)self.result.count];
}
- (IBAction)deleteDishButton {
    
    deleteDishParam *param = [[deleteDishParam alloc]init];
    param.orderDishesId = self.result.orderDishesId;
    __weak typeof(self) Weakself=self;
    [OrderTool deleteDishWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            return ;
        }
        [MBProgressHUD showSuccess:@"删除成功"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"orderDishesId"] =  Weakself.result;
       // dict[@"row"] =  [NSNumber numberWithInteger:Weakself.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:DeleteDishNotification object:nil userInfo:dict];
            } failure:^(NSError *error) {
        
    }];

}

@end
