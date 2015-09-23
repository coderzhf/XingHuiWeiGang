//
//  ShakeView.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/18.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "ShakeView.h"
#import "ShakeDishTableViewCell.h"
#import "DishDetailViewController.h"

@implementation ShakeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;

        _view = [UQFactory viewWithFrame:KFrame(0, 0, KScreenWidth, KScreenHeight) backgroundColor:[UIColor blackColor]];
        _view.alpha = 0.5;
        
         UIButton *comfirmBtn = [UQFactory buttonWithFrame:KFrame((self.width-50)/2, self.height-40, 50, 50) backgroundImage:KImage(@"yx_ok_btn")];
        [comfirmBtn addTarget:self action:@selector(comfirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:comfirmBtn];
        comfirmBtn.tag = 100;
        
        UIButton *cancleBtn = [UQFactory buttonWithFrame:KFrame(self.width-40, 20, 40, 40) backgroundImage:nil];
        [cancleBtn addTarget:self action:@selector(comfirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancleBtn];
        cancleBtn.tag = 200;
    }
    return self;
}

- (void)setFlag:(unsigned int)flag
{
    [self.superview addSubview:_view];
    [self.superview bringSubviewToFront:self];

    UIImage *image ;
    if (flag == 1) {//菜谱
        image = KImage(@"yx_dishes_Bg");
        _listTableView = [[UITableView alloc] initWithFrame:KFrame(10, 70, self.width-20, self.height-110) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.backgroundColor = [UIColor clearColor];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_listTableView];
    }else if (flag == -2){//为空
        image = KImage(@"yx_null_bg");
    }else{//优惠券
        image = KImage(@"yx_discount_Bg");
        _discountView = [[ShakeDiscountView alloc] initWithFrame:KFrame(50, 70, self.width-100, 100)];
        [self addSubview:_discountView];
        
        UILabel *rule = [UQFactory labelWithFrame:KFrame(50, _discountView.bottom+20, self.width-50*2, self.height-_discountView.bottom-40) text:@"使用说明" textColor:YXRGB(218, 165 ,32) fontSize:18 center:NO];
        [self addSubview:rule];
    }
    self.image = image;
}

- (void)comfirmAction:(UIButton *)button
{
    if (button.tag == 100) {
        [_view removeFromSuperview];
        [self removeFromSuperview];
 
    }else{
        [_view removeFromSuperview];
        [self removeFromSuperview];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    ShakeDishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ShakeDishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic = _listArray[indexPath.row];
    cell.imgStr = [dic objectForKey:@"thumbUrl"];
    cell.dishStr = [dic objectForKey:@"dishesName"];
    NSNumber *rate = [[dic objectForKey:@"score"] floatValue]==0.0?[NSNumber numberWithFloat:4]:[dic objectForKey:@"score"];
    cell.rate  =  rate;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = _listArray[indexPath.row];
    DishDetailViewController *detail = [[DishDetailViewController alloc] init];
    detail.dishesInfoId=dic[@"dishesInfoId"];
    [[self viewController].navigationController pushViewController:detail animated:NO];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
