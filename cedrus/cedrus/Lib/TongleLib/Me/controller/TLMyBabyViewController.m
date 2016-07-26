//
//  TLMyBabyViewController.m
//  TL11
//
//  Created by liu on 15-4-13.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMyBabyViewController.h"
#import "TLProduct.h"
#import "TLProductRequest.h"
#import "TLProductViewCell.h"
#import "TLProdBoby.h"
#import "TLProdPurchaseViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLImageName.h"
#import "MJRefresh.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "MBProgressHUD+MJ.h"
#import "TLGroupPurchaseViewController.h"

@interface TLMyBabyViewController ()<UITableViewDelegate>

@property (nonatomic,strong)    NSMutableArray  *productArray;
@property (nonatomic,strong)    TLProdBoby      *prodBoby;
@property (nonatomic,strong)    TLProductRequest *productRequest;
@property (nonatomic,copy)      NSString        *UpDown;


@end

@implementation TLMyBabyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    [self initNavigationBar];
}

-(NSMutableArray *)productArray
{
    if (_productArray == nil) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}


//自定义导航栏
- (void)initNavigationBar
{
    
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
/**
 *  重写返回按钮
 */
-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self RefreshControl];
}


-(void)RefreshControl
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footerRefresh];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

-(void)headerRefresh
{
    self.UpDown = PAGEDOWN;
    [self loadProduct];
}
-(void)footerRefresh
{
    self.UpDown = PAGEUP;
    [self loadProduct];
}

-(void)loadProduct
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,promote_products_Url];
    
    TLProductRequest *request = [[TLProductRequest alloc]init];
    if (self.productArray.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            request.fetch_count = DownAmount;
            request.prod_id = @"";
        }else
        {
            request.fetch_count = UpAmount;
            TLProduct *product = self.productArray.lastObject;
            request.prod_id = product.prod_id;
        }
    }
    self.productRequest = request;
    [TLBaseTool postWithURL:url param:request success:^(id result) {
        self.prodBoby = result;
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            [self.productArray removeAllObjects];
            for (TLProduct *product in self.prodBoby.my_prod_list) {
                [self.productArray addObject:product];
            }
             [self.tableView.mj_header endRefreshing];
        }else
        {
            [self.productArray addObjectsFromArray:self.prodBoby.my_prod_list];
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if ([self.UpDown isEqualToString:PAGEDOWN])
        {
            [self.tableView.mj_header endRefreshing];
        }else
        {
          [self.tableView.mj_footer endRefreshing];
        }
    } resultClass:[TLProdBoby class]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return self.productArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLProductViewCell *cell = [TLProductViewCell CellWithtable:tableView];
    cell.product = self.productArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLProduct *product = self.productArray[indexPath.row];
    if ([product.coupon_flag isEqualToString:TLYES]) {
        TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
        groupPurchaseView.product = product;
        groupPurchaseView.action = prod_meBoby;
        [self.navigationController pushViewController:groupPurchaseView animated:YES];
    }else
    {
        [self performSegueWithIdentifier:TL_MYBABY_TO_PROD sender:product];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLProdPurchaseViewController class]]) {
        TLProdPurchaseViewController *ProdPurchase = vc;
        ProdPurchase.mybabyproduct = sender;
    }
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle  == UITableViewCellEditingStyleDelete) {
        TLProduct *product = self.productArray[indexPath.row];
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,remove_Url];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.productRequest.user_id,@"user_id",self.productRequest.TL_USER_TOKEN_REQUEST,TL_USER_TOKEN,product.prod_id,@"key_value",TL_COLLECT_TYPE_BABY,@"collection_type", nil];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
                [MBProgressHUD showSuccess:@"宝贝删除成功"];
                [self.productArray removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
        } failure:nil];
    }
}


@end
