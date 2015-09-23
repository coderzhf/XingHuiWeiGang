//
//  OrderQRcodeView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "OrderQRcodeView.h"
@interface OrderQRcodeView()
@property (weak, nonatomic) IBOutlet UIImageView *QRcodeImage;
@property (nonatomic, strong) UIButton *maxCoverBtn;

@end
@implementation OrderQRcodeView
+ (instancetype)QRcodeView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    _maxCoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxCoverBtn.frame = [UIScreen mainScreen].bounds;
    [_maxCoverBtn setBackgroundColor:[UIColor blackColor]];
    [_maxCoverBtn setAlpha:0.3];
    [_maxCoverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)showQRcodeViewWithOrderSn:(NSString *)OrderSn {
    [[UIApplication sharedApplication].keyWindow addSubview:self.maxCoverBtn];
    self.center = CGPointMake(KScreenWidth*0.5, KScreenHeight*0.5);
    self.QRcodeImage.image = [self createQRCodeWithString:OrderSn];

    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

///二维码的实现是将字符串传递给滤镜，滤镜直接生成二维码图片
-(UIImage *)createQRCodeWithString:(NSString *)str{

    //1.实例化一个滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //2.设置filter为默认值，因为之前输入的滤镜输入可能会被保留
    [filter setDefaults];
    //3.将字符串转化成nsdata
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    //4.将nsdata传递给滤镜 kvc的方式
    [filter setValue:data forKey:@"inputMessage"];
    //5.由filter输出图像
    CIImage *oututImage=[filter outputImage];

    //6.将CIImage转换成UIImage
    return [UIImage imageWithCIImage:oututImage];
    
}

- (void)coverClick {
    [self.maxCoverBtn removeFromSuperview];
    [self removeFromSuperview];
}

@end
