//
//  ZCTradeKeyboard.h
//  直销银行
//
//  Created by 塔利班 on 15/4/24.
//  Copyright (c) 2015年 联创智融. All rights reserved.
//  交易密码键盘

#import <Foundation///Foundation.h>

static NSString *TradeKeyboardDeleteButtonClick = @"TradeKeyboardDeleteButtonClick";
static NSString *TradeKeyboardOkButtonClick = @"TradeKeyboardOkButtonClick";
static NSString *TradeKeyboardNumberButtonClick = @"TradeKeyboardNumberButtonClick";
static NSString *TradeKeyboardNumberKey = @"TradeKeyboardNumberKey";

#import <UIKit/UIKit.h>

@class TradeKeyboard;

@protocol TradeKeyboardDelegate <NSObject>

@optional
/** 数字按钮点击 */
- (void)tradeKeyboard:(TradeKeyboard *)keyboard numBtnClick:(NSInteger)num;
/** 删除按钮点击 */
- (void)tradeKeyboardDeleteBtnClick;
/** 确定按钮点击 */
- (void)tradeKeyboardOkBtnClick;
@end

@interface TradeKeyboard : UIView
// 代理
@property (nonatomic, weak) id<TradeKeyboardDelegate> delegate;
@end
