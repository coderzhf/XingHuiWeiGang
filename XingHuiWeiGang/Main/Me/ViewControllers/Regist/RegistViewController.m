//
//  RegistViewController.m
//  login
//
//  Created by 张锋 on 15/7/8.
//  Copyright (c) 2015年 张锋. All rights reserved.
//

#import "RegistViewController.h"
@interface RegistViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *vertifyField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *vertifyPwdField;

@property (weak, nonatomic) IBOutlet UITextField *checkField;
@property (weak, nonatomic) IBOutlet UITextField *againCheckField;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (nonatomic ,strong) NSString *code;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight*1.5);
    self.phoneNumField.delegate=self;
    self.vertifyField.delegate=self;
    self.pwdField.delegate=self;
    self.vertifyPwdField.delegate=self;
    self.checkField.delegate = self;
    self.againCheckField.delegate = self;
}

-(void)viewWillDisAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self textFieldResign];
    
}

- (IBAction)getVertifyNum:(id)sender {
    //判断正确手机号码
    [_phoneNumField resignFirstResponder];
    if (![Utils isNetworkConnected]) {
        [Notifier UQToast:self.view text:@"网络连接有问题,请检查网络设置" timeInterval:NyToastDuration];
        return;}
    if (_phoneNumField.text.length != 11) {
        [Notifier UQToast:self.view text:@"手机号输入有误" timeInterval:NyToastDuration];
        return;
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumField.text,@"userName", nil];
    [Utils post:KshowUser params:dic success:^(id json) {
    if ([[json objectForKey:@"code"] intValue] ) {
        [Notifier UQToast:AppWindow text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
        return ;}
    //手机号验证成功，发送验证码
    [Utils post:KgetCode params:[NSDictionary dictionaryWithObjectsAndKeys:_phoneNumField.text,@"phone", nil] success:^(id obj) {
        if (![[obj objectForKey:@"code"] intValue] ) {
            [Notifier UQToast:AppWindow text:@"验证码发送失败，请重试" timeInterval:NyToastDuration];
            return ;}
        
        [Notifier UQToast:AppWindow text:@"验证码发送成功，请注意查收" timeInterval:NyToastDuration];
        _code = [obj objectForKey:@"msg"];
    
    } failure:^(NSError * error) {
        [Notifier UQToast:AppWindow text:@"验证码发送失败，请重试" timeInterval:NyToastDuration];
    
        }];
        
    } failure:^(NSError *error) {
        [Notifier UQToast:AppWindow text:@"手机号不可用" timeInterval:NyToastDuration];

    }];

 }

- (BOOL)checkInputIsValid
{
    [self textFieldResign];
    NSString *password = _pwdField.text;
    NSString *passwordAgain = _vertifyPwdField.text;
    if (![_code isEqualToString:_vertifyField.text]) {
        [Notifier UQToast:AppWindow text:@"验证码输入错误，请重新输入" timeInterval:NyToastDuration];
        return NO;
    }
    if (passwordAgain.length == 0 ||password.length == 0 || _phoneNumField.text == 0 || _vertifyField.text == 0|| _checkField.text == 0 || _againCheckField.text == 0) {
        [Notifier UQToast:AppWindow text:@"信息填写不全，请完整输入" timeInterval:NyToastDuration];
        return NO;
    }
    if (![password isEqualToString:passwordAgain]) {
        [Notifier UQToast:AppWindow text:@"登录密码输入不一致，请重新输入" timeInterval:NyToastDuration];
        return NO;
    }
    if (![_checkField.text isEqualToString:_againCheckField.text]) {
        [Notifier UQToast:AppWindow text:@"支付密码输入不一致，请重新输入" timeInterval:NyToastDuration];
        return NO;
    }
    return YES;
}

//注册点击
- (IBAction)registButtonClick {
    
    if (![Utils isNetworkConnected]) {
        [Notifier UQToast:self.view text:@"网络连接有问题,请检查网络设置" timeInterval:NyToastDuration];
        return;}
    if (![self checkInputIsValid]) return;
    [Notifier showHud:self.view text:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumField.text,@"userName", _pwdField.text,@"pwd", nil];
    [Utils post:Kreg params:dic success:^(id json) {
        if ([Notifier hasHud]) {
            [Notifier dismissHud:NotifyImmediately];}
        if ([[json objectForKey:@"code"] intValue] ) {
         [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        [self saveUserInfor:[json objectForKey:@"obj"]];//保存用户数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginorLogout" object:nil];//发用户已经登陆成功的通知，更改我界面
        [self.navigationController popToRootViewControllerAnimated:NO ];
        
    } failure:^(NSError *error) {
        if ([Notifier hasHud]) {
            [Notifier dismissHud:NotifyImmediately];}
        [Notifier UQToast:self.view text:@"注册失败" timeInterval:NyToastDuration];
    }];
}

- (void)saveUserInfor:(NSDictionary *)dic
{
    [UserDefaults setObject:[dic objectForKey:@"id"] forKey:@"userId"];
    [UserDefaults setObject:[dic objectForKey:@"loginName"] forKey:@"loginName"];
    //[UserDefaults setObject:[dic objectForKey:@"totalPoints"] forKey:@"totalPoints"];
    //[UserDefaults setObject:[dic objectForKey:@"currentBalance"] forKey:@"currentBalance"];
    //[UserDefaults setObject:dic[@"userType"][@"typeName"] forKey:@"typeName"];
    [UserDefaults setBool:YES  forKey:@"isLogin"];
    [UserDefaults synchronize];
}

//同意条款
- (IBAction)agreeWithRegist:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    self.registBtn.enabled=sender.selected;
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    if (self.checkField == textField || textField == self.againCheckField)
    {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 6) {
            return NO;}
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self textFieldResign];
 }

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[self textFieldResign];

    if (textField == _phoneNumField) {
        [_phoneNumField resignFirstResponder];
        return YES;
    }else if(textField == _vertifyField){
        [_vertifyField resignFirstResponder];
        [_pwdField becomeFirstResponder];
        return YES;
    }else if (textField == _pwdField){
        [_pwdField resignFirstResponder];
        [_vertifyPwdField becomeFirstResponder];
        return YES;
    }else if (textField == _vertifyPwdField){
        [_vertifyPwdField resignFirstResponder];
        [_checkField becomeFirstResponder];
        return YES;
    }else if (textField == _checkField){
        [_checkField resignFirstResponder];
        [_againCheckField becomeFirstResponder];
        return YES;
    }else{
        [_againCheckField resignFirstResponder];
        return YES;
    }
    return NO;
}

- (void)textFieldResign
{
    [_phoneNumField resignFirstResponder];
    [_vertifyField resignFirstResponder];
    [_pwdField resignFirstResponder];
    [_vertifyPwdField resignFirstResponder];
    [_checkField resignFirstResponder];
    [_againCheckField resignFirstResponder];
}
@end
