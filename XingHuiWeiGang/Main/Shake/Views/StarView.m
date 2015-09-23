//
//  StarView.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "StarView.h"

@implementation StarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _createView];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    [self _createView];

}
- (void)_createView
{
    UIImage *yelloImg = [UIImage imageNamed:@"yx_judgement_yellow"];
    UIImage *grayImg = [UIImage imageNamed:@"yx_judgement_gray"];
    
    //创建灰色星星
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, grayImg.size.width * 5, grayImg.size.height)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImg];
    [self addSubview:_grayView];
    
    //创建金色的星星
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, yelloImg.size.width * 5, yelloImg.size.height)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yelloImg];
    [self addSubview:_yellowView];
    
    //把当前视图的背景颜色改成透明
    self.backgroundColor = [UIColor clearColor];
    
    //放大或者缩小星星
    //放大或者缩小的倍数
    CGFloat scale = self.frame.size.height/yelloImg.size.height;
    _grayView.transform = CGAffineTransformMakeScale(scale, scale);
    _yellowView.transform = CGAffineTransformMakeScale(scale, scale);
    
    //星星视图修改了transform后，坐标会改变，需要重新回复坐标
    _grayView.origin = CGPointZero;
    _yellowView.origin = CGPointZero;
    
}

- (void)setRating:(NSNumber*)rating
{
    _rating = rating;
    
    //计算分数的百分比
    CGFloat s = [rating floatValue]/10;
    
    //重新修改当前的宽度
    self.width = self.height * 5;
    _yellowView.width = self.width * s;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
