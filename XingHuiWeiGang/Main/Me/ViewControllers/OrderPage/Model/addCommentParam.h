//
//  addCommentParam.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/25.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addCommentParam : NSObject
//@property (nonatomic, strong) NSNumber *orderId;
//@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSArray *commentLists;

@end
/*
 ordered 订单编号
 userId 用户编号
 List<CommentBean> list
 DishesId 菜品编号
 Content 评论内容
 Score 评论星级
 */