 //
//  LoginView.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/15.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "LoginViews.h"
#import "RegistViewController.h"
#import "FindPwdViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"

@implementation LoginViews

+ (LoginViews *)instanceWithFrame:(CGRect)frame
{
   LoginViews *view = [[NSBundle mainBundle] loadNibNamed:@"LoginViews" owner:self options:nil][0];
    view.frame = frame;
    return view;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    _phoneNumberField.delegate = self;
    _pswField.delegate = self;
    if ([WXApi isWXAppInstalled]) {
        wechatBtn.hidden = NO;
        loginLabel.hidden = NO;
    }
    if ([WeiboSDK isWeiboAppInstalled]){
        weiboBtn.hidden = NO;
        loginLabel.hidden = NO;
    }
    if ([QQApiInterface isQQInstalled]){
        qqBtn.hidden = NO;
        loginLabel.hidden = NO;
    }
}

- (IBAction)forgetPsw:(id)sender {
    FindPwdViewController *find=[[FindPwdViewController alloc]init];
    [[self viewController].navigationController pushViewController:find animated:NO];
    
}
- (IBAction)remberAction:(UIButton *)sender {
    _isSelected = !_isSelected;
    UIImage *image = _isSelected ?KImage(@"login_reme_selcted"):KImage(@"login_reme_unselcted");
    [sender setImage:image forState:UIControlStateNormal];
    if (_isSelected) {
        [UserDefaults setBool:YES forKey:@"remberMe"];
    }
}

- (IBAction)registerAction:(id)sender {
    RegistViewController *regist=[[RegistViewController alloc]init];
    [[self viewController].navigationController pushViewController:regist animated:NO];

}

- (IBAction)loginAction:(id)sender {
    
    [self textFieldResign];
    if (![Utils isNetworkConnected]) {
        [Notifier UQToast:AppWindow text:@"网络连接有问题,请检查网络设置" timeInterval:NyToastDuration];
            return;}
    if (![self checkInputIsValid]) return;
    [Notifier showHud:AppWindow text:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumberField.text,@"userName",_pswField.text,@"pwd", nil];
    [Utils post:Klogin params:dic success:^(id json) {
        if ([Notifier hasHud]) {
            [Notifier dismissHud:NotifyImmediately];}
        if ([[json objectForKey:@"code"] intValue] ) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"用户名或密码错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                return ;}
        NSDictionary *dic = [json objectForKey:@"obj"];
        [self saveUserInfor:dic];//保存用户数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginorLogout" object:nil];//发用户已经登陆成功的通知，更改我界面
        [[self viewController].navigationController popViewControllerAnimated:NO ];
        } failure:^(NSError *error) {
            if ([Notifier hasHud]) {
                [Notifier dismissHud:NotifyImmediately];
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"用户名或密码错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }];
}

- (BOOL)checkInputIsValid
{
    NSString *phoneNumber = _phoneNumberField.text;
    NSString *password = _pswField.text;
    if (phoneNumber.length == 0 ||password.length == 0) {
        [Notifier UQToast:AppWindow text:@"输入有误，请重新输入" timeInterval:NyToastDuration];
        return NO;
    }
     return YES;
}

- (void)saveUserInfor:(NSDictionary *)dic
{
    [UserDefaults setObject:[dic objectForKey:@"userId"] forKey:@"userId"];
    [UserDefaults setObject:[dic objectForKey:@"nickName"] forKey:@"nickName"];
    //[UserDefaults setObject:_pswField.text forKey:@"password"];
    [UserDefaults setObject:[dic objectForKey:@"userName"] forKey:@"userName"];
    if ([UserDefaults objectForKey:@"headImg"]) {
        [UserDefaults setObject:[dic objectForKey:@"headImg"] forKey:@"headImg"];
    }
    [UserDefaults setBool:YES  forKey:@"isLogin"];
    [UserDefaults synchronize];
}
#pragma mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self textFieldResign];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textFieldResign];
    return YES;
}

- (void)textFieldResign
{
    [_phoneNumberField resignFirstResponder];
    [_pswField resignFirstResponder];
}

- (IBAction)weixinLogin:(id)sender {
    [ShareSDK getUserInfoWithType:ShareTypeWeixiSession
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
     {
         if (result){
             NSDictionary *sourceDic = [userInfo sourceData];
             NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[sourceDic objectForKey:@"nickname"],@"nickName",[sourceDic objectForKey:@"openid"],@"loginName", nil] ;
             [self thirdLogin:dic1];
           }else{
             [Notifier UQToast:AppWindow text:[error errorDescription] timeInterval:NyToastDuration];}
     }];

}
- (IBAction)QQLogin:(id)sender {
    [ShareSDK getUserInfoWithType:ShareTypeQQ
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
     {
         if (result){
             NSDictionary *sourceDic = [userInfo sourceData];
             NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[sourceDic objectForKey:@"nickname"],@"nickName",[sourceDic objectForKey:@"openid"],@"loginName", nil] ;
             [self thirdLogin:dic1];
         }else{
             [Notifier UQToast:AppWindow text:[error errorDescription] timeInterval:NyToastDuration];}
     }];

}
- (IBAction)weiboLogin:(id)sender {
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
     {
         if (result){
             NSDictionary *sourceDic = [userInfo sourceData];
             NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[sourceDic objectForKey:@"nickname"],@"nickName",[sourceDic objectForKey:@"openid"],@"loginName", nil] ;
             [self thirdLogin:dic1];
         }else{
             [Notifier UQToast:AppWindow text:[error errorDescription] timeInterval:NyToastDuration];}
     }];

}

- (void)thirdLogin:(NSDictionary *)dic
{
    [Utils post:KloginWx params:dic success:^(id json) {
        if ([[json objectForKey:@"code"] intValue] ) return ;
        NSDictionary *dic = [json objectForKey:@"user"];
        if (dic[@"loginName"]) {//不是第一次绑定手机号
            [UserDefaults setObject:[dic objectForKey:@"userId"] forKey:@"userId"];
            [UserDefaults setObject:[dic objectForKey:@"nickName"] forKey:@"nickName"];
            [UserDefaults setObject:[dic objectForKey:@"loginName"] forKey:@"loginName"];
            [UserDefaults setObject:[dic objectForKey:@"userImg"] forKey:@"userImg"];
            [UserDefaults setBool:YES  forKey:@"isLogin"];
            [UserDefaults synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginorLogout" object:nil];//发用户已经登陆成功的通知，更改我界面
            [[self viewController].navigationController popToRootViewControllerAnimated:NO];
        }else{//采集手机号
            
        }
    } failure:^(NSError *errorInfor) {
        [Notifier UQToast:AppWindow text:@"用户信息获取失败" timeInterval:NyToastDuration];
    }];
    
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
