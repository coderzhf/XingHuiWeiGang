//
//  AccountTableViewCell.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "AccountCell.h"

@implementation AccountCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    AccountCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AccountCell" owner:nil options:nil] lastObject];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
