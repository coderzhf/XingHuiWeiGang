//
//  showCuisineResult.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/22.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showCuisineResult : NSObject
@property(nonatomic,strong)NSNumber *CuisineID;
@property(nonatomic,copy)NSString *typeName;
@property(nonatomic,copy)NSString *imgUrl;
@end
/*
 {"code":0,"list":[{"id":1,"typeName":"川菜"},{"id":2,"typeName":"粤菜"},{"id":3,"typeName":"湘菜"},{"id":4,"typeName":"鲁菜"},{"id":5,"typeName":"浙菜"},{"id":6,"typeName":"苏菜"},{"id":7,"typeName":"闽菜"},{"id":8,"typeName":"徽菜"}],"msg":"菜系查询成功"}
 */