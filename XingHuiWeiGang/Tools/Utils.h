//
//  Utils.h
//  ZhenMeiShiDaiApp
//
//  Created by zx on 15/6/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Utils : NSObject

/**
 *	@brief	判断网络是否已连接
 *	@return Boolean
 */
+ (BOOL)isNetworkConnected;

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (CGFloat)getContentHeight:(NSString *)comment width:(CGFloat)width;

/**
 *  快速计算出文本的真实尺寸
 *
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
+ (CGSize)getSizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andString:(NSString *)str;

@end