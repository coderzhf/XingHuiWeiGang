//
//  CollectionViewCell.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CollectionModel.h"
#import "DishTool.h"
@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *thumbUrl;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *dishesName;
@property (nonatomic,assign) BOOL isDish;
@end
@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setCollectionModel:(CollectionModel *)collectionModel
{
    _collectionModel = collectionModel;
    if (collectionModel.dishesName) {
        if (collectionModel.thumbUrl) {
            [self.thumbUrl sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:collectionModel.thumbUrl]] placeholderImage:[UIImage imageNamed:@"regist_bg"]];
        }
        self.dishesName.text = collectionModel.dishesName;
        self.shopPrice.text = [NSString stringWithFormat:@"￥%@",collectionModel.shopPrice];
        self.isDish = YES;
    }else {
        if (collectionModel.imgUrl) {
            [self.thumbUrl sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:collectionModel.imgUrl]] placeholderImage:[UIImage imageNamed:@"regist_bg"]];
        }
        self.dishesName.text = collectionModel.shopName;
        self.shopPrice.text = [NSString stringWithFormat:@"￥%@",collectionModel.avgAmount];
        self.isDish = NO;

    }
    
    [self setNeedsLayout];
}
- (IBAction)cancelButtonClick {

    updateUserAttentionParam *param = [[updateUserAttentionParam alloc]init];
    param.userAttentionId = self.collectionModel.userAttentionId;
    __weak typeof(self) Weakself=self;
    [DishTool updateUserAttentionWithParam:param success:^(id json) {
       
        if (Weakself.block) {
            Weakself.block(Weakself.isDish,![json[@"code"] integerValue]);
        }
    } failure:^(NSError *error) {
        
    }];

}
@end
