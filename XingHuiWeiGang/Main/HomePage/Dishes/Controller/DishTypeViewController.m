//
//  DishTypeViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/7.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//
#define typeCell @"typeCell"
#import "DishTypeViewController.h"
#import "DinnerCartTool.h"
@interface DishTypeViewController ()
@property(nonatomic,strong)NSArray *typesArray;
@end

@implementation DishTypeViewController
- (NSArray *)typesArray {
    if (!_typesArray) {
        _typesArray = [[NSArray alloc]init];
    }
    return _typesArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:typeCell];
    [self loadData];
    
}

- (void)loadData {
    showSysTypeParam *param = [[showSysTypeParam alloc]init];
    param.sysType = @"TASTE_TYPE";
    __weak typeof(self) Weakself = self;
    [DinnerCartTool showSysTypeWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in json[@"list"]) {
            DishTypes *dishType = [DishTypes objectWithKeyValues:dict];
            dishType.ID = dict[@"id"];
            [temp addObject:dishType];
        }
        Weakself.typesArray = temp;
        [Weakself.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:typeCell forIndexPath:indexPath];
    DishTypes *type =self.typesArray[indexPath.row];
    cell.textLabel.text = type.typeName;
    cell.backgroundColor = YXRGB(247, 247, 247);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DishTypeID] = [self.typesArray[indexPath.row] ID];
    dict[DishTypeName] = [self.typesArray[indexPath.row] typeName];
   [[NSNotificationCenter defaultCenter]postNotificationName:DishTypeNotification object:nil userInfo:dict];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
