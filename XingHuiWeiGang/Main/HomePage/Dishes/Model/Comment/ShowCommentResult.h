//
//  ShowCommentResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/21.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowCommentResult : NSObject
@property(nonatomic,strong)NSNumber *commentId;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *issueTime;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *headImg;

@end
/*
 {"code":0,"list":
 [{"commentId":4,"content":"店子好","issueTime":"7天前","nickName":"hanlong"},{"commentId":5,"content":"物美价廉","issueTime":"7天前","nickName":"admin"},
 {"commentId":6,"content":"店主人好","headImg":"upload/1436757373170.jpg","issueTime":"7天前","nickName":"hhuihh"},{"commentId":7,"content":"有点辣","headImg":"upload/1437380320684.jpg","issueTime":"17小时前","nickName":"阿卡丽"},
 {"commentId":9,"content":"老板娘很漂漂","headImg":"upload/1437380320684.jpg","issueTime":"16小时前","nickName":"阿卡丽"},
 {"commentId":10,"content":"好难吃","headImg":"upload/1437383404338.jpg","issueTime":"16小时前","nickName":"吉尔伽美什"}],
 "msg":"查看评论成功"}
 */