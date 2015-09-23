//
//  HomeSegmentView.m
//  ZhenMeiShiDaiApp
//
//  Created by 张锋 on 15/6/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "HomeSegmentView.h"
#import "HomeSegementButton.h"
#import "TitleButton.h"
@interface HomeSegmentView()
@property(nonatomic,weak)UIButton *selectedButton;
@end
@implementation HomeSegmentView
static NSArray *_titles;
static NSArray *_types;
#pragma mark cycle life
+(void)initialize{
    _titles=[[NSArray alloc]init];
    _types=[[NSArray alloc]init];

}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame] ) {
     
        [self initViews];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self ==[super initWithCoder:aDecoder]) {
        
        [self AddButtonWithTitle:@"人气菜品" Type:HomeSegmentHotDishes];
        [self AddButtonWithTitle:@"大厨推荐" Type:HomeSegmentHotBusiness];

    }
    return self;
}
- (void)initViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    //1.初始化buttons
    
    NSInteger count=_titles.count;
    
    for (int i=0; i<count; i++) {
        
        [self AddButtonWithTitle:_titles[i] Type:[_types[i] intValue]];
    }
}

-(void)layoutSubviews{
    NSInteger count=self.subviews.count;
    for (int i=0; i<count; i++) {
        UIButton *btn=self.subviews[i];
        btn.width=self.width/count;
        btn.left=i*btn.width;
        btn.height=self.height;
        btn.top=0;
    }
}
+(instancetype)initButtonWithTitleArray:(NSArray *)titles type:(NSArray *)types{

    _titles=titles;
    _types=types;
    return [[self alloc]init];
}
//初始化Button
-(void)AddButtonWithTitle:(NSString *)title Type:(HomeSegmentButtonType)type{
  
    if (type==BussinessChoiceDishes) {
        TitleButton *choiceBtn = [TitleButton buttonWithType:UIButtonTypeCustom];
        [choiceBtn setImage:[UIImage imageNamed:@"yx_foodDetail_Btn"] forState:UIControlStateNormal];
        [choiceBtn setTitle:title forState:UIControlStateNormal];
        [choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:choiceBtn];
        self.choiceButton = choiceBtn;
        return;
    }

    HomeSegementButton *btn=[HomeSegementButton buttonWithType:UIButtonTypeCustom];
    btn.tag=type;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
       [self addSubview:btn];
    if(type==HomeSegmentHotDishes||type==BussinessHotDishes){
        [self BtnClick:btn];
    }

}
//点击Button
-(void)BtnClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(HomeSegementWithTag:)]) {
        [self.delegate HomeSegementWithTag:btn.tag];
    }
    self.selectedButton.selected=NO;
    btn.selected=YES;
    self.selectedButton=btn;
}
- (void)choiceBtnClick:(TitleButton *)btn {
    
    btn.selected = !btn.isSelected;
    if (self.chooceTypeBlock) {
        self.chooceTypeBlock(btn.isSelected);
    }
}
@end
