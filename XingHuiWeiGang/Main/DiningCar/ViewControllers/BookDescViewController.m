//
//  BookDescViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/4.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BookDescViewController.h"
#import "DinnerCartTool.h"
@interface BookDescViewController ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLongLabel;

@end

@implementation BookDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YXRGBA(0, 0, 0, 0.5);
    [self loadData];
}
- (void)loadData {
    
    __weak typeof (self) Weakself = self;
    [DinnerCartTool showBookMessageWithParam:nil success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSDictionary *dict = json[@"obj"];
        Weakself.messageLabel.text = dict[@"msg"];
        Weakself.timeLongLabel.text = dict[@"timeLomg"];

    } failure:^(NSError *error) {
    }];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)buttonClick {
    
    if (self.willBookBlock) {
        self.willBookBlock();
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}
@end
