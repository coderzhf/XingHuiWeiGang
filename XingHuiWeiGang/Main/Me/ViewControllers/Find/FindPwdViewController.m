//
//  FindPwdViewController.m
//  login
//
//  Created by 张锋 on 15/7/8.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "FindPwdViewController.h"
#import "DetailUserInforViewController.h"

@interface FindPwdViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong) NSString *codeStr;
@end

@implementation FindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = [UIColor whiteColor];
    _phoneNumberField.delegate = self;
    _identifyCode.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self textFieldResign];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
//验证验证码

- (IBAction)getCode:(UIButton *)sender {
    [_phoneNumberField resignFirstResponder];
    if (![Utils isNetworkConnected]) {
        [Notifier UQToast:self.view text:@"网络连接有问题" timeInterval:NyToastDuration];
        return;}
    if (![self checkInputIsValid]) return;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumberField.text,@"loginName", nil];
    [Utils post:KshowUser params:dic success:^(id json) {
        if (![[json objectForKey:@"code"] intValue] ) {
            [Notifier UQToast:self.view text:@"用户名不可用" timeInterval:NyToastDuration];
            return ;}
        [Utils post:KgetCode params:[NSDictionary dictionaryWithObjectsAndKeys:_phoneNumberField.text,@"phone", nil] success:^(id obj) {
            if (![[obj objectForKey:@"code"] intValue] ) {
                [Notifier UQToast:self.view text:@"验证码发送失败" timeInterval:NyToastDuration];
                return ;}
            [Notifier UQToast:self.view text:@"验证码发送成功，请注意查收" timeInterval:NyToastDuration];

            _codeStr = [obj objectForKey:@"msg"];
            
        } failure:^(NSError *error) {
            [Notifier UQToast:self.view text:@"验证码发送失败" timeInterval:NyToastDuration];
        }];
        
    } failure:^(NSError *error) {
        [Notifier UQToast:self.view text:@"用户名不可用" timeInterval:NyToastDuration];
        
    }];
}

- (BOOL)checkInputIsValid
{
    NSString *phoneNumber = _phoneNumberField.text;
    if (phoneNumber.length == 0) {
        [Notifier UQToast:self.view text:@"手机号为空，请输入手机号" timeInterval:NyToastDuration];
        return NO;}
    if (phoneNumber.length != 11) {
        [Notifier UQToast:self.view text:@"手机号不符合规范，请重新输入" timeInterval:NyToastDuration];
        return NO;}
       return YES;
}

- (IBAction)buttonClick {
    //验证码通过之后页面跳转
    [self textFieldResign];
    if (![self checkInputIsValid]) return;
    if (_identifyCode.text.length<1) {
        [Notifier UQToast:self.view text:@"请输入验证码" timeInterval:NyToastDuration];
        return;}
    if (![_identifyCode.text isEqualToString:_codeStr]) {
        [Notifier UQToast:self.view text:@"验证码输入错误,请重新输入" timeInterval:NyToastDuration];
        return;}
    DetailUserInforViewController *detailVC = [[DetailUserInforViewController alloc] init];
    detailVC.flagStr = @"忘记密码";
    detailVC.userName = _phoneNumberField.text;
    detailVC.loginPsw = YES;
    [self.navigationController pushViewController:detailVC animated:NO];
    
}
#pragma mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self textFieldResign];
}

- (void)textFieldResign
{
    [_phoneNumberField resignFirstResponder];
    [_identifyCode resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
