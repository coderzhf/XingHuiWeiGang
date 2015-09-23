//
//  ZCTradeInputView.m
//  直销银行
//
//  Created by 塔利班 on 15/4/30.
//  Copyright (c) 2015年 联创智融. All rights reserved.
//

#define ZCTradeInputViewNumCount 6

// 快速生成颜色
#define ZCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

typedef enum {
    TradeInputViewButtonTypeWithCancle = 10000,
    TradeInputViewButtonTypeWithOk = 20000,
}TradeInputViewButtonType;

#import "TradeInputView.h"
#import "TradeKeyboard.h"

@interface TradeInputView ()
/** 数字数组 */
@property (nonatomic, strong) NSMutableArray *nums;
/** 确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
/** 取消按钮 */
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@end

@implementation TradeInputView

#pragma mark - LazyLoad

- (NSMutableArray *)nums
{
    if (_nums == nil) {
        _nums = [NSMutableArray array];
    }
    return _nums;
}

#pragma mark - LifeCircle

+ (instancetype)tradeInputView
{
   return  [[[NSBundle mainBundle] loadNibNamed:@"TradeInputView" owner:self options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    /** 注册keyboard通知 */
    [self setupKeyboardNote];
}

- (IBAction)toPay:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tradeInputView:okBtnClick:)]) {
        [self.delegate tradeInputView:self okBtnClick:(UIButton *)sender];
    }
    // 包装通知字典
    NSMutableString *pwd = [NSMutableString string];
    for (int i = 0; i < self.nums.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@", self.nums[i]];
        [pwd appendString:str];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[TradeInputViewPwdKey] = pwd;
    [[NSNotificationCenter defaultCenter] postNotificationName:TradeInputViewOkButtonClick object:self userInfo:dict];
}

- (IBAction)cancelPay:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tradeInputView:cancleBtnClick:)]) {
        [self.delegate tradeInputView:self cancleBtnClick:(UIButton *)sender];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TradeInputViewCancleButtonClick object:self];

}

/** 注册keyboard通知 */
- (void)setupKeyboardNote
{
    // 删除通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delete) name:TradeKeyboardDeleteButtonClick object:nil];
    
    // 隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ok) name:TradeKeyboardOkButtonClick object:nil];
    
    // 数字通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(number:) name:TradeKeyboardNumberButtonClick object:nil];
}

#pragma mark - Layout

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
// }

#pragma mark - Private

// 删除
- (void)delete
{
    [self.nums removeLastObject];
    [self setNeedsDisplay];
}

// 数字
- (void)number:(NSNotification *)note
{
    if (self.nums.count >= ZCTradeInputViewNumCount) return;
    NSDictionary *userInfo = note.userInfo;
    NSNumber *numObj = userInfo[TradeKeyboardNumberKey];
    [self.nums addObject:numObj];
    [self setNeedsDisplay];
}

// 确定
- (void)ok
{
    
}

- (void)drawRect:(CGRect)rect
{
    // 画点
    UIImage *pointImage = [UIImage imageNamed:@"yuan"];
    CGFloat pointW = KScreenWidth * 0.05;
    CGFloat pointH = pointW;
    CGFloat pointY = KScreenWidth * 0.24;
    CGFloat pointX;
    CGFloat margin = KScreenWidth * 0.0484375;
    CGFloat padding = KScreenWidth * 0.045578125;
    for (int i = 0; i < self.nums.count; i++) {
        pointX = margin + padding + i * (pointW + 2 * padding);
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }
    // ok按钮状态
    BOOL statue = NO;
    if (self.nums.count == ZCTradeInputViewNumCount) {
        statue = YES;
    } else {
        statue = NO;
    }
    self.okBtn.enabled = statue;

 }

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
