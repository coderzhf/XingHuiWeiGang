//
//  DetailUserInforViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/20.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DetailUserInforViewController.h"

@interface DetailUserInforViewController ()
{
    UITextField *textFieldOne;
    UITextField *textFieldTwo;
    UITextField *textFieldThree;
}
@end

@implementation DetailUserInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YXRGB(240, 240, 240);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:KFrame(0, 0, KScreenWidth, 150)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIImageView *imageViewTxtView = [[UIImageView alloc] initWithFrame:KFrame((KScreenWidth-280)/2, 30, 280, 45)];
    imageViewTxtView.userInteractionEnabled = YES;
    imageViewTxtView.image = KImage(@"yx_textField_Bg");
    [imageView addSubview:imageViewTxtView];

    textFieldOne = [UQFactory textFieldWithFrame:KFrame(10, 7, 270, 30) placeholder:nil text:nil borderStyle:0 backgroundColor:nil center:NO delegate:self];
    textFieldOne.font = [UIFont systemFontOfSize:16];
    [imageViewTxtView addSubview:textFieldOne];
  
    
    if ([_flagStr isEqualToString:@"昵称"]) {
        self.title = @"更改昵称";
        textFieldOne.placeholder = @"请输入新的昵称";
        
    }else if ([_flagStr isEqualToString:@"登录密码"] || [_flagStr isEqualToString:@"忘记密码"]){
        imageView.height = 200;
        imageViewTxtView.height = 90;
        imageViewTxtView.image = KImage(@"yx_loginText_Bg");
        
        textFieldTwo = [UQFactory textFieldWithFrame:KFrame(10, 52, 270, 30) placeholder:nil text:nil borderStyle:0 backgroundColor:nil  center:NO delegate:self];
        textFieldTwo.font = [UIFont systemFontOfSize:16];
        textFieldOne.returnKeyType = UIReturnKeyNext;
        textFieldOne.secureTextEntry = YES;
        textFieldTwo.secureTextEntry = YES;
        textFieldTwo.returnKeyType = UIReturnKeyDone;
        [imageViewTxtView addSubview:textFieldTwo];
        
        if([_flagStr isEqualToString:@"登录密码"]){
            self.title = @"登录密码";
            textFieldOne.placeholder = @"输入登录密码";
            textFieldTwo.placeholder = @"再次输入登录密码";
        }else{
            self.title = @"重置密码";
            textFieldOne.placeholder = @"输入新密码";
            textFieldTwo.placeholder = @"再次输入新密码";
        }
        
    }else if ([_flagStr isEqualToString:@"QQ"]){
        textFieldOne.placeholder = @"请输入新的QQ";
        textFieldOne.keyboardType = UIKeyboardTypePhonePad;
        self.title = @"更改QQ";
        
    }else if ([_flagStr isEqualToString:@"邮箱"]){
        textFieldOne.placeholder = @"请输入新的邮箱";
        textFieldOne.keyboardType = UIKeyboardTypeEmailAddress;
        self.title = @"更改邮箱";
    }else{
        imageView.height = 250;
        self.title = @"支付密码";
        UIImageView *imageViewTwo = [[UIImageView alloc] initWithFrame:KFrame((KScreenWidth-280)/2, 80, 280, 45)];
        imageViewTwo.userInteractionEnabled = YES;
        imageViewTwo.image = KImage(@"yx_textField_Bg");
        [imageView addSubview:imageViewTwo];
        
        textFieldTwo = [UQFactory textFieldWithFrame:KFrame(10, 7, 270, 30) placeholder:nil text:nil borderStyle:0 backgroundColor:nil center:NO delegate:self];
        textFieldTwo.font = [UIFont systemFontOfSize:16];
        [imageViewTwo addSubview:textFieldTwo];
        
        UIImageView *imageViewThree = [[UIImageView alloc] initWithFrame:KFrame((KScreenWidth-280)/2, 130, 280, 45)];
        imageViewThree.userInteractionEnabled = YES;
        imageViewThree.image = KImage(@"yx_textField_Bg");
        [imageView addSubview:imageViewThree];
        
        textFieldThree = [UQFactory textFieldWithFrame:KFrame(10, 7, 270, 30) placeholder:nil text:nil borderStyle:0 backgroundColor:nil center:NO delegate:self];
        textFieldThree.font = [UIFont systemFontOfSize:16];
        [imageViewThree addSubview:textFieldThree];
        
        textFieldOne.placeholder = @"输入旧支付密码";
        textFieldTwo.placeholder = @"输入新支付密码";
        textFieldThree.placeholder = @"再次输入支付密码";
        
        textFieldOne.secureTextEntry = YES;
        textFieldTwo.secureTextEntry = YES;
        textFieldThree.secureTextEntry = YES;
        textFieldOne.keyboardType = UIKeyboardTypePhonePad;
        textFieldTwo.keyboardType = UIKeyboardTypePhonePad;
        textFieldThree.keyboardType = UIKeyboardTypePhonePad;

    }
    
    UIButton *confirmButton = [UQFactory buttonWithFrame:KFrame((KScreenWidth-70)/2, imageView.bottom - 50, 70, 30) image:KImage(@"login_button") title:@"确定" titleColor:[UIColor whiteColor] fontSize:16];
    [confirmButton addTarget:self action:@selector(comfirmAction) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:confirmButton];
}

- (void)comfirmAction
{
    [self textFieldResign];
    if (![Utils isNetworkConnected]) {
        [Notifier UQToast:self.view text:@"网络连接有问题,请检查网络设置" timeInterval:NyToastDuration];
        return;}
    if (textFieldOne.text.length == 0 ||(textFieldTwo && textFieldTwo.text.length == 0)||(textFieldThree && textFieldThree.text.length == 0)) {
        [Notifier UQToast:self.view text:@"输入不能为空" timeInterval:NyToastDuration];
        return;}
    if (!textFieldThree && textFieldTwo && ![textFieldOne.text isEqualToString:textFieldTwo.text] ) {
        [Notifier UQToast:self.view text:@"请保证两次输入一致" timeInterval:NyToastDuration];
        return;}
    if (textFieldThree && ![textFieldThree.text isEqualToString:textFieldTwo.text ]) {
        [Notifier UQToast:self.view text:@"请保证两次输入一致" timeInterval:NyToastDuration];
        return;}
    
    [Notifier showHud:self.view text:@"提交修改中"];
    NSString *url;
    NSMutableDictionary *mDiC = [[NSMutableDictionary alloc] initWithCapacity:0];
    if ([UserDefaults objectForKey:@"userId"]) {
        [mDiC setObject:[UserDefaults objectForKey:@"userId"] forKey:@"userId"];
    }

    if ([_flagStr isEqualToString:@"登录密码"]) {
        //修改登录密码
        url = Kupdatepwd;
        [mDiC setObject:[UserDefaults objectForKey:@"userId"] forKey:@"userId"];
        [mDiC setObject:textFieldTwo.text forKey:@"newPwd"];

    }else if ([_flagStr isEqualToString:@"支付密码"]){
        // 修改支付密码
        url = KupdatePayPwd;
        [mDiC setObject:textFieldTwo.text forKey:@"newPayPwd"];
        [mDiC setObject:textFieldOne.text forKey:@"oldPayPwd"];


    }else if([_flagStr isEqualToString:@"忘记密码"]){
        //找回密码
        url = KfindPwd;
        [mDiC setObject:textFieldTwo.text forKey:@"newPwd"];
        [mDiC setObject:_userName forKey:@"userName"];

    }else{
        //修改昵称,,qq,,邮箱
        url = KperfectUser;
        [self returnDic:mDiC];
    }
    NSDictionary *finalDic = _loginPsw?[NSDictionary dictionaryWithDictionary:mDiC]:[NSDictionary dictionaryWithObjectsAndKeys:[mDiC JSONString],@"json",nil];
    [Utils post:url params:finalDic success:^(id json) {
        if ([Notifier hasHud]) {
            [Notifier dismissHud:NotifyImmediately];}
        if ([[json objectForKey:@"code"] intValue] ) {
            [Notifier UQToast:self.view text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
            return ;}
        [Notifier UQToast:self.view text:@"信息修改成功" timeInterval:NyToastDuration];
        if ([_flagStr isEqualToString:@"昵称"]) {
            [UserDefaults setObject:textFieldOne.text forKey:@"nickName"];
            //通知修改昵称,一对多
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNickName" object:textFieldOne.text];
        }
        else if ([_flagStr isEqualToString:@"QQ"]){
            [UserDefaults setObject:textFieldOne.text forKey:@"qq"];
            if (_changeSussessBlock) {//block修改QQ，一对一
                _changeSussessBlock(textFieldOne.text);}
            
        }else if ([_flagStr isEqualToString:@"邮箱"]){
            [UserDefaults setObject:textFieldOne.text forKey:@"email"];
            if (_changeSussessBlock) {//block修改邮箱，一对一
                _changeSussessBlock(textFieldOne.text);}
            
        }else if ([_flagStr isEqualToString:@"支付密码"] || [_flagStr isEqualToString:@"登录密码"]){
            [self.navigationController popToRootViewControllerAnimated:NO];
            return;
        }
        [self.navigationController popViewControllerAnimated:NO];
        } failure:^(NSError *error) {
            if ([Notifier hasHud]) {
                [Notifier dismissHud:NotifyImmediately];}
            [Notifier UQToast:self.view text:@"信息修改失败" timeInterval:NyToastDuration];
        }];
}

- (void)returnDic:(NSMutableDictionary *)mDiC
{
    if ([_flagStr isEqualToString:@"昵称"]) {
        [mDiC setObject:textFieldOne.text forKey:@"nickName"];
    }else if([_flagStr isEqualToString:@"QQ"]) {
        [mDiC setObject:textFieldOne.text forKey:@"qq"];
    }else if([_flagStr isEqualToString:@"邮箱"]) {
        [mDiC setObject:textFieldOne.text forKey:@"email"];
    }
}

- (void)hadChangeSuccess:(changeUserBlock)successBlock
{
    self.changeSussessBlock = successBlock;
}
#pragma mark UITextFieldDelegate
#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    if (textFieldThree && (textFieldOne == textField || textField == textFieldTwo|| textField == textFieldThree))
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
    if (textField.returnKeyType == UIReturnKeyNext) {
        [textFieldOne resignFirstResponder];
        [textFieldTwo becomeFirstResponder];
        return YES;
    }else{
        [textFieldTwo resignFirstResponder];
        return YES;
    }
    return NO;
}
- (void)textFieldResign
{
    [textFieldOne resignFirstResponder];
    if (textFieldTwo) {
        [textFieldTwo resignFirstResponder];
    }
    if (textFieldThree) {
        [textFieldThree resignFirstResponder];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
