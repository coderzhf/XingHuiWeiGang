//
//  CustomPickView.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/4.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "PopupView.h"

@implementation PopupView

+ (instancetype)defaultPopupView{
    
    return [[PopupView alloc]initWithFrame:CGRectMake(0, 0, 240, 0)];
}

-(instancetype)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) {
        _bgView = [UQFactory viewWithFrame:frame backgroundColor:[UIColor whiteColor]];
        [self addSubview:_bgView];
    }
    return self;
}

- (void)addSubviewWithOptions:(NSUserInforOptions)options
{
    self.options = options;
    switch (options) {
        case 0://性别
        case 1 ://口味
        {
            self.height = 40*_dataArray.count;
            _bgView.height = 40*_dataArray.count;
            for (int i = 0; i < _dataArray.count; i ++) {
                UIButton *btn = [UQFactory buttonWithFrame:KFrame(0, i *40, _bgView.width, 40) image:nil title:_dataArray[i] titleColor:[UIColor blackColor] fontSize:14];
                UILabel *label = [UQFactory labelWithFrame:KFrame(0, btn.bottom, _bgView.width, 1) text:nil];
                label.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:btn];
                [btn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }
        }
            break;                
        default:
            break;
    }
}

- (void)chooseAction:(UIButton *)btn
{    //视图消失，传递选取的字符串
    [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];

    if (_changeSussessBlock) {
        _changeSussessBlock(btn.currentTitle);
    }
    _str = btn.currentTitle;
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"userId"] = [UserDefaults objectForKey:@"userId"];
    if ([btn.currentTitle isEqualToString:@"男"]) {
        mDic[@"gender"] = @"0";
        
    }else if([btn.currentTitle isEqualToString:@"女"]){
        mDic[@"gender"] = @"1";

    }else{
        mDic[@"favoriteTaste"] = btn.currentTitle;

    }
    [self uploadData:[NSDictionary dictionaryWithObjectsAndKeys:[mDic JSONString], @"json",nil]];
}

- (void)pickAction:(UIDatePicker *)picker
{
    //视图消失，传递选取的字符串
    [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = picker.date;
    if (_changeSussessBlock) {
        _changeSussessBlock([formatter stringFromDate:date]);
    }
    _str = [formatter stringFromDate:date];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    mDic[@"userId"] = [UserDefaults objectForKey:@"userId"];
    mDic[@"birthday "] = [formatter stringFromDate:date];
    [self uploadData:[NSDictionary dictionaryWithObjectsAndKeys:[mDic JSONString], @"json",nil]];
}

- (void)uploadData:(NSDictionary*)dic
{
    [Utils post:KperfectUser params:dic success:^(id json) {
        if ([[json objectForKey:@"code"] intValue] ) {
            [Notifier UQToast:AppWindow text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        [Notifier UQToast:AppWindow text:@"信息修改成功" timeInterval:NyToastDuration];
        switch (_options) {
            case 0:
                [UserDefaults setObject:_str forKey:@"gender"];
                break;
            case 1:
                [UserDefaults setObject:_str forKey:@"favoriteTaste"];

                break;
            default:
                break;
        }
        
    } failure:^(NSError *error) {
        [Notifier UQToast:AppWindow text:@"信息修改失败" timeInterval:NyToastDuration];
    }];
}

- (void)hadChangeSuccess:(changeInforBlock)successBlock
{
    self.changeSussessBlock = successBlock;
}


@end
