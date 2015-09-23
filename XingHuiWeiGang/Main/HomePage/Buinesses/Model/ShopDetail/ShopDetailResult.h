//
//  ShopDetailResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//  5.2显示店铺详情

#import <Foundation/Foundation.h>

@interface ShopDetailResult : NSObject
@property(nonatomic,strong)NSNumber *avgAmount;
@property(nonatomic,strong)NSNumber *collectCount;
@property(nonatomic,strong)NSNumber *praiseCount;
@property(nonatomic,strong)NSNumber *remarkCount;
@property(nonatomic,strong)NSNumber *score;
@property(nonatomic,strong)NSNumber *shopId;
@property(nonatomic,copy)NSString *descrip;
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *picUrl;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,assign)BOOL isPraise;
@property(nonatomic,assign)BOOL isAttention;

@end
/*
 {"code":0,"msg":"店铺详情查看成功","obj":{"avgAmount":50,"collectCount":10,"description":"海底捞成立于1994年，是一家以经营川味火锅为主、融汇各地火锅特色为一体的大型跨省直营餐饮品牌火锅店，全称是四川海底捞餐饮股份有限公司。在简阳、北京、上海、沈阳、天津、武汉、石家庄、西安、郑州、南京、广州、深圳、合肥、太原、贵阳等城市都有直营连锁餐厅。","imgUrl":"/images/dp.jpg","picUrl":"/images/dp1.jpg,/images/dp2.jpg","praiseCount":10,"remarkCount":0,"score":4.5,"shopId":1,"shopName":"美食屋1"}}
 */