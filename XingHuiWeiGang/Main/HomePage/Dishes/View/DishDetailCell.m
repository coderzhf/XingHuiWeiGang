//
//  DishDetailCell.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishDetailCell.h"
#import "ShowCommentResult.h"
#import "UIImageView+WebCache.h"
@interface DishDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *issueTime;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@end
@implementation DishDetailCell
/*
 @property(nonatomic,strong)NSNumber *commentId;
 @property(nonatomic,copy)NSString *content;
 @property(nonatomic,copy)NSString *issueTime;
 @property(nonatomic,copy)NSString *nickName;
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    DishDetailCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DishDetailCell" owner:nil options:nil] lastObject];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//不能被选中
    return cell;
}
- (void)setModel:(NSObject *)model {
    
    [super setModel:model];
    
    ShowCommentResult *result = (ShowCommentResult *)model;
    self.nickName.text = result.nickName;
    self.content.text = result.content;
    self.issueTime.text = result.issueTime;
    if (result.headImg) {
         [self.headImg sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:result.headImg]] placeholderImage:[UIImage imageNamed:@"caipin@3_16"]];
    }
  
}
@end
