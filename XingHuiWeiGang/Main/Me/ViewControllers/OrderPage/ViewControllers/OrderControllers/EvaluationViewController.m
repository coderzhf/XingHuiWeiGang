//
//  EvaluationViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/25.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "EvaluationViewController.h"
#import "OrderDidfinishedCell.h"
#import "EvaluationBottomView.h"
#import "orderDishes.h"
#import "OrderTool.h"
#import "Comment.h"
@interface EvaluationViewController ()
@property (nonatomic, strong) EvaluationBottomView *evalBottomView;
@property (nonatomic, strong) NSArray *dishesLists;
@property (nonatomic, strong) NSMutableArray *commentlists;
@end

@implementation EvaluationViewController
- (EvaluationBottomView *)evalBottomView {
    if (!_evalBottomView) {
        _evalBottomView = [EvaluationBottomView bottomView];
        [_evalBottomView.evaluationButton addTarget:self action:@selector(evaluateFinish) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evalBottomView;
}
- (NSMutableArray *)commentlists {
    if (!_commentlists) {
        _commentlists = [NSMutableArray array];
    }
    return _commentlists;
}
- (void)viewDidLoad {
    self.cellClass = [OrderDidfinishedCell class];
    [super viewDidLoad];
    self.title = @"评价";

}
- (void)setOrder:(showWillPayOrder *)order {

    _order = order;
    self.dishesLists = order.dishesInfoList;
}
- (void)LoadNewData {
    
    [self.dishesLists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        orderDishes *order = obj;
        order.isComment = YES;
        Comment *comment = [[Comment alloc]init];
        comment.dishesId = order.dishesInfoId;
        comment.score = @4;
        comment.content = @"我觉得蛮好";
        [self.commentlists addObject:comment];

    }];
    self.dataArray = self.dishesLists;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return @"请评价菜品";
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return self.evalBottomView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 245;
}
#pragma mark - action
- (void)evaluateFinish {
#warning 后台传参格式有问题。。。。。。
    addCommentParam *param = [[addCommentParam alloc]init];
    param.commentLists = self.commentlists;
//    param.orderId  = self.order.orderId;
//    param.userId = @27;
    
    NSString * json = [NSString stringWithFormat:@"%@",[[param.keyValues JSONString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:json,@"json", self.order.orderId,@"orderId",@27 ,@"userId",nil];
   // __weak typeof(self) Weakself = self;
    
    [OrderTool addCommentWithParam:dict success:^(id json) {
        
        NSLog(@"%@",json);
        
    } failure:^(NSError *error) {
        
    }];

}


@end
