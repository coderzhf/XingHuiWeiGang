//
//  HomePageHeaderView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "HomePageHeaderView.h"
#import "SDCycleScrollView.h"
@interface HomePageHeaderView()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *scrollView;
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;

@end
@implementation HomePageHeaderView
+(instancetype)headerView{
    return [[[NSBundle mainBundle]loadNibNamed:@"HomePageHeaderView" owner:self options:nil]firstObject];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self ==[super initWithCoder:aDecoder]) {

    }
    return self;
}
-(void)awakeFromNib{
    
    //1.初始化化滚动界面
    [self setupLocalScrollView];
    
    self.userInteractionEnabled=YES;
   

}

-(void)setupLocalScrollView{
    
    // 情景一：采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"title_bg1"],
                        [UIImage imageNamed:@"title_bg2"],
                        [UIImage imageNamed:@"title_bg3"],
                        [UIImage imageNamed:@"title_bg4"],
                        [UIImage imageNamed:@"title_bg"]
                        ];
    
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imagesGroup:images];
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.dotColor=[UIColor orangeColor];
    cycleScrollView.autoScrollTimeInterval = 4.0;
    [self.scrollView addSubview:cycleScrollView];
    self.cycleScrollView=cycleScrollView;
    [cycleScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [self touchesBegan:nil withEvent:nil];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
