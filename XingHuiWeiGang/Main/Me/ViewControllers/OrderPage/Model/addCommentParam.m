//
//  addCommentParam.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/25.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "addCommentParam.h"
#import "Comment.h"
@implementation addCommentParam
-(NSDictionary *)objectClassInArray
{
    return @{@"commentLists" : [Comment class]};
}
@end
