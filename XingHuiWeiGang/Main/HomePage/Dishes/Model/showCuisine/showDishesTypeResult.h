//
//  showDishesTypeResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/22.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showDishesTypeResult : NSObject
@property(nonatomic,strong)NSNumber *DishesTypeID;
@property(nonatomic,copy)NSString *typeName;
@property(nonatomic,copy)NSString *imgUrl;
@end
/*
 {"code":0,"list":[{"id":1,"imgUrl":"/images/rc.jpg","typeName":"热菜"},{"id":2,"imgUrl":"/images/lc.jpg","typeName":"凉菜"},{"id":3,"imgUrl":"/images/pc.jpg","typeName":"泡菜"}],"msg":"菜品查询成功"}
 */