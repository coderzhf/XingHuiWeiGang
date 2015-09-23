//
//  MeViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "MeViewController.h"
#import "OrderViewController.h"
#import "LoginViewController.h"
#import "ChangeInforViewController.h"
#import "CollectionViewController.h"
#import "DiscountViewController.h"
#import "MessageViewController.h"
#import "MyAccountViewController.h"
#import "SettingViewController.h"
#import "BookOrderViewController.h"

#import "CustomControl.h"
#import "HeadView.h"
#import <ShareSDK/ShareSDK.h>

#define kWidthSet 20
@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    HeadView *header;
    UITableView *_meTableView;
    NSArray *array;
    NSArray *titleArray;
    NSArray *imageArray;
}
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginOrLogout) name:@"LoginorLogout" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserImg:) name:@"chooseImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickNameActon:) name:@"changeNickName" object:nil];

    if (![UserDefaults objectForKey:@"isLogin"]) {
        array = @[@"设置",@"帮助信息",@"分享好友"];
    }else{
        array = @[@"设置",@"帮助信息",@"平台简介",@"投诉建议",@"分享好友"];
    }
    [self initSubViews];
}

- (void)initSubViews
{
    header = [[HeadView alloc] initWithFrame:KFrame(0, 0, KScreenWidth, 110+KnavHeight) withTitle:@"我"];
    header.btn.tag = 208;
    
    [header.btn addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:header];
    
    titleArray= @[@"订单",@"预约",@"排号",@"打包",@"账户",@"收藏",@"优惠券",@"消息"];
    imageArray= @[@"yx_me_order",@"yx_me_appointment",@"yx_me_quene",@"yx_order_Btn",@"yx_account_Btn",@"yx_store_Btn",@"yx_discount_Btn",@"yx_message_Btn"];
    
    _meTableView = [[UITableView alloc] initWithFrame:KFrame(0, header.bottom, KScreenWidth, KScreenHeight-header.bottom-KTarBarHeight) style:UITableViewStylePlain];
    _meTableView.delegate = self;
    _meTableView.dataSource = self;
    _meTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _meTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_meTableView];
}

- (void)LoginOrLogout
{
    //改用户头像/刷新表视图/nickName
    if ([UserDefaults objectForKey:@"isLogin"]) {//登录或注册成功
        if ([UserDefaults objectForKey:@"headImg"]) {
            [header.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PicPath,[UserDefaults objectForKey:@"headImg"]]]];
        }else{
            header.headImg.image = KImage(@"yx_moren_Img");
        }
        NSLog(@"%@",[UserDefaults objectForKey:@"nickName"]);
        
        [header.nameBtn setTitle:[UserDefaults objectForKey:@"nickName"] forState:UIControlStateNormal];
        array = @[@"设置",@"帮助信息",@"平台简介",@"投诉建议"];
    }else{//退出
        header.headImg.image = KImage(@"yx_moren_Img");
        [header.nameBtn setTitle:@"" forState:UIControlStateNormal];
        array = @[@"设置",@"帮助信息"];
    }
    [_meTableView reloadData];
}

- (void)changeUserImg:(NSNotification *)notification
{
    NSString *str = [UserDefaults objectForKey:@"userImg"];
    [header.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PicPath,str]] placeholderImage:KImage(@"yx_moren_Img")];
}

- (void)changeNickNameActon:(NSNotification *)notification
{
    header.nameBtn.titleLabel.text = notification.object;
}

#pragma mark -tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([UserDefaults boolForKey:@"isLogin"]) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (section == 1) {
        return array.count;
     }else{
        return 1;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        int k = 0;
        for (int i = 0; i <  2; i ++) {
            for (int j = 0; j <  4; j ++) {
                CustomControl *imageBtn = [[CustomControl alloc] initWithFrame:CGRectMake(KScreenWidth*j/4,KScreenWidth*i/4, KScreenWidth/4, KScreenWidth/4) WithTitle:titleArray[k] withImage:[UIImage imageNamed:imageArray[k]]];
                imageBtn.tag = 200 + k;
                [cell.contentView addSubview:imageBtn];
                [imageBtn addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
                k ++;
            }
        }
        UIImageView *lineImg = [UQFactory imageViewWithFrame:KFrame(0, KScreenWidth/2+5, KScreenWidth, 9) image:KImage(@"home_border")];
        [cell.contentView addSubview:lineImg];

        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"identifier";
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UILabel *line = [[UILabel alloc] initWithFrame:KFrame(0, 39, KScreenWidth, 0.5)];
            line.backgroundColor = YXRGB(200, 200, 200);
            [cell.contentView addSubview:line];
        }
         if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIImageView *imageView = [UQFactory imageViewWithFrame:KFrame(10, 10, 20, 20) image:KImage(@"yx_setting_Img")];
            UILabel *label = [UQFactory labelWithFrame:KFrame(imageView.right+5, 10, 30, 20)  text:@"设置" textColor:[UIColor blackColor] fontSize:14 center:NO];
            [cell.contentView addSubview:label];
            [cell.contentView addSubview:imageView];
            return cell;}
           cell.textLabel.text = array[indexPath.row];
           cell.textLabel.textColor = [UIColor blackColor];
           cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;

    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor colorWithPatternImage:KImage(@"yx_nav_Bg")];
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (KScreenWidth/2+15);
    }else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if ([UserDefaults objectForKey:@"isLogin"]) {
            if (indexPath.row == 4) {
                [self shareToThird];
                return;}

            if (indexPath.row!=0) {
                SettingViewController *setVC = [[SettingViewController alloc] init];
                setVC.flag = indexPath.row;
                [self.navigationController pushViewController:setVC animated:NO];
                }
          }else{
            if (indexPath.row==1) {
                SettingViewController *setVC = [[SettingViewController alloc] init];
                setVC.flag = indexPath.row;
                [self.navigationController pushViewController:setVC animated:NO];
            }else if (indexPath.row == 2){
                [self shareToThird];
            }

        }
    }else if (indexPath.section == 2) {        //退出登录
                [UserDefaults removeObjectForKey:@"userId"];
                [UserDefaults removeObjectForKey:@"loginName"];
                [UserDefaults removeObjectForKey:@"isLogin"];

                if ([UserDefaults objectForKey:@"age"]) {
                    [UserDefaults removeObjectForKey:@"age"];}
                
                if ([UserDefaults objectForKey:@"gender"]) {
                    [UserDefaults removeObjectForKey:@"gender"];}
                
                [UserDefaults removeObjectForKey:@"nickName"];
                
                if ([UserDefaults objectForKey:@"headerImg"]) {
                    [UserDefaults removeObjectForKey:@"headerImg"];}
                
                if ([UserDefaults objectForKey:@"QQ"]) {
                    [UserDefaults removeObjectForKey:@"QQ"];}
                
                if ([UserDefaults objectForKey:@"email"]) {
                    [UserDefaults removeObjectForKey:@"email"];}
                
                [UserDefaults synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginorLogout" object:nil];//发用户已经退出的通知，更改我界面
            }
    
}
//分享
- (void)shareToThird
{
    //分享
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon-@3x.png" ofType:nil];//放分享的ICON图标
    //构造分享内容
    
    id<ISSContent> publishContent = [ShareSDK content:@""
                                       defaultContent:@"音频类的 APP"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"月秀"
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                           targets:@[@"统计标识1", @"统计标识2"]        //可设置需要的统计的标识，如以分类名称、标题等信息作为标识。
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    
 
}

- (void)myAction:(CustomControl *)button
{
    //测试需要
    if (![UserDefaults boolForKey:@"isLogin"]) {
        UIAlertView *actionSheet = [[UIAlertView alloc] initWithTitle:@"请先注册/登录" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [actionSheet show];
        return;
    }else{
        switch (button.tag) {
            case 200:{
                //订单
                OrderViewController *MyOrdersVC = [[OrderViewController alloc] init];
                [self.navigationController pushViewController:MyOrdersVC animated:NO];
            }
                break;
            case 201:{
                //预约
                BookOrderViewController *BookVC = [[BookOrderViewController alloc] init];
                BookVC.orderType = @21;
                [self.navigationController pushViewController:BookVC animated:NO];
                   }
                break;
            case 202:{
                //排号
                BookOrderViewController *BookVC = [[BookOrderViewController alloc] init];
                BookVC.orderType = @19;
                [self.navigationController pushViewController:BookVC animated:NO];
                }
                break;
            case 203:{
                //打包
                BookOrderViewController *BookVC = [[BookOrderViewController alloc] init];
                BookVC.orderType = @20;
                [self.navigationController pushViewController:BookVC animated:NO];

            }
                break;
            case 204:{
                //账户
                MyAccountViewController *myAccountVC = [[MyAccountViewController alloc] init];
                [self.navigationController pushViewController:myAccountVC animated:NO];
            }
                break;
            case 205:{
                //收藏
                CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
                [self.navigationController pushViewController:collectionVC animated:NO];
            }
                break;
            case 206:{
                //从我进优惠券，显示所有商家的优惠券
                DiscountViewController *discountVC = [[DiscountViewController alloc] init];
                discountVC.isAll = NO;
                [self.navigationController pushViewController:discountVC animated:NO];
            }
                break;
            case 207:{
                //消息
                MessageViewController *messageViewVC = [[MessageViewController alloc] init];
                [self.navigationController pushViewController:messageViewVC animated:NO];
            }
                break;

            case 208:{
                //修改用户信息
                ChangeInforViewController *changeVC = [[ChangeInforViewController alloc] init];
                [self.navigationController pushViewController:changeVC animated:NO];
            }
                break;

            default:
                break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:NO];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
