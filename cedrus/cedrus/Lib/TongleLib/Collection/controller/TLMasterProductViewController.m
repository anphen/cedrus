//
//  TLMasterProductViewController.m
//  tongle
//
//  Created by liu ruibin on 15-5-13.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMasterProductViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLProduct.h"
#import "TLProdBoby.h"
#import "TLProductViewCell.h"
#import "TLMasterViewController.h"
#import "TLProductRequest.h"
#import "MJRefresh.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "TLGroupPurchaseViewController.h"


@interface TLMasterProductViewController ()

@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSArray *arrayFrame;
@property (nonatomic,strong) NSMutableArray *productArray;
@property (nonatomic,copy) NSString *UpDown;

@end

@implementation TLMasterProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.user_id = [[NSUserDefaults standardUserDefaults] objectForKey:TL_MASTER];
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    self.tableView.rowHeight = 100;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self RefreshControl];
}
//懒加载
-(NSMutableArray *)productArray
{
    if (_productArray == nil) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}
/**
 *  配置刷新控件
 */
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
    [self setupProductData];
}

-(void)footerRefresh
{
     self.UpDown = PAGEUP;
    [self setupProductData];
}


-(void)setupProductData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,promote_products_Url];
    
    TLProductRequest *productRequest = [[TLProductRequest alloc]init];
    productRequest.user_id = self.user_id;
    if (self.productArray.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            productRequest.fetch_count = DownAmount;
            productRequest.prod_id = @"";
        }else
        {
            productRequest.fetch_count = UpAmount;
            TLProduct *prod = self.productArray[self.productArray.count-1];
            productRequest.prod_id = prod.prod_id;
        }
    }
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:productRequest success:^(id json) {
        TLProdBoby *result = [[TLProdBoby alloc]initWithDictionary:json[@"body"] error:nil];
        if ([weakSelf.UpDown isEqualToString:PAGEDOWN]) {
            [weakSelf.productArray removeAllObjects];
            for (TLProduct *prod in result.my_prod_list) {
                [weakSelf.productArray addObject:prod];
            }
            [weakSelf.tableView.mj_header endRefreshing];

        }else
        {
            [weakSelf.productArray addObjectsFromArray:result.my_prod_list];
             [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        if ([weakSelf.UpDown isEqualToString:PAGEDOWN])
        {
            [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil)
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        // Dispose of any resources that can be recreated.
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.productArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLProductViewCell *cell = [TLProductViewCell CellWithtable:tableView];
    cell.product = self.productArray[indexPath.row];
    return cell;
}


//选中跳转控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TLProduct *product = self.productArray[indexPath.row];
    if ([product.coupon_flag isEqualToString:TLYES]) {
        TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
        groupPurchaseView.product = product;
        groupPurchaseView.action = prod_otherBody;
        [self.navigationController pushViewController:groupPurchaseView animated:YES];
    }else
    {
        [self.parentViewController performSegueWithIdentifier:TL_MASTER_PRODUCT sender:product];
    }
}
@end
