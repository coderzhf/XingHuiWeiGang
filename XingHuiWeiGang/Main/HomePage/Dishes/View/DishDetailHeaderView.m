//
//  DishDetailHeaderView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/14.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishDetailHeaderView.h"
#import "SDCycleScrollView.h"
#import "MBProgressHUD+MJ.h"
#import "DishTool.h"
@interface DishDetailHeaderView()
@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *promotePrice;

@property (weak, nonatomic) IBOutlet UILabel *descrip;
@property (weak, nonatomic) IBOutlet UILabel *saleCount;
@property (weak, nonatomic) IBOutlet UIButton *praiseCount;
@property (weak, nonatomic) IBOutlet UIButton *collectCount;
@property (weak, nonatomic) IBOutlet UIButton *isAttention;
@property (weak, nonatomic) IBOutlet UIButton *isPraise;

@end
@implementation DishDetailHeaderView
/*
@property(nonatomic,strong)NSNumber *count;
@property(nonatomic,strong)NSNumber *dishesInfoId;
@property(nonatomic,strong)NSNumber *remarkCount;
@property(nonatomic,strong)NSNumber *praiseCount;
@property(nonatomic,strong)NSNumber *saleCount;
@property(nonatomic,strong)NSNumber *saleType;
@property(nonatomic,strong)NSNumber *score;
@property(nonatomic,strong)NSNumber *shopId;
#warning description 为系统字段
@property(nonatomic,copy)NSString *dishesName;
@property(nonatomic,copy)NSString *imgUrl1;
@property(nonatomic,copy)NSString *thumbUrl;
@property(nonatomic,assign)BOOL isOnSale;
*/
+(instancetype)HeaderView{
    return [[[NSBundle mainBundle]loadNibNamed:@"DishDetailHeaderView" owner:nil options:nil]firstObject];
}

-(void)awakeFromNib{

    
}


- (void)setDetailResult:(DishDetailResult *)DetailResult {
    _DetailResult=DetailResult;
    if (DetailResult.promotePrice != DetailResult.shopPrice) {
        self.shopPrice.hidden = NO;
        self.shopPrice.text=[NSString stringWithFormat:@"%.0f",DetailResult.shopPrice];
        
        NSUInteger length = [[NSString stringWithFormat:@"%.0f",DetailResult.shopPrice] length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f",DetailResult.shopPrice] ];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        //[attri addAttribute:NSStrikethroughColorAttributeName value: YXRGB(0, 0, 0) range:NSMakeRange(2, length-2)];
        [self.shopPrice setAttributedText:attri];
        
    }else {
        self.shopPrice.hidden = YES;
    }
    self.promotePrice.text=[NSString stringWithFormat:@"￥%.0f",DetailResult.promotePrice];
     self.descrip.text=[NSString stringWithFormat:@"%@",DetailResult.descrip];
     self.saleCount.text=[NSString stringWithFormat:@"%@",DetailResult.saleCount];
     [self.praiseCount setTitle:[NSString stringWithFormat:@"%@",DetailResult.praiseCount] forState:UIControlStateNormal];
    [self.collectCount setTitle:[NSString stringWithFormat:@"%@",DetailResult.collectCount] forState:UIControlStateNormal];
    self.isPraise.selected = !DetailResult.isPraise;
    self.isAttention.selected =!DetailResult.isAttention;
    [self.isAttention addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.isPraise addTarget:self action:@selector(praiseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *Strings =  [_DetailResult.imgUrl1 componentsSeparatedByString:@","];
    NSArray *imagesUrlArray = [PicPath stringsByAppendingPaths:Strings];
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:imagesUrlArray];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.frame=self.scrollView.bounds;
    cycleScrollView.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"regist_bg"];
    [self.scrollView  addSubview:cycleScrollView];

}
- (IBAction)enterShopClick {
    
    if (self.enterShopBlcok) {
        self.enterShopBlcok(self.DetailResult);
    }
}
- (void)attentionButtonClick:(UIButton *)btn {
    if (btn.selected) {
        [MBProgressHUD showSuccess:@"您已收藏"];
        return;
    }
    addUserAttentionParam *attentionParam = [[addUserAttentionParam alloc]init];
    attentionParam.dishesId = self.DetailResult.dishesInfoId;
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
    praiseParam.dishesId = self.DetailResult.dishesInfoId;
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
