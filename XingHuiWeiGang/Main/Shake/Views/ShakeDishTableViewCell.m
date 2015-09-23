//
//  ShakeDishTableViewCell.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "ShakeDishTableViewCell.h"

@implementation ShakeDishTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    ShakeDishTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ShakeDishTableViewCell" owner:nil options:nil] lastObject];
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setRate:(NSNumber *)rate
{
    [_dishImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PicPath,_imgStr]]];
    _dishes.text = _dishStr;
    _startView.rating = rate ;
  
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
