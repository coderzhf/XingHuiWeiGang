//
//  BussinessDishInfoViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BussinessDishInfoViewController.h"
#import "HomeSegmentView.h"
#import "BussinessDishController.h"
#import "DishTypeViewController.h"
#import "ShowDishesParam.h"
#import "ShowShopResult.h"
#import "TitleButton.h"
@interface BussinessDishInfoViewController ()<HomeSegementViewDelegate>
@property(nonatomic,strong)BussinessDishController *dishesVC;
@property(nonatomic,weak)DishTypeViewController *dishTypeVc;
@property(nonatomic,strong)HomeSegmentView *segement;
@property(nonatomic,strong)NSNumber *tasteId;
@property(nonatomic,assign)NSInteger selcetedTag;
@property (nonatomic, strong) TitleButton *choiceButton;
@end

@implementation BussinessDishInfoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupHeaderView];
    
    [self setupChildrenControllers];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chooceDishType:) name:DishTypeNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark init
-(void)setupHeaderView{
    
    HomeSegmentView *segement=[HomeSegmentView initButtonWithTitleArray: @[@"热门",@"最新",@"价格",@"筛选"]type: @[@(BussinessHotDishes),@(BussinessNewDishes),@(BussinessPriceDishes),@(BussinessChoiceDishes)]];
    segement.delegate = self;
    [self.view addSubview:segement];
    __weak typeof(self) Weakself = self;
    segement.chooceTypeBlock = ^(BOOL isSelected){
        Weakself.dishTypeVc.tableView.hidden = NO;
    };
    self.segement=segement;
    self.choiceButton = segement.choiceButton;
    [segement autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [segement autoSetDimension:ALDimensionHeight toSize:44];
    
    self.title = [NSString stringWithFormat:@"%@-全部菜式",self.ShowShop.shopName];
    
}
-(void)setupChildrenControllers{
   
    self.dishesVC=[[BussinessDishController alloc]init];
    [self addChildViewController:self.dishesVC];
    [self.view addSubview:self.dishesVC.tableView];
    [self HomeSegementWithTag:BussinessHotDishes];
    [self.dishesVC.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.dishesVC.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.segement withOffset:0];
    
    DishTypeViewController *dishTypeVc = [[DishTypeViewController alloc]init];
    [self addChildViewController:dishTypeVc];
    [self.view addSubview:dishTypeVc.tableView];
    [dishTypeVc.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.segement];
    [dishTypeVc.tableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
    [dishTypeVc.tableView autoSetDimension:ALDimensionHeight toSize:250];
    [dishTypeVc.tableView autoSetDimension:ALDimensionWidth toSize:KScreenWidth/4];
    dishTypeVc.tableView.hidden = YES;
    self.dishTypeVc = dishTypeVc;

    
}
#pragma mark - HomeSegementViewDelegate
-(void)HomeSegementWithTag:(NSInteger)tag {
    
    ShowDishesParam *showDishes = [[ShowDishesParam alloc]init];
    showDishes.shopId = self.ShowShop.shopId;
    showDishes.tasteId = self.tasteId;
    switch (tag) {
        case BussinessHotDishes:
            showDishes.isHot = @1;
            break;
        case BussinessNewDishes:
            showDishes.isNew = @1;
            break;
        case BussinessPriceDishes:
            showDishes.isPrice = @1;
            break;
        default:
            break;
    }
    self.dishesVC.showDishes = showDishes;
    self.selcetedTag = tag;
    
}
#pragma mark - action

-(void)chooceDishType:(NSNotification *)note {
    
    self.tasteId =note.userInfo[DishTypeID];
    self.choiceButton.titleLabel.text = note.userInfo[DishTypeName];
    self.dishTypeVc.tableView.hidden = YES;
    [self HomeSegementWithTag:self.selcetedTag];
}
@end
