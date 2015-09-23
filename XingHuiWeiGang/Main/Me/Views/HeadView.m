//
//  HeadView.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/7.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

-(instancetype )initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *headBg = [UQFactory imageViewWithFrame:frame image:KImage(@"yx_nav_Bg")];
        [self addSubview:headBg];
        
        UILabel *titleLabel = [UQFactory labelWithFrame:KFrame((KScreenWidth-100)/2, KnavHeight-50,100 , 20) text:title textColor:[UIColor whiteColor] fontSize:18 center:YES];
        [headBg addSubview:titleLabel];
        //用户头像
        _headImg = [UQFactory imageViewWithFrame:KFrame((KScreenWidth-75)/2, KnavHeight-3, 75, 75) image:nil];
        if ([UserDefaults objectForKey:@"isLogin"]) {
            NSString *str = [UserDefaults objectForKey:@"userImg"];
            if ([str hasPrefix:@"http"]) {
                [_headImg sd_setImageWithURL:[NSURL URLWithString:[UserDefaults objectForKey:@"userImg"]] placeholderImage:KImage(@"yx_moren_Img")];
            }else if(!str){
                _headImg.image = KImage(@"yx_moren_Img");
                
            }else{
                [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PicPath,str]] placeholderImage:KImage(@"yx_moren_Img")];
            }
        }else{
            _headImg.image = KImage(@"yx_moren_Img");
        }
        [headBg addSubview:_headImg];
        //头像框
        _btn = [UQFactory buttonWithFrame:KFrame((KScreenWidth-95)/2, KnavHeight-13, 95, 95) backgroundImage:KImage(@"yx_Head_Bg")];
        [headBg addSubview:_btn];
        
        NSLog(@"%@",[UserDefaults objectForKey:@"nickName"]);
        _nameBtn = [UQFactory buttonWithFrame:KFrame((KScreenWidth-200)/2, _btn.bottom+4,200 , 20) image:nil title:[UserDefaults objectForKey:@"nickName"] titleColor:[UIColor whiteColor] fontSize:15];
        if ([title isEqualToString:@"个人信息"]) {
            _nameBtn.titleLabel.text = @"点击修改头像";
            [_nameBtn setTitle:@"点击修改头像" forState:UIControlStateNormal];
        }
        [headBg addSubview:_nameBtn];

    }
    return self;
}

@end
