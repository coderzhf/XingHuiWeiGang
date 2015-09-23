//
//  BusinessDetailHeaderView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BusinessDetailHeaderView.h"
#import "SDCycleScrollView.h"
#import "ShopDetailResult.h"
#import "DishTool.h"
#import "MBProgressHUD+MJ.h"
@interface BusinessDetailHeaderView()
@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *avgAmount;
@property (weak, nonatomic) IBOutlet UIButton *collectCount;
@property (weak, nonatomic) IBOutlet UIButton *praiseCount;
@property (weak, nonatomic) IBOutlet UIButton *remarkCount;
@property (weak, nonatomic) IBOutlet UILabel *descrip;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImg;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *isAttention;
@property (weak, nonatomic) IBOutlet UIButton *isPraise;

@end
@implementation BusinessDetailHeaderView
/*
 @property(nonatomic,strong)NSNumber *score;
 @property(nonatomic,strong)NSNumber *shopId;
 @property(nonatomic,copy)NSString *imgUrl;
 @property(nonatomic,copy)NSString *picUrl;
 */

+(instancetype)headerView{
    return [[[NSBundle mainBundle]loadNibNamed:@"BusinessDetailHeaderView" owner:nil options:nil]firstObject];
}

-(void)awakeFromNib{
}


- (void)setDetailResult:(ShopDetailResult *)DetailResult {
    _DetailResult=DetailResult;
    self.avgAmount.text=[NSString stringWithFormat:@"￥%@",DetailResult.avgAmount];
    self.shopName.text=[NSString stringWithFormat:@"%@",DetailResult.shopName];
    self.descrip.text=[NSString stringWithFormat:@"%@",DetailResult.descrip];
    [self.praiseCount setTitle:[NSString stringWithFormat:@"%@",DetailResult.praiseCount] forState:UIControlStateNormal];
    [self.collectCount setTitle:[NSString stringWithFormat:@"%@",DetailResult.collectCount] forState:UIControlStateNormal];
    [self.remarkCount setTitle:[NSString stringWithFormat:@"%@",DetailResult.remarkCount] forState:UIControlStateNormal];
    self.scoreLabel.text=[NSString stringWithFormat:@"%@分",DetailResult.score];
    self.scoreImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"yx_atar%@",DetailResult.score]];
    self.isPraise.selected = !DetailResult.isPraise;
    self.isAttention.selected =!DetailResult.isAttention;
    [self.isAttention addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.isPraise addTarget:self action:@selector(praiseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *Strings =  [_DetailResult.picUrl componentsSeparatedByString:@","];
    NSArray *imagesUrlArray = [PicPath stringsByAppendingPaths:Strings];
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:imagesUrlArray];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.frame=self.scrollView.bounds;
    cycleScrollView.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"regist_bg"];
    [self.scrollView  addSubview:cycleScrollView];
}
- (void)attentionButtonClick:(UIButton *)btn {
    if (btn.selected) {
        [MBProgressHUD showSuccess:@"您已收藏"];
        return;
    }
    addUserAttentionParam *attentionParam = [[addUserAttentionParam alloc]init];
    attentionParam.shopId = self.DetailResult.shopId;
    attentionParam.userId = @27;
    //__weak typeof(self) Weakself=self;
    [DishTool addUserAttentionWithParam:attentionParam success:^(id json) {
        if ([json[@"code"] integerValue]) {
            [MBProgressHUD showError:json[@"msg"] ];
            return ;
        }
        [MBProgressHUD showSuccess:@"收藏成功"];
        btn.selected = YES;
    } failure:^(NSError *error) {
        
    }];
    
    
}
- (void)praiseButtonClick:(UIButton *)btn {
    if (btn.selected) {
        [MBProgressHUD showSuccess:@"您已点赞"];
        return;
    }
    addUserPraiseParam *praiseParam = [[addUserPraiseParam alloc]init];
    praiseParam.shopId = self.DetailResult.shopId;
    praiseParam.userId = @27;
    [DishTool addUserPraiseWithParam:praiseParam success:^(id json) {
        if ([json[@"code"] integerValue]) {
            [MBProgressHUD showError:json[@"msg"] ];
            return ;
        }
        [MBProgressHUD showSuccess:@"点赞成功"];
        btn.selected = YES;
    } failure:^(NSError *error) {
        
    }];
    
}

@end
