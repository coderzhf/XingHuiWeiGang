//
//  DinnerCarCell.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/23.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DinnerCarCell.h"
#import "UIImageView+WebCache.h"
@interface DinnerCarCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbUrl;
@property (weak, nonatomic) IBOutlet UILabel *dishesName;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *isPack;
@property(nonatomic,assign) NSInteger selCount;
@end
@implementation DinnerCarCell
/*
 @property(nonatomic,assign)NSInteger collectCount;
 @property(nonatomic,assign)NSInteger count;
 @property(nonatomic,assign)NSInteger dishesInfoId;
 @property(nonatomic,assign)NSInteger remarkCount;
 @property(nonatomic,assign)NSInteger praiseCount;
 @property(nonatomic,assign)NSInteger saleCount;
 @property(nonatomic,assign)NSInteger saleType;
 @property(nonatomic,assign)NSInteger shopId;
 @property(nonatomic,assign)NSInteger userCartsId;
 @property(nonatomic,copy)NSString *dishesName;
 @property(nonatomic,copy)NSString *thumbUrl;
 @property(nonatomic,assign)CGFloat score;
 @property(nonatomic,assign)CGFloat shopPrice;
 @property(nonatomic,assign)BOOL isAttention;
 @property(nonatomic,assign)BOOL isOnSale;
 @property(nonatomic,assign)BOOL isPraise;
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
        
    static NSString *ID=@"DinnerCarCell";
    DinnerCarCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[DinnerCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
   
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    DinnerCarCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DinnerCarCell" owner:nil options:nil] lastObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)setResult:(showUserCartResult *)result {
    _result = result;
    self.dishesName.text = result.dishesName;
    self.shopPrice.text = [NSString stringWithFormat:@"￥%.1f",result.shopPrice];
    self.count.text = [NSString stringWithFormat:@"%ld",(long)result.count];
    [self.thumbUrl sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:result.thumbUrl]] placeholderImage:[UIImage imageNamed:@"regist_bg"]];
    if (result.isPack) {
        self.isPack.hidden = YES;
    }else{
        self.isPack.hidden = NO;
    }
    self.selCount = result.count;
    self.isSelected = YES;
    dispatch_after(1.0, dispatch_get_main_queue(), ^{
         [self optionButtonClick:self.selButton];
    });


}
#pragma mark - action
- (IBAction)increaseClick:(id)sender {
    self.selCount = self.selCount+1;
    self.count.text = [NSString stringWithFormat:@"%ld",(long)self.selCount];
    if (!self.isSelected)  return;
    if (self.NumActionBlock) {
        self.NumActionBlock(self.selCount,self.result.shopPrice,self.result.dishesInfoId,self.result.isPack);
    }
    
}
- (IBAction)decreaseClick:(id)sender {
    if (self.selCount==0) {
        self.selButton.selected = NO;
        self.isSelected = NO;
        return;

    }
    self.selCount = self.selCount-1;
    self.count.text = [NSString stringWithFormat:@"%ld",(long)self.selCount];
    if (!self.isSelected)  {
        return;
    }
    if (self.NumActionBlock) {
        self.NumActionBlock(self.selCount,self.result.shopPrice,self.result.dishesInfoId,self.result.isPack);
    }
    if (self.selCount==0) {
        self.selButton.selected = NO;
        self.isSelected = NO;
    }
}
- (IBAction)optionButtonClick:(UIButton *)btn {
    
    btn.selected = !btn.isSelected;
    self.isSelected = btn.selected;
    if (!self.isSelected)  {
        if (self.NumActionBlock) {
            self.NumActionBlock(0,self.result.shopPrice,self.result.dishesInfoId,self.result.isPack);
        }
    } else {
        if (self.NumActionBlock) {
            self.NumActionBlock(self.selCount,self.result.shopPrice,self.result.dishesInfoId,self.result.isPack);
        }

    }

}
@end
