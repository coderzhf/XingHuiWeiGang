//
//  DiscountCell.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DiscountCell.h"
#import "ShakeDiscountModel.h"
@implementation DiscountCell

- (void)awakeFromNib {
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    UIImageView *bgImageView = [UQFactory imageViewWithFrame:KFrame(10, 5, KScreenWidth-20, 110) image:nil];
    bgImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:bgImageView];
    DiscountCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DiscountCell" owner:nil options:nil] lastObject];
    return cell;
}

- (void)setDiscountModel:(ShakeDiscountModel *)discountModel
{
    _discountModel = discountModel;
    //self.titleLabel.text = ;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",_discountModel.denomination];
    //self.detailLabel.text = _discountModel;
    self.deadTime.text = _discountModel.endTime;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
