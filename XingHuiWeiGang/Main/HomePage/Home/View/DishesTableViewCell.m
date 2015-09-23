//
//  DishesTableViewCell.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishesTableViewCell.h"
#import "ShowDishesResult.h"
#import "UIImageView+WebCache.h"
#import "DinnerCartTool.h"
#import "MBProgressHUD+MJ.h"
@interface DishesTableViewCell()
 /*收藏数*/
@property (weak, nonatomic) IBOutlet UIButton *collectCount;
/*评价数*/
@property (weak, nonatomic) IBOutlet UIButton *remarkCount;
/*销量*/
@property (weak, nonatomic) IBOutlet UILabel *saleCount;
/*价格*/
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *promotePrice;

/*菜品名称*/
@property (weak, nonatomic) IBOutlet UILabel *dishesName;
/*菜品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *thumbUrl;
@property (weak, nonatomic) IBOutlet UIButton *isOnSale;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImg;
@property (weak, nonatomic) IBOutlet UIImageView *saleType;
@property (nonatomic, strong) NSNumber *dishesInfoId;
@end
@implementation DishesTableViewCell
/*
@property(nonatomic,strong)NSNumber *count;
//销售类型
@property(nonatomic,strong)NSNumber *saleType;
//评分
@property(nonatomic,strong)NSNumber *score;
//是否在销
@property(nonatomic,assign)BOOL isOnSale;
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    DishesTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DishesTableViewCell" owner:nil options:nil] lastObject];
    
    return cell;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
    }
    
    return self;
}
- (void)awakeFromNib {
}


- (void)setModel:(NSObject *)model {
    [super setModel:model];
    ShowDishesResult *result = (ShowDishesResult *)model;
    [self.collectCount setTitle:[NSString stringWithFormat:@"%@",result.collectCount] forState:UIControlStateNormal];
    [self.remarkCount setTitle:[NSString stringWithFormat:@"%@",result.remarkCount] forState:UIControlStateNormal];
    self.saleCount.text=[NSString stringWithFormat:@"%@",result.saleCount];
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
    self.dishesName.text=[NSString stringWithFormat:@"%@",result.dishesName];
    [self.thumbUrl sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:result.thumbUrl]] placeholderImage:[UIImage imageNamed:@"regist_bg"]];
    self.isOnSale.hidden=result.isOnSale;
    self.scoreImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"yx_atar%@",result.score]];
    switch ([result.saleType integerValue]) {
        case 1:
            self.saleType.image = [UIImage imageNamed:@"yx_dishcell_nice"];
            break;
        case 2:
            self.saleType.image = [UIImage imageNamed:@"yx_dishcell_hot"];
            break;
        case 3:
            self.saleType.image = [UIImage imageNamed:@"yx_dishcell_new"];
            break;
        case 4:
            self.saleType.image = [UIImage imageNamed:@"yx_dishcell_recomend"];
            break;
        case 5:
            self.saleType.image = [UIImage imageNamed:@"yx_dishcell_promote"];
            break;
            
        default:
            self.saleType.image = nil;
            break;
    }
    self.dishesInfoId = result.dishesInfoId;
}
- (IBAction)addDinnerCarClick {
    if (!self.isOnSale.hidden) {
        [MBProgressHUD showError:@"菜品已售罄"];
        return;
    }
    addUserCartParam *addParam = [[addUserCartParam alloc]init];
    addParam.dishesId = self.dishesInfoId;
    addParam.count = @"1";
    addParam.userId = @27;
    [DinnerCartTool addUserCartWithParam:addParam success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        [MBProgressHUD showSuccess:@"成功加入购物车"];
    } failure:^(NSError *error) {
        
    }];

}

@end
