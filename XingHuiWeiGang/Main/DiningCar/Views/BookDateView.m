//
//  BookDateView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BookDateView.h"
@interface BookDateView()
/** 背部的遮盖按钮 */
@property (nonatomic, strong) UIButton *maxCoverBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end
@implementation BookDateView


+ (instancetype)bookDateView {
    
    BookDateView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    return view;
}

- (void)awakeFromNib {
    _maxCoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxCoverBtn.frame = [UIScreen mainScreen].bounds;
    [_maxCoverBtn setBackgroundColor:[UIColor blackColor]];
    [_maxCoverBtn setAlpha:0.3];
    [_maxCoverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)showBookDateViewToView:(UIView *)superView {
    [superView addSubview:self.maxCoverBtn];
    self.center = CGPointMake(KScreenWidth*0.5, KScreenHeight*0.5-50);
    [superView addSubview:self];

}
- (void)coverClick {
    [self.maxCoverBtn removeFromSuperview];
    [self removeFromSuperview];
}
- (IBAction)cancelClick {
    
    [self coverClick];
}
- (IBAction)commiteClick {
    NSDate *selectedDate = [self.datePicker date];
    if (self.dateBlock) {
        self.dateBlock(selectedDate);
    }
    
    [self coverClick];
}
@end
