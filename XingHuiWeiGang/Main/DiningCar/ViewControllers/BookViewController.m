//
//  BookViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/28.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BookViewController.h"
#import "OrderDetailViewController.h"
#import "BookDateView.h"
#import "BookTimeView.h"
#import "DinnerCartTool.h"
#import "JSONKit.h"
#import "MBProgressHUD+MJ.h"
@interface BookViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIAlertView *numAlertView;
@property(nonatomic,strong)UIAlertView *nameAlertView;
@property(nonatomic,strong)UIAlertView *phoneAlertView;
@property(nonatomic,strong)UIAlertView *submitAlertView;
@property(nonatomic,strong)UIAlertView *bookSucessAlertView;
@property(nonatomic,strong)addOrderResult *result;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) NSDateFormatter *dateFormate;
@property (nonatomic, strong) NSNumber *typeId;
@end

@implementation BookViewController
- (NSDateFormatter *)dateFormate {
    if (_dateFormate == nil) {
        _dateFormate = [[NSDateFormatter alloc]init];
    }
    return _dateFormate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预订";
    [self loadDefaultData];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)setDishInfoLists:(NSArray *)dishInfoLists {
    _dishInfoLists = dishInfoLists;
}
- (void)loadDefaultData {
        self.dateLabel.text = [self dateFormateStr:[NSDate date]];
    
}
#pragma mark - UIAlertViewDelegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   if (alertView==self.nameAlertView) {
        UITextField *field = [alertView textFieldAtIndex:0];
        switch (buttonIndex) {
            case 0:
                if (![field.text isEqualToString:@""])
                {
                    self.nameLabel.text =field.text;
                }
                break;
            default:
                break;
        }
    }else if (alertView==self.phoneAlertView) {
        UITextField *field = [alertView textFieldAtIndex:0];
        switch (buttonIndex) {
            case 0:
                if (![field.text isEqualToString:@""])
                {
                    self.phoneLabel.text =field.text;
                }
                break;
            default:
                break;
        }
    }else if (alertView==self.numAlertView) {
        UITextField *field = [alertView textFieldAtIndex:0];
        switch (buttonIndex) {
            case 0:
                if (![field.text isEqualToString:@""])
                {
                    self.numLabel.text =[NSString stringWithFormat:@"%@人",field.text];
                }
                break;
            default:
                break;
        }
    }else if (alertView==self.bookSucessAlertView) {
        switch (buttonIndex) {
            case 0:
            {
                OrderDetailViewController *orderVc = [[OrderDetailViewController alloc]init];
                orderVc.isPack = NO;
                orderVc.result = self.result;
                [self.navigationController pushViewController:orderVc animated:YES];
                 break;
            }
            default:
                break;
        }
    }else if (alertView==self.submitAlertView) {
        switch (buttonIndex) {
            case 0:
            {
                OrderDetailViewController *orderVc = [[OrderDetailViewController alloc]init];
                orderVc.isWaiting = YES;
                orderVc.result = self.result;
                [self.navigationController pushViewController:orderVc animated:YES];
                break;
            }
            default:
                break;
        }
    }

}

#pragma mark - action
- (IBAction)submitClick {
  
    addOrderParam *param = [[addOrderParam alloc]init];
    param.dishesInfoList = self.dishInfoLists;
    param.personCount = [NSNumber numberWithInteger:[self.numLabel.text integerValue]];
    param.changCi = self.typeId;
    param.bookingDate = self.dateLabel.text;
    param.userId = @27;
    param.userCarts = self.userCarts;

    NSString * json = [NSString stringWithFormat:@"%@",[[param.keyValues JSONString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:json,@"json", nil];
    __weak typeof(self) Weakself = self;
    [DinnerCartTool addOrderWithParam:dict success:^(id json) {
        if ([json[@"code"] integerValue]) {
            if ([json[@"code"] integerValue]== -2 ) {
                Weakself.result = [[addOrderResult alloc]init];
                Weakself.result.obj = json[@"obj"];
                Weakself.submitAlertView = [[UIAlertView alloc] initWithTitle:nil message:json[@"msg"] delegate:Weakself cancelButtonTitle:@"去排号" otherButtonTitles:@"取消", nil];
                [Weakself.submitAlertView show];
            }
            return ;
        }
        Weakself.result = [[addOrderResult alloc]init];
        Weakself.result.obj = json[@"obj"];
        Weakself.bookSucessAlertView = [[UIAlertView alloc] initWithTitle:nil message:json[@"msg"] delegate:Weakself cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [Weakself.bookSucessAlertView show];
    } failure:^(NSError *error) {
        
    }];

}
- (IBAction)chooseBookDate {
   
    BookDateView *dateView = [BookDateView bookDateView];
    [dateView showBookDateViewToView:self.view];
    __weak typeof(self) Wealkself = self;
    dateView.dateBlock = ^(NSDate *slectedDate){
        Wealkself.dateLabel.text = [Wealkself dateFormateStr:slectedDate];
    };
}
- (IBAction)chooseDinnerTime {
    [MBProgressHUD showMessage:@"正在获取可预订的就餐时间" toView:self.view];
    showSysTypeParam *param = [[showSysTypeParam alloc]init];
    param.time = self.dateLabel.text;
    param.sysType = @"SCREENINGS";
    __weak typeof(self) Weakself = self;
    [DinnerCartTool showSysTypeWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            [MBProgressHUD hideHUDForView:Weakself.view];
            [MBProgressHUD showError:@"您的预约不在服务时间内"];
            return ;
        }
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in json[@"list"]) {
            bookTimeResult *bookTime = [bookTimeResult objectWithKeyValues:dict];
            bookTime.ID = dict[@"id"];
            [temp addObject:bookTime];
        }
        [MBProgressHUD hideHUDForView:Weakself.view];
        BookTimeView *timeView = [BookTimeView bookTimeView];
        timeView.modelArray = temp;
        [timeView showBookTimeViewToView:Weakself.view];
        timeView.block = ^(NSNumber *ID ,NSString *typeName){
            Weakself.timeLabel.text = typeName;
            Weakself.typeId = ID;
        };
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];

    }];
    
}
- (IBAction)choosePeopleNum {
    self.numAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入就餐人数" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    self.numAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [self.numAlertView show];
}
- (IBAction)chooseName {
    self.nameAlertView = [[UIAlertView alloc] initWithTitle:@"联系人" message:@"请填写联系人称呼" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    self.nameAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [self.nameAlertView show];
}
- (IBAction)choosetel {
    self.phoneAlertView = [[UIAlertView alloc] initWithTitle:@"联系方式" message:@"请填写手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    self.phoneAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [self.phoneAlertView show];
}
- (NSString *)dateFormateStr:(NSDate *)date {
    
    [self.dateFormate setDateFormat:@"yyyy-MM-dd"];
    
    return [self.dateFormate stringFromDate:date];
}
@end
