//
//  BussinessViewCell.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BussinessViewCell.h"
#import "ShowShopResult.h"
#import "UIImageView+WebCache.h"
@interface BussinessViewCell()
/*人均*/
@property (weak, nonatomic) IBOutlet UILabel *avgAmount;
/*收藏数*/
@property (weak, nonatomic) IBOutlet UIButton *collectCount;
/*评价数*/
@property (weak, nonatomic) IBOutlet UIButton *remarkCount;
/*店铺名称*/
@property (weak, nonatomic) IBOutlet UILabel *shopName;
/*图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imgUrl;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImg;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
@implementation BussinessViewCell
/*
@property(nonatomic,strong)NSNumber *praiseCount;
@property(nonatomic,strong)NSNumber *score;
@property(nonatomic,copy)NSString *picUrl;
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    BussinessViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"BussinessViewCell" owner:nil options:nil] lastObject];
    
    return cell;
}
- (void)setModel:(NSObject *)model{
    [super setModel:model];
    ShowShopResult *result = (ShowShopResult *)model;
    [self.collectCount setTitle:[NSString stringWithFormat:@"%@",result.collectCount] forState:UIControlStateNormal];
    [self.remarkCount setTitle:[NSString stringWithFormat:@"%@",result.remarkCount] forState:UIControlStateNormal];
    self.avgAmount.text=[NSString stringWithFormat:@"￥%@",result.avgAmount];
    self.shopName.text=[NSString stringWithFormat:@"%@",result.shopName];
    [self.imgUrl sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:result.imgUrl]] placeholderImage:[UIImage imageNamed:@"regist_bg"]];
    self.scoreLabel.text=[NSString stringWithFormat:@"%@分",result.score];
    self.scoreImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"yx_atar%@",result.score]];
}
@end
