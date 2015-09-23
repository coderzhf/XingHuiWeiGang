//
//  DishTypes.h
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/7.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DishTypes : NSObject
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,copy)NSString *typeName;
@end
/*
 
 {
 code = 0;
 list =     (
 {
 id = 4;
 typeName = "\U8fa3\U5473";
 },
 {
 id = 5;
 typeName = "\U751c\U5473";
 },
 {
 id = 22;
 typeName = "\U9178\U5473";
 },
 {
 id = 23;
 typeName = "\U82e6\U5473";
 }
 );
 msg = "\U53e3\U5473\U7c7b\U578b";
 }

 */