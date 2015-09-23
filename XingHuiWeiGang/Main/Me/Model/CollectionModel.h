//
//  CollectionModel.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/4.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BaseModel.h"
@interface CollectionModel : BaseModel

@property (nonatomic ,strong) NSString *thumbUrl;//缩略图
@property (nonatomic ,strong) NSString *dishesName;//菜品名称
@property (nonatomic ,strong) NSNumber *shopPrice;//菜品价格
@property (nonatomic ,strong) NSNumber *dishesInfold;//菜品编号

@property (nonatomic ,strong) NSNumber *userAttentionId;//关注编号

@property (nonatomic ,strong) NSString *imgUrl;//缩略图
@property (nonatomic ,strong) NSString *shopName;//商铺名称
@property (nonatomic ,strong) NSNumber *avgAmount;//人均消费
@property (nonatomic ,strong) NSNumber *shopId;//商铺编号

@end
