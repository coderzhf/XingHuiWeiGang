//
//  LoginView.h
//  XingHuiWeiGang
//
//  Created by zx on 15/7/15.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViews : UIView<UITextFieldDelegate>
{
    IBOutlet UITextField *_phoneNumberField;
    
    IBOutlet UITextField *_pswField;
    
    __weak IBOutlet UILabel *loginLabel;
    
    __weak IBOutlet UIButton *wechatBtn;
    
    __weak IBOutlet UIButton *qqBtn;
    
    __weak IBOutlet UIButton *weiboBtn;
}
@property (nonatomic ,assign) BOOL isSelected;
- (void)textFieldResign;
+ (LoginViews *)instanceWithFrame:(CGRect)frame;
@end
