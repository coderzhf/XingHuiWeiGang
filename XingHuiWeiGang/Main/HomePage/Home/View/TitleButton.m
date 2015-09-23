//
//  TitleButton.m
//  Weibo
//
//  Created by 张锋 on 15/4/27.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "TitleButton.h"
@interface TitleButton()
@end
@implementation TitleButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        //设置字体图片位置
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.imageView.contentMode=UIViewContentModeCenter;
        //当高亮时不会自动调整currentImage的状态
        self.adjustsImageWhenHighlighted=NO;
    }
    
    return self;
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
   
    CGFloat titleH=contentRect.size.height;
//    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName]=[UIColor whiteColor];
//    dict[NSFontAttributeName]=[UIFont systemFontOfSize:14];
//    CGSize titleSize=[self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return CGRectMake(0, 0, contentRect.size.width-self.currentImage.size.width, titleH);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
   
    CGFloat imageY=0;
    CGFloat imageW=self.currentImage.size.width;
    CGFloat imageX=contentRect.size.width-25;
    CGFloat imageH=contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW,imageH);
}
@end
