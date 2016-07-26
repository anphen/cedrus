//
//  TLGroupOrderRefundViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/21.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupOrderRefundViewController.h"
#import "TLGroupOrderList.h"
#import "TLGroupOrderListViewCell.h"
#import "TLGroupOrderDetailViewController.h"
#import "TLGroupOrdersListRequest.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "MJRefresh.h"


@interface TLGroupOrderRefundViewController ()

@property (nonatomic,copy) NSString *upDown;
@property (nonatomic,strong) NSMutableArray *groupOrderArray;

@end

@implementation TLGroupOrderRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 82;

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
    self.upDown = PAGEDOWN;
    [self loadData];
}

-(void)footerRefresh
{
    self.upDown = PAGEUP;
    [self loadData];
}

-(NSMutableArray *)groupOrderArray
{
    if (_groupOrderArray == nil) {
        _groupOrderArray = [NSMutableArray array];
    }
    return _groupOrderArray;
}


-(void)loadData
{
    TLGroupOrdersListRequest *groupOrdersListRequest = [[TLGroupOrdersListRequest alloc]init];
    groupOrdersListRequest.order_status = @"1";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,groupOrdersListRequest.user_token,orders_gp_orders_Url];
    
    if (self.groupOrderArray.count)
    {
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            groupOrdersListRequest.order_no = @"";
            groupOrdersListRequest.fetch_count = DownAmount;
        }else
        {
            TLGroupOrder *groupOrder = self.groupOrderArray.lastObject;
            groupOrdersListRequest.order_no = groupOrder.order_no;
            groupOrdersListRequest.fetch_count = UpAmount;
        }
    }
    __weak typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:groupOrdersListRequest success:^(id result) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            TLGroupOrderList *groupOrderList = result;
            
            if ([weakSelf.upDown isEqualToString:PAGEDOWN]) {
                [weakSelf.groupOrderArray removeAllObjects];
                for (TLGroupOrder *groupOrder in groupOrderList.order_list) {
                    [weakSelf.groupOrderArray addObject:groupOrder];
                }
                [weakSelf.tableView.mj_header endRefreshing];
            }else
            {
                for (TLGroupOrder *groupOrder in groupOrderList.order_list) {
                    [weakSelf.groupOrderArray addObject:groupOrder];
                }
                [weakSelf.tableView.mj_footer endRefreshing];
            }
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSError *error)
     {
         if ([weakSelf.upDown isEqualToString:PAGEDOWN])
         {
             [weakSelf.tableView.mj_header endRefreshing];
         }else
         {
             [weakSelf.tableView.mj_footer endRefreshing];
         }
     } resultClass:[TLGroupOrderList class]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupOrderArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLGroupOrderListViewCell *cell = [TLGroupOrderListViewCell cellWithTableview:tableView];
    cell.type  = @"1";
    cell.groupOrder = self.groupOrderArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLGroupOrderDetailViewController *groupOrderDetailView = [[TLGroupOrderDetailViewController alloc]init];
    TLGroupOrder *groupOrder = self.groupOrderArray[indexPath.row];
    groupOrderDetailView.order_no = groupOrder.order_no;
    [self.parentViewController.navigationController pushViewController:groupOrderDetailView animated:YES];
}

@end
