//
//  ChangeInforViewController.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/17.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "ChangeInforViewController.h"
#import "DetailUserInforViewController.h"
#import "PopupView.h"
#import "UIImage+fixOrientation.h"
#import "AFNetworking.h"
#import "HeadView.h"
#import "BookDateView.h"
@interface ChangeInforViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSArray *array;//填充表视图的数据
    UITableView *userTableView;
    HeadView *header;;
    UIImage *selectImage;
}

@end

@implementation ChangeInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YXRGB(240, 240, 240);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickNameActon:) name:@"changeNickName" object:nil];
    header = [[HeadView alloc] initWithFrame:KFrame(0, 0, KScreenWidth, 110+KnavHeight)  withTitle:@"个人信息"];
    UIButton *backButton = [UQFactory buttonWithFrame:KFrame(15, KnavHeight-50, 11, 20) backgroundImage:KImage(@"yx_return_Btn")];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:backButton];
    [header.btn addTarget:self action:@selector(changeHeadAction) forControlEvents:UIControlEventTouchUpInside];
    [header.nameBtn addTarget:self action:@selector(changeHeadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:header];
    
    array = @[@"昵称",@"登录密码",@"支付密码",@"性别",@"生日",@"QQ",@"邮箱",@"口味偏好"];
    userTableView = [[UITableView alloc] initWithFrame:KFrame(0, header.bottom, KScreenWidth, 45*array.count) style:UITableViewStylePlain];
    userTableView.delegate = self;
    userTableView.dataSource = self;
    userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    userTableView.sectionHeaderHeight = 100;
    userTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userTableView];
    
    UIImageView *lineImg = [UQFactory imageViewWithFrame:KFrame(0, userTableView.bottom-2, KScreenWidth, 9) image:KImage(@"home_border")];
    [self.view addSubview:lineImg];
    
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *ID = @"userInfor";
    cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  
    cell.textLabel.text = array[indexPath.row];
    UILabel *detailLabel = [UQFactory labelWithFrame:KFrame(0, 12.5, 0, 20) text:nil textColor:[UIColor darkGrayColor]fontSize:14 center:NO];
    detailLabel.tag = 5;
    [cell.contentView addSubview:detailLabel];
    UILabel *line = [UQFactory labelWithFrame:KFrame(0, 39, KScreenWidth, 0.5) text:nil];
    line.backgroundColor = YXRGB(200, 200, 200);
    [cell.contentView addSubview:line];
    NSString *str;
    switch (indexPath.row) {
        case 0://昵称
            str = [UserDefaults objectForKey:@"nickName"];
            break;
            
        case 3://性别
            cell.accessoryType = UITableViewCellAccessoryNone;
            str = [UserDefaults objectForKey:@"gender"];

            break;
        case 4://生日
            cell.accessoryType = UITableViewCellAccessoryNone;
            str = [UserDefaults objectForKey:@"birthday"];

            break;
        case 5://QQ
            str = [UserDefaults objectForKey:@"qq"];

            break;
        case 6://邮箱
            str = [UserDefaults objectForKey:@"email"];

            break;
        case 7://口味偏好
            cell.accessoryType = UITableViewCellAccessoryNone;
            line.hidden = YES;
            str = [UserDefaults objectForKey:@"favoriteTaste"];

            break;

        default:
            break;
            
    }
    detailLabel.text = str;
    if (str.length == 0) {
        detailLabel.width = 80;
    }else{
        detailLabel.width = [Utils getContentHeight:str width:20];}
    detailLabel.left = KScreenWidth-detailLabel.width-30;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:5];

    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2|| indexPath.row == 5|| indexPath.row == 6){
        DetailUserInforViewController *detailVC = [[DetailUserInforViewController alloc] init];
        if (indexPath.row == 2) {
            detailVC.loginPsw = YES;}
        
        [detailVC hadChangeSuccess:^(NSString *infor) {
         label.text = infor;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        detailVC.flagStr = array[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:NO];
        return;
    }
    if (indexPath.row == 4) {
        BookDateView *dateView = [BookDateView bookDateView];
        [dateView showBookDateViewToView:self.view];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        dateView.dateBlock = ^(NSDate *slectedDate){
            NSString *dateStr = [formatter stringFromDate:slectedDate];
            NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
            mDic[@"userId"] = [UserDefaults objectForKey:@"userId"];
            mDic[@"birthday "] = dateStr;
            [Utils post:KperfectUser params:[NSDictionary dictionaryWithObjectsAndKeys:[mDic JSONString], @"json",nil] success:^(id json) {
                if ([json[@"code"] integerValue]) {
                    [Notifier UQToast:AppWindow text:[json objectForKey:@"msg"] timeInterval:NyToastDuration];
                    return ;}
                label.text = dateStr;
                [UserDefaults setObject:dateStr forKey:@"birthday"];
                [Notifier UQToast:AppWindow text:@"信息修改成功" timeInterval:NyToastDuration];

            } failure:^(NSError *error) {
                [Notifier UQToast:AppWindow text:@"信息修改失败" timeInterval:NyToastDuration];
            }];
        };
        return;
    }
    //改性别，生日，口味的弹出框
    PopupView *customView = [PopupView defaultPopupView];
    customView.parentVC = self;

    if (indexPath.row == 3) {
         customView.dataArray = (NSMutableArray *)@[@"男",@"女"];
        [customView hadChangeSuccess:^(NSString *infor) {
            label.text = infor;
        }];

        [customView addSubviewWithOptions:genderOptions];
        
    }else{
        customView.dataArray = (NSMutableArray *)@[@"酸",@"甜",@"苦",@"辣"];
        [customView hadChangeSuccess:^(NSString *infor) {
            label.text = infor;
        }];

        [customView addSubviewWithOptions:tasteOptions];}
    [self lew_presentPopupView:customView animation:[LewPopupViewAnimationSpring new] dismissed:^{
    }];
}

- (void)changeNickNameActon:(NSNotification *)notification
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [userTableView cellForRowAtIndexPath:path];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:5];
    label.text = notification.object;
    [userTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationNone];

}

- (void)changeHeadAction
{
    UIActionSheet *actionSheet ;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }
    else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0: //相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1: //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
                break;
            default:
                break;
        }
    }
    else {
        if (buttonIndex == 0) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //        设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes=[[NSArray alloc]initWithObjects:(NSString *)kUTTypeImage, nil];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.editing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    selectImage = [image fixOrientation];
    //上传图片成功之后发通知
    [self  uploadUserImg];
}

- (void)uploadUserImg
{
    if (![Utils isNetworkConnected]) {
        [Notifier UQToast:self.view text:@"网络连接有问题" timeInterval:NyToastDuration];
        return;}
    [Notifier showHud:self.view text:@"头像上传中……"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //        设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
    NSData *data = UIImageJPEGRepresentation(selectImage,0.5);
    
    [manager POST:kImageUpload parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData>formData){
        
        /*
         //         32          此方法参数
         //         33          1. 要上传的[二进制数据]
         //         34          2. 对应网站上[upload.php中]处理文件的[字段"file"]
         //         35          3. 要保存在服务器上的[文件名]
         //         36          4. 上传文件的[mimeType]
         //         37          */
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        if ([[responseObject objectForKey:@"code"] intValue] ) {
            [Notifier UQToast:self.view text:@"头像设置失败" timeInterval:NyToastDuration];
            return ;}

        NSString *str = [responseObject objectForKey:@"obj"];
        [header.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PicPath,str]] placeholderImage:KImage(@"yx_moren_Img")];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseImage" object:str];
        //成功后传给服务器
        NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:[UserDefaults objectForKey:@"userId"],@"userId",str,@"headImg" ,nil];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[tempDic JSONString],@"json",nil];
        [Utils post:KperfectUser params:dic success:^(id json) {
            if ([Notifier hasHud]) {
                [Notifier dismissHud:NotifyImmediately];}
            if ([[json objectForKey:@"code"] intValue] ) {
                [Notifier UQToast:self.view text:@"头像设置失败" timeInterval:NyToastDuration];
                return ;}
            [Notifier UQToast:self.view text:@"头像设置成功" timeInterval:NyToastDuration];
            [UserDefaults setObject:str forKey:@"headImg"];
            [UserDefaults synchronize];
        } failure:^(NSError *error) {
            if ([Notifier hasHud]) {
                [Notifier dismissHud:NotifyImmediately];}
            [Notifier UQToast:self.view text:@"用户信息修改失败" timeInterval:NyToastDuration];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"---失败了--%@",error);
        if ([Notifier hasHud]) {
            [Notifier dismissHud:NotifyImmediately];
        }
        [Notifier UQToast:self.view text:@"图片上传失败" timeInterval:NyToastDuration];
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
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
