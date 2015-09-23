//
//  AddDinnerCarViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/21.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "AddDinnerCarViewController.h"
#import "UIImageView+WebCache.h"
#import "DinnerCartTool.h"
#import  "MBProgressHUD+MJ.h"
@interface AddDinnerCarViewController (){
    NSInteger _saleNum;
}
@property (weak, nonatomic) IBOutlet UILabel *optionNumLabel;


@end

@implementation AddDinnerCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YXRGBA(0, 0, 0, 0.5);
    _saleNum = 1;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setDishDetailResult:(DishDetailResult *)dishDetailResult{
    _dishDetailResult=dishDetailResult;
    if (dishDetailResult.thumbUrl) {
        [self.thumbPic sd_setImageWithURL:[NSURL URLWithString:[PicPath stringByAppendingString:dishDetailResult.thumbUrl]] placeholderImage:[UIImage imageNamed:@"regist_bg"]];
    }
 
}
- (IBAction)increaseClick:(id)sender {
    _saleNum = _saleNum+1;
    self.optionNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_saleNum];

}
- (IBAction)decreaseClick:(id)sender {
    if (_saleNum==0) return;
    _saleNum = _saleNum-1;
    self.optionNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_saleNum];
}
- (IBAction)finishClick {
    
    addUserCartParam *addParam = [[addUserCartParam alloc]init];
    addParam.dishesId = self.dishDetailResult.dishesInfoId;
    addParam.count = self.optionNumLabel.text;
    addParam.userId = @27;
    __weak typeof(self) Weakself=self;
    [DinnerCartTool addUserCartWithParam:addParam success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        [MBProgressHUD showSuccess:@"成功加入购物车"];
        [Weakself dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
    }];


   
}


@end
