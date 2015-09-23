//
//  Comment.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/25.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic, strong) NSNumber *dishesId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *score;

@end
/*
 DishesId 菜品编号
 Content 评论内容
 Score 评论星级
 */