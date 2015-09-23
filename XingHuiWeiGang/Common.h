//
//  Common.h
//  XingHuiWeiGang
//
//  Created by zx on 15/7/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#ifndef XingHuiWeiGang_Common_h
#define XingHuiWeiGang_Common_h

#define KnavHeight ([UIScreen mainScreen].bounds.size.height==736? 93: 64)
#define KTarBarHeight ([UIScreen mainScreen].bounds.size.height==736? 73: 49)
//获得窗口
#define AppWindow ((UIWindow *)[[UIApplication sharedApplication].windows firstObject])
//属性列表
#define UserDefaults [NSUserDefaults standardUserDefaults]
//获取物理屏幕的大小
// 屏幕bounds
#define KScreenBounds [UIScreen mainScreen].bounds
// 屏幕的size
#define KScreenSize [UIScreen mainScreen].bounds.size

#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define KScreenWidth  ([UIScreen mainScreen].bounds.size.width)
//iphone4
#define Kiphone4 ([UIScreen mainScreen].bounds.size.height == 480)

//菜品口味查询通知
#define DishTypeNotification @"DishTypeNotification"
#define DishTypeID @"DishTypeID"
#define DishTypeName @"DishTypeName"

#define KFrame(x,y,w,h) CGRectMake(x, y, w, h)
#define  KImage(z) [UIImage imageNamed:z]
//判断系统版本
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7 [[UIDevice currentDevice].systemVersion floatValue] == 7.0
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)


//RGB获取颜色
#define YXRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0  alpha:1.0]
#define YXRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif
