//
//  TLMagicShopViewController.m
//
//  Created by liu ruibin on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMagicShopViewController.h"
#import "TLMagicShop.h"
#import "TLMagicShopViewCell.h"
#import "TLBaseTool.h"
#import "MJExtension.h"
#import "TLMagicRequest.h"
#import "TLMagicShopAll.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "MJRefresh.h"
#import "TLCommon.h"
#import "Url.h"


@interface TLMagicShopViewController ()
@property (nonatomic,strong) NSMutableArray *magicShop;
@property (nonatomic,strong) TLMagicShopAll *magicShopAll;
@property (nonatomic,copy) NSString *upDown;

@end

@implementation TLMagicShopViewController

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
    self.tableView.rowHeight = 68;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
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
    self.upDown = PAGEDOWN;
   [self loadStatuses];
}

-(void)footerRefresh
{
     self.upDown = PAGEUP;
    [self loadStatuses];
}


-(NSMutableArray *)magicShop
{
    if (_magicShop == nil) {
        _magicShop = [NSMutableArray array];
    }
    return _magicShop;
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
        self.view = nil;
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
    
    return self.magicShop.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMagicShopViewCell *cell = [TLMagicShopViewCell cellWithTableView:tableView];
    cell.magicShop = self.magicShop[indexPath.row];
    
    return cell;
}

//加载数据
-(void)loadStatuses
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_mstores_Url];
    
    TLMagicRequest *request = [[TLMagicRequest alloc]init];
    if (self.magicShop.count)
    {
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            request.mstore_id = @"";
            request.fetch_count = DownAmount;
        }else
        {
            TLMagicShop *magicShop = self.magicShop[self.magicShop.count-1];
            request.mstore_id = magicShop.mstore_id;
            request.fetch_count = UpAmount;
        }
    }
    
     __unsafe_unretained __typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:request success:^(id result) {
        weakSelf.magicShopAll = result;
        if ([weakSelf.upDown isEqualToString:PAGEDOWN]) {
            [weakSelf.magicShop removeAllObjects];
            for (TLMagicShop *shop in weakSelf.magicShopAll.mstore_list) {
                [weakSelf.magicShop addObject:shop];
            }
           [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
            for (TLMagicShop *shop in weakSelf.magicShopAll.mstore_list) {
                [weakSelf.magicShop addObject:shop];
            }
             [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        if ([weakSelf.upDown isEqualToString:PAGEDOWN])
        {
            [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } resultClass:[TLMagicShopAll class]];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.parentViewController performSegueWithIdentifier:TL_COLLLECT_MOSHOP sender:self.magicShop[indexPath.row]];
    
}

@end
