//
//  DishesDetailViewController.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/10.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "DishesViewController.h"
#import "DishFilterView.h"
#import "HeaderSearchView.h"
#import "DishListsViewController.h"
#import "DishesSearchViewController.h"
#import "DishTool.h"
#import "MBProgressHUD+MJ.h"
@interface DishesViewController ()<UIGestureRecognizerDelegate,DishFilterViewDelegate>{
    
    UIView *_maskView;
    UIView *_filterView;
}
@property(nonatomic,strong)DishListsViewController *dishesVc;

@property (nonatomic, strong)HeaderSearchView *searchView;
@property (nonatomic, strong) DishFilterView *dishfilterView;
@property (nonatomic, strong) ShowDishesParam *dishPararm;
@end

@implementation DishesViewController

- (ShowDishesParam *)dishPararm {
    
    if (!_dishPararm) {
        
        _dishPararm = [[ShowDishesParam alloc]init];
    }
    return _dishPararm;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}
- (void)loadView {
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.preferredContentSize=self.view.size;
    [self setupNavItem];
    [self initViews];
    [self setupTableView];
    [self initMaskView];
}

- (void)setupNavItem {
    self.title = @"点菜列表";
    
    HeaderSearchView *searchView=[[HeaderSearchView alloc]init];
    searchView.frame=CGRectMake(KScreenWidth-150, KnavHeight-50, KScreenWidth-120, 44);
    searchView.placeholderText=@"请输入搜索内容";
    searchView.optionHiden = YES;
    [searchView.textField addTarget:self action:@selector(textFieldSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.navigationItem.titleView = searchView;
    self.searchView = searchView;
    
    UIButton *search=[UIButton buttonWithType:UIButtonTypeCustom];
    [search setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [search addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    search.width=25;
    search.height=25;
    search.contentMode=UIViewContentModeCenter;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:search];
}
-(void)initViews{
    //筛选
    _filterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    _filterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_filterView];
    
    NSArray *filterName = @[@"全部菜式",@"全部菜品"];
    //筛选
    for (int i = 0; i < 2; i++) {
        //文字
        UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        filterBtn.frame = CGRectMake(i*KScreenWidth/2, 0, KScreenWidth/2-15, 40);
        filterBtn.tag = 100+i;
        filterBtn.font = [UIFont systemFontOfSize:13];
        [filterBtn setTitle:filterName[i] forState:UIControlStateNormal];
        [filterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [filterBtn setTitleColor:YXRGB(33, 192, 174) forState:UIControlStateSelected];
        [filterBtn addTarget:self action:@selector(OnFilterBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_filterView addSubview:filterBtn];
        
        //三角
        UIButton *sanjiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sanjiaoBtn.frame = CGRectMake((i+1)*KScreenWidth/2-15, 16, 8, 7);
        sanjiaoBtn.tag = 120+i;
        [sanjiaoBtn setImage:[UIImage imageNamed:@"icon_arrow_dropdown_normal"] forState:UIControlStateNormal];
        [sanjiaoBtn setImage:[UIImage imageNamed:@"icon_arrow_dropdown_selected"] forState:UIControlStateSelected];
        [_filterView addSubview:sanjiaoBtn];
    }
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, KScreenWidth, 0.5)];
    lineView.backgroundColor = YXRGB(192, 192, 192);
    [_filterView addSubview:lineView];
 }

//遮罩页
-(void)initMaskView{
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, KScreenWidth, KScreenHeight-40-49)];
    _maskView.backgroundColor = YXRGBA(0, 0, 0, 0.5);
    [self.view addSubview:_maskView];
    _maskView.hidden = YES;
    
    //添加手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapMaskView:)];
//    tap.delegate = self;
//    [_maskView addGestureRecognizer:tap];
   
    self.dishfilterView = [DishFilterView filterView];
    self.dishfilterView.frame = CGRectMake(0, 0, KScreenWidth, _maskView.frame.size.height-90);
    [_maskView addSubview:self.dishfilterView];
    self.dishfilterView.delegate = self;
}

-(void)setupTableView{

    self.dishesVc=[[DishListsViewController alloc]init];
    [self addChildViewController:self.dishesVc];
    self.dishesVc.dishPararm = nil;
    [self.view addSubview:self.dishesVc.tableView];

    [self.dishesVc.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.dishesVc.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_filterView withOffset:0];

}
#pragma mark - DishFilterViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withId:(NSNumber *)ID withName:(NSString *)name isCuisine:(BOOL )isCuisine{
    
    
    if (isCuisine) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100];
        [btn setTitle:name forState:UIControlStateNormal];
        self.dishPararm.cuisineId = ID;
        
    } else {
        UIButton *btn = (UIButton *)[self.view viewWithTag:101];
        [btn setTitle:name forState:UIControlStateNormal];
        self.dishPararm.dishesType = ID;
    }
    self.dishesVc.dishPararm = self.dishPararm;
    _maskView.hidden = YES;

}
-(void)OnFilterBtn:(UIButton *)sender{
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        UIButton *sanjiaoBtn = (UIButton *)[self.view viewWithTag:120+i];
        btn.selected = NO;
        sanjiaoBtn.selected = NO;
    }
    sender.selected = YES;
    UIButton *sjBtn = (UIButton *)[self.view viewWithTag:sender.tag+20];
    sjBtn.selected = YES;
    if (sender.tag ==100) {
        
        self.dishfilterView.isCuisine = YES;
    } else {
        
        self.dishfilterView.isCuisine = NO;

    }
    _maskView.hidden = NO;
  }

-(void)OnTapMaskView:(UITapGestureRecognizer *)sender{
    _maskView.hidden = YES;
}

//点击搜索按钮
-(void)messageClick{
    
    [self textFieldSearch:self.searchView.textField];
}
- (void)textFieldSearch:(UITextField *)field {
    if (field.text == nil || field.text.length ==0) {
        [MBProgressHUD showError:@"请输入搜索的关键词"];
        return;
    }
        NSString *dishName = [NSString stringWithFormat:@"%@",[field.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        DishesSearchViewController *dishSearchVc = [[DishesSearchViewController alloc]init];
        dishSearchVc.dishName = dishName;
        [self.navigationController pushViewController:dishSearchVc animated:YES];
   }

@end
