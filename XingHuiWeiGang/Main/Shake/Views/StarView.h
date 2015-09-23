//
//  StarView.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
{
    UIView *_yellowView;//金色的星星
    UIView *_grayView;//灰色的星星
}

@property (nonatomic, strong)NSNumber *rating;//评分
@end
