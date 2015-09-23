//
//  ZCTradeInputView.h
//  直销银行
//
//  Created by 塔利班 on 15/4/30.
//  Copyright (c) 2015年 联创智融. All rights reserved.
//  交易输入视图

#import <Foundation/Foundation.h>

static NSString *TradeInputViewCancleButtonClick = @"TradeInputViewCancleButtonClick";
static NSString *TradeInputViewOkButtonClick = @"TradeInputViewOkButtonClick";
static NSString *TradeInputViewPwdKey = @"TradeInputViewPwdKey";

#import <UIKit/UIKit.h>

@class TradeInputView;

@protocol TradeInputViewDelegate  <NSObject>

@optional
/** 确定按钮点击 */
- (void)tradeInputView:(TradeInputView *)tradeInputView okBtnClick:(UIButton *)okBtn;
/** 取消按钮点击 */
- (void)tradeInputView:(TradeInputView *)tradeInputView cancleBtnClick:(UIButton *)cancleBtn;

@end

@interface TradeInputView : UIView
@property (nonatomic, weak) id<TradeInputViewDelegate> delegate;

+ (instancetype)tradeInputView;
@end
