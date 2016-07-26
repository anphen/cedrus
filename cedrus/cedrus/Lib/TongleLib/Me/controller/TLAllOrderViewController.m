//
//  TLAllOrderViewController.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLAllOrderViewController.h"
#import "TLOrderSingleViewCell.h"
#import "TLMyOrderFootViewCell.h"
#import "TLAllOrder.h"
#import "TLMyOrder.h"
#import "TLMyOrderList.h"
#import "TLEvaluationView.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "TLOrderDetailList.h"
#import "TLWeiXin.h"
#import <QuartzCore/QuartzCore.h>
#import "WXApi.h"
#import "TLAilpay.h"
#import <AlipaySDK/AlipaySDK.h>
#import <CommonCrypto/CommonDigest.h>
#import "TLMyOrdersRequset.h"
#import "MJRefresh.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "MBProgressHUD+MJ.h"
#import "TLHttpTool.h"
#import "TLPaymentListViewController.h"


@interface TLAllOrderViewController ()<TLMyOrderFootViewCellDetegate,UIAlertViewDelegate, WXApiDelegate>

@property (nonatomic,strong)    NSMutableArray  *orderArray;
@property (nonatomic,copy)      NSString        *UpDown;
@property (nonatomic,weak)      UILabel         *noOrder;

@end

@implementation TLAllOrderViewController

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

-(NSMutableArray *)orderArray
{
    if (_orderArray == nil) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}

/**
 *  加载用户订单数据
 */

-(void)loadOrderData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_orders_Url];
    TLMyOrdersRequset *myOrderRequest  = [[TLMyOrdersRequset alloc]init];
    myOrderRequest.order_status = TL_ALL_ORDER;
    if (self.orderArray.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            myOrderRequest.fetch_count = DownAmount;
            myOrderRequest.order_no = @"";
        }else
        {
            myOrderRequest.fetch_count = UpAmount;
            TLMyOrderList *myOrder = self.orderArray.lastObject;
            myOrderRequest.order_no = myOrder.order_no;
        }
    }
    [TLBaseTool postWithURL:url param:myOrderRequest success:^(id result) {
        self.myOrder = result;
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            [self.orderArray removeAllObjects];
            for (TLMyOrderList *myOrder in self.myOrder.order_list) {
                [self.orderArray addObject:myOrder];
            }
            [self.tableView.mj_header endRefreshing];
        }else
        {
            
            [self.orderArray addObjectsFromArray:self.myOrder.order_list];
             [self.tableView.mj_footer endRefreshing];
        }
        
        if (!self.orderArray.count) {
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
    }  resultClass:[TLMyOrder class]];
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
    return self.orderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    TLMyOrderList *orderList = self.orderArray[section];
    return orderList.prod_detail.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TLMyOrderList *orderList = self.orderArray[indexPath.section];
    if (indexPath.row < orderList.prod_detail.count) {
        TLOrderSingleViewCell *cell =[TLOrderSingleViewCell cellWithTableView:tableView];
        cell.myOrderProdDetail = orderList.prod_detail[indexPath.row];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else
    {
        TLMyOrderFootViewCell *cell = [TLMyOrderFootViewCell cellWithTableView:tableView];
        cell.myOrderList = self.orderArray[indexPath.section];
        cell.nameButton = [self buttonNameWithMyOrderList:self.orderArray[indexPath.section]];
        cell.detegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMyOrderList *orderList = self.orderArray[indexPath.section];
    if (indexPath.row < orderList.prod_detail.count) {
        return 86;
    }else
    {
        return 90;
    }
}

-(NSString *)buttonNameWithMyOrderList:(TLMyOrderList *)myorderlist
{
    if ([myorderlist.status isEqualToString:TL_OBLIGATION]) {
        return @"立即支付";
    }else if ([myorderlist.status isEqualToString:TL_DELIVERY])
    {
        return @"确认收货";
    }else if ([myorderlist.status isEqualToString:TL_NO_EVALUATED])
    {
        return @"评价订单";
    }else
    {
        return @"订单详情";
    }
}

-(void)myOrderFootViewCellDetegate:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrder_no:(NSString *)order_no withOrderList:(TLMyOrderList *)myOrderList
{
    TLOrderDetailList *orderDetail = [[TLOrderDetailList alloc]init];
    orderDetail.order_no = order_no;
    orderDetail.orderList = myOrderList;
    [self.parentViewController performSegueWithIdentifier:TL_MYORDER_DETAIL sender:orderDetail];
}

-(void)myOrderFootViewCellEvaluation:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrderList:(TLMyOrderList *)myOrderList
{
    [self.parentViewController performSegueWithIdentifier:TL_MYORDER_EVALUTION sender:myOrderList];
    
}

-(void)myOrderFootViewCellReceiveProd:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrderList:(TLMyOrderList *)myOrderList
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,confirm_Url];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,myOrderList.order_no,@"order_no", nil];
    [TLHttpTool postWithURL:url params:param success:^(id json) {
        [MBProgressHUD showSuccess:@"确认收货成功"];
         [self RefreshControl];
    } failure:nil];
    
}
-(void)myOrderFootViewCellPayment:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrderList:(TLMyOrderList *)myOrderList withOrder_no:(NSString *)order_no
{
    TLPaymentListViewController *paymentListView = [[TLPaymentListViewController alloc]init];
    paymentListView.order_no = order_no;
    paymentListView.prodType = @"1";
    paymentListView.actionType = @"payOrderList";
    [self.navigationController pushViewController:paymentListView animated:YES];
}


@end
