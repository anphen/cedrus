//
//  TLCompletedOrderViewController.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLReceiveProdOrderViewController.h"
#import "TLOrderSingleViewCell.h"
#import "TLMyOrderFootViewCell.h"
#import "TLMyOrderList.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLOrderDetailList.h"
#import "TLMyOrdersRequset.h"
#import "TLMyOrder.h"
#import "MJRefresh.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "TLHttpTool.h"
#import "MBProgressHUD+MJ.h"

@interface TLReceiveProdOrderViewController ()<TLMyOrderFootViewCellDetegate>
@property (nonatomic,strong)    NSMutableArray  *ordergroup;
@property (nonatomic,copy)      NSString        *UpDown;
@property (nonatomic,weak)      UILabel         *noOrder;
@end

@implementation TLReceiveProdOrderViewController

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
    self.tableView.rowHeight = 90;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    UILabel *noOrder = [[UILabel alloc]init];
    noOrder.font = [UIFont systemFontOfSize:14];
    noOrder.text = @"无相关订单";
    noOrder.bounds = (CGRect){{0,0},[noOrder.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}]};
    noOrder.center = CGPointMake(ScreenBounds.size.width/2, 100);
    [self.tableView addSubview:noOrder];
    self.noOrder = noOrder;
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
    self.UpDown = PAGEDOWN;
    [self loadOrderData];
}
-(void)footerRefresh
{
    self.UpDown = PAGEUP;
    [self loadOrderData];
}

-(NSMutableArray *)noReceive
{
    if (_noReceive == nil) {
        _noReceive = [NSMutableArray array];
    }
    return _noReceive;
}

-(void)loadOrderData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_orders_Url];
    TLMyOrdersRequset *myOrderRequest  = [[TLMyOrdersRequset alloc]init];
    myOrderRequest.order_status = TL_WAIT_RECEIVE;
    if (self.noReceive.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            myOrderRequest.fetch_count = DownAmount;
            myOrderRequest.order_no = @"";
        }else
        {
            myOrderRequest.fetch_count = UpAmount;
            TLMyOrderList *myOrder = self.noReceive.lastObject;
            myOrderRequest.order_no = myOrder.order_no;
        }
    }
    [TLBaseTool postWithURL:url param:myOrderRequest success:^(id result) {
        TLMyOrder *myOrder = result;
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            [self.noReceive removeAllObjects];
            for (TLMyOrderList *myOrderlist in myOrder.order_list) {
                [self.noReceive addObject:myOrderlist];
            }
            [self.tableView.mj_header endRefreshing];
        }else
        {
            [self.noReceive addObjectsFromArray:myOrder.order_list];
             [self.tableView.mj_footer endRefreshing];
        }
        if (!self.noReceive.count) {
            self.noOrder.hidden = NO;
        }else
        {
            self.noOrder.hidden = YES;
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
    } resultClass:[TLMyOrder class]];
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
    return self.noReceive.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    TLMyOrderList *myOrderList = self.noReceive[section];
    return myOrderList.prod_detail.count +1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    TLMyOrderList *orderList = self.noReceive[indexPath.section];
    if (indexPath.row < orderList.prod_detail.count) {
        TLOrderSingleViewCell *cell =[TLOrderSingleViewCell cellWithTableView:tableView];
        cell.myOrderProdDetail = orderList.prod_detail[indexPath.row];
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else
    {
        TLMyOrderFootViewCell *cell = [TLMyOrderFootViewCell cellWithTableView:tableView];
        cell.myOrderList = self.noReceive[indexPath.section];
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.nameButton = @"确认收货";
        cell.detegate = self;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMyOrderList *orderList = self.noReceive[indexPath.section];
    if (indexPath.row < orderList.prod_detail.count) {
        return 86;
    }else
    {
        return 90;
    }
}


-(void)myOrderFootViewCellDetegate:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrder_no:(NSString *)order_no withOrderList:(TLMyOrderList *)myOrderList
{
    TLOrderDetailList *orderDetail = [[TLOrderDetailList alloc]init];
    orderDetail.order_no = order_no;
    orderDetail.orderList = myOrderList;
    
    [self.parentViewController performSegueWithIdentifier:TL_MYORDER_DETAIL sender:orderDetail];
}

-(void)myOrderFootViewCellReceiveProd:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrderList:(TLMyOrderList *)myOrderList
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,confirm_Url];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,myOrderList.order_no,@"order_no", nil];
    [TLHttpTool postWithURL:url params:param success:^(id json) {
        [MBProgressHUD showSuccess:@"确认收货成功,修改完善"];
        [self RefreshControl];
    } failure:nil];
    
}



@end
