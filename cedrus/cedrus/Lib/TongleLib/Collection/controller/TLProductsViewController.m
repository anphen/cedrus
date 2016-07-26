//
//  TLProductsViewController.m
//  TL11
//
//  Created by liu ruibin on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLProductsViewController.h"
#import "TLProduct.h"
#import "TLProductRequest.h"
#import "TLProductViewCell.h"
#import "TLProductAll.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "MJRefresh.h"
#import "Url.h"
#import "TLBaseTool.h"




@interface TLProductsViewController ()

@property (nonatomic,strong)    NSMutableArray  *productArray;
@property (nonatomic,strong)    TLProductAll    *productAll;
@property (nonatomic,copy)      NSString        *UpDown;

@end

@implementation TLProductsViewController

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
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self RefreshControl];
}

-(NSMutableArray *)productArray
{
    if (_productArray == nil) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
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
    self.UpDown= PAGEDOWN;
    [self loadProduct];
}

-(void)footerRefresh
{
    self.UpDown = PAGEUP;
    [self loadProduct];
}

-(void)loadProduct
{
    self.url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_products_Url];
    
    TLProductRequest *request = [[TLProductRequest alloc]init];
    if (self.productArray.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            request.prod_id= @"";
            request.fetch_count = DownAmount;
        }else
        {
            TLProduct *prod = self.productArray[self.productArray.count-1];
            request.prod_id = prod.prod_id;
            request.fetch_count = UpAmount;
        }
    }
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:self.url param:request success:^(id result) {
        weakSelf.productAll = result;
        if ([weakSelf.UpDown isEqualToString:PAGEDOWN]) {
            [weakSelf.productArray removeAllObjects];
            for (TLProduct *prod in self.productAll.prod_list) {
                [weakSelf.productArray addObject:prod];
            }
            [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
            for (TLProduct *prod in self.productAll.prod_list) {
                [weakSelf.productArray addObject:prod];
            }
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
    } resultClass:[TLProductAll class]];
}


- (void)didReceiveMemoryWarning
{
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
    [self.parentViewController performSegueWithIdentifier:TL_PROD_PURCHASE sender:product];
    
}

@end
