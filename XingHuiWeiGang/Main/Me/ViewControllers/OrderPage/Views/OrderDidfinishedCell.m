//
//  OrderDidfinishedCell.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderDidfinishedCell.h"
#import "orderDishes.h"
#import "MTStarEvaluation.h"
@interface OrderDidfinishedCell()
@property (weak, nonatomic) IBOutlet UIImageView *thumbUrl;
@property (weak, nonatomic) IBOutlet UILabel *dishesName;
@property (weak, nonatomic) IBOutlet UILabel *promotePrice;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet MTStarEvaluation *priaseView;
@end
@implementation OrderDidfinishedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    OrderDidfinishedCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDidfinishedCell" owner:nil options:nil] lastObject];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//不能被选中
    return cell;
}
- (void)setModel:(NSObject *)model {
    
    [super setModel:model];
    
    orderDishes *result = (orderDishes *)model;
    self.dishesName.text = result.dishesName;
    
    self.promotePrice.text=[NSString stringWithFormat:@"￥%.1f",result.promotePrice];
    self.count.text = [NSString stringWithFormat:@"%ld",(long)result.count];
    [self.thumbUrl sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:result.thumbUrl]] placeholderImage:[UIImage imageNamed:@"regist_bg"]];
    if (result.isComment) {
        self.priaseView.hidden = NO;
    }
}

@end
