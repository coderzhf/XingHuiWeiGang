//
//  BookTimeView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BookTimeView.h"
#import "bookTimeResult.h"
#import "TitleButton.h"
@interface BookTimeView()
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@property (nonatomic, strong) UIButton *maxCoverBtn;

@end
@implementation BookTimeView



+ (instancetype)bookTimeView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    _maxCoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxCoverBtn.frame = [UIScreen mainScreen].bounds;
    [_maxCoverBtn setBackgroundColor:[UIColor blackColor]];
    [_maxCoverBtn setAlpha:0.3];
    [_maxCoverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setModelArray:(NSArray *)modelArray {
    _modelArray = modelArray;
    
    bookTimeResult *resultfirst = modelArray[0];
    [self.firstButton setTitle:resultfirst.typeName forState:UIControlStateNormal];
    self.firstButton.tag = [resultfirst.ID integerValue];
    [self.firstButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (modelArray.count == 2) {
        bookTimeResult *resultSecond = modelArray[1];
        self.secondButton.hidden = NO;
        [self.secondButton setTitle:resultSecond.typeName forState:UIControlStateNormal];
        self.secondButton.tag = [resultSecond.ID integerValue];
        [self.secondButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)showBookTimeViewToView:(UIView *)superView {
    
    [superView addSubview:self.maxCoverBtn];
    self.center = CGPointMake(KScreenWidth*0.5, KScreenHeight*0.5-50);
    [superView addSubview:self];}


- (void)coverClick {
    [self.maxCoverBtn removeFromSuperview];
    [self removeFromSuperview];
}
- (void)buttonClick:(UIButton *)btn {
    
    if (self.block) {
        self.block([NSNumber numberWithInteger:btn.tag],btn.titleLabel.text);
    }
    [self coverClick];
}
@end
