//
//  DishesCollectionViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/12.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishesCollectionViewController.h"
#import "CollectionViewCell.h"
#import "CollectionModel.h"
#import "DishTool.h"
#import "MBProgressHUD+MJ.h"
@interface DishesCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation DishesCollectionViewController
int const margin = 15;
static NSString * const reuseIdentifier = @"DishesCell";
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupCollectionView];
    
}
- (void)loadData {
    showAttentionDishesParam *param = [[showAttentionDishesParam alloc]init];
    param.userId = @27;
    __weak typeof(self) Weakself=self;
    [DishTool showAttentionDishesWithParam:param success:^(id json) {
        if ([json[@"code"] integerValue]) {
            //  [Notifier UQToast:self.view text:@"密码修改不成功" timeInterval:NyToastDuration];
            return ;
        }
        NSArray *data = json[@"list"];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in data) {
            CollectionModel *result = [CollectionModel objectWithKeyValues:dict];
            [tempArray addObject:result];
        }
        Weakself.dataArray =tempArray;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];

}
- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    CollectionModel *result = self.dataArray[indexPath.item];
    cell.collectionModel = result;
    __weak typeof(self) Weakself = self;
    cell.block = ^(BOOL isDish,BOOL isSuceess ){
        if (!isDish) return ;
        if (isSuceess) {
            [Weakself.dataArray removeObjectAtIndex:indexPath.row];
            [Weakself.collectionView reloadData];
            [MBProgressHUD showSuccess:@"取消关注"];
        }else{
            [MBProgressHUD showError:@"取消关注失败"];

        }
        
    };
    //[cell.cacelButton addTarget:self action:@selector(cacelAttentionWithIndexPath:indexPath) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = KScreenWidth*0.5 - margin*2;
    return CGSizeMake(width, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(margin, margin,margin, margin);
}
@end
