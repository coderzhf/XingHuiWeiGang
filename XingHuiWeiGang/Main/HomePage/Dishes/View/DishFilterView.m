//
//  DishFilterView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/26.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishFilterView.h"
#import "DishTool.h"

@interface DishFilterView()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end
@implementation DishFilterView
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
}

+ (instancetype)filterView {
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]firstObject];
}

- (void)awakeFromNib {
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
       
}
- (void)setIsCuisine:(BOOL)isCuisine {
    _isCuisine = isCuisine;
    
    if (self.isCuisine) {
        [self getCuisineData];
    } else {
        [self getDishesTypeData];
    }

}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"filterView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, cell.frame.size.width, 0.5)];
        lineView.backgroundColor = YXRGB(192, 192, 192);
        [cell.contentView addSubview:lineView];
    }
    if (self.isCuisine) {
        showCuisineResult *result = self.dataArray[indexPath.row];
        cell.textLabel.text = result.typeName;
    } else {
        showDishesTypeResult *result = self.dataArray[indexPath.row];
        cell.textLabel.text = result.typeName;
    }

    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor = YXRGB(242, 242, 242);
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isCuisine) {
        
        showCuisineResult *result = self.dataArray[indexPath.row];
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath withId:result.CuisineID withName:result.typeName isCuisine:YES];
    } else {
        
        showDishesTypeResult *result = self.dataArray[indexPath.row];
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath withId:result.DishesTypeID withName:result.typeName isCuisine:NO];
    }

}



-(void)getCuisineData{
    
    __weak typeof(self) Weakself=self;
    [DishTool dishesShowCuisinesuccess:^(id json) {
        NSArray *data = json[@"list"];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in data) {
            showCuisineResult *result = [showCuisineResult objectWithKeyValues:dict];
            result.CuisineID = dict[@"id"];
            [tempArray addObject:result];
        }
        Weakself.dataArray =tempArray;
        [Weakself.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)getDishesTypeData{
    
    __weak typeof(self) Weakself=self;
    [DishTool dishesTypesuccess:^(id json) {
        
        NSArray *data = json[@"list"];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in data) {
            showDishesTypeResult *result = [showDishesTypeResult objectWithKeyValues:dict];
            result.DishesTypeID = dict[@"id"];
            [tempArray addObject:result];
        }
         Weakself.dataArray =tempArray;
        [Weakself.tableView reloadData];

    } failure:^(NSError *error) {
        
    }];
    

}
@end
