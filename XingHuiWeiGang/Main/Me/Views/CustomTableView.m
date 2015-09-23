//
//  CustomTableView.m
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "CustomTableView.h"
#import "MessageCell.h"
#import "DiscountCell.h"
#import "AccountCell.h"
#import "ShakeDiscountModel.h"

@implementation CustomTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = YXRGB(240, 240, 240);
    }
    return self;
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    [self reloadData];
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    switch (_styleFlag) {
        case 0:{//账户
            identifier = @"Account";
            AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                
            }
            NSDictionary *dic = _array[indexPath.row];
            cell.customerTitle.text = dic[@"title"];
            cell.customerContent.text = dic[@"count"];
            cell.customerTime.text = dic[@"time"];
           // NSString *imgStr = [NSString stringWithFormat:@"%@%@",PicPath,dic[@""]];
            //[cell.customerImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:KImage(@"")];
            return cell;
        }
            break;
        case 1:{//消息
            identifier = @"message";
            MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
             //       cell.discountModel = _array[indexPath.row];
            //        cell.messageLabel.text = dic[@""];
            //        cell.timeLabel.text = dic[@""];
            return cell;

        }
            break;
        case 2:{//优惠券
            identifier = @"discount";
            DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[DiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];}
                cell.discountModel = _array[indexPath.row];
            
            return cell;
        }
            break;

        default:
            break;
    }
     return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_styleFlag == 0) {//账户
        return 80;
    }else if (_styleFlag == 1){//消息
        return 80;
    }else{//优惠券
        return 120;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

@end
