//
//  TLWaitForEvaluationViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLWaitForEvaluationViewController.h"
#import "TLOrderSingleViewCell.h"
#import "TLMyOrderFootViewCell.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLMyOrderList.h"
#import "TLMyOrdersRequset.h"
#import "TLMyOrder.h"
#import "TLOrderDetailList.h"
#import "MJRefresh.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLBaseTool.h"

@interface TLWaitForEvaluationViewController ()<TLMyOrderFootViewCellDetegate>


@property (nonatomic,copy)      NSString        *UpDown;
@property (nonatomic,weak)      UILabel         *noOrder;

@end

@implementation TLWaitForEvaluationViewController

- (void)viewDidLoad {
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

-(NSMutableArray *)noEvaluation
{
    if (_noEvaluation == nil) {
        _noEvaluation = [NSMutableArray array];
    }
    return _noEvaluation;
}

-(void)loadOrderData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_orders_Url];
    TLMyOrdersRequset *myOrderRequest  = [[TLMyOrdersRequset alloc]init];
    myOrderRequest.order_status = TL_EVALUATED_1;
    if (self.noEvaluation.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            myOrderRequest.fetch_count = DownAmount;
            myOrderRequest.order_no = @"";
        }else
        {
            myOrderRequest.fetch_count = UpAmount;
            TLMyOrderList *myOrder = self.noEvaluation.lastObject;
            myOrderRequest.order_no = myOrder.order_no;
        }
    }
    [TLBaseTool postWithURL:url param:myOrderRequest success:^(id result) {
        TLMyOrder *myOrder = result;
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            [self.noEvaluation removeAllObjects];
            for (TLMyOrderList *myOrderlist in myOrder.order_list) {
                [self.noEvaluation addObject:myOrderlist];
            }
            [self.tableView.mj_header endRefreshing];
        }else
        {
            [self.noEvaluation addObjectsFromArray:myOrder.order_list];
             [self.tableView.mj_footer endRefreshing];
        }
        if (!self.noEvaluation.count) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

   
    return self.noEvaluation.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    TLMyOrderList *myOrderList = self.noEvaluation[section];
    return myOrderList.prod_detail.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMyOrderList *orderList = self.noEvaluation[indexPath.section];
    if (indexPath.row < orderList.prod_detail.count) {
        TLOrderSingleViewCell *cell =[TLOrderSingleViewCell cellWithTableView:tableView];
        cell.myOrderProdDetail = orderList.prod_detail[indexPath.row];
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else
    {
        TLMyOrderFootViewCell *cell = [TLMyOrderFootViewCell cellWithTableView:tableView];
        cell.myOrderList = self.noEvaluation[indexPath.section];
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.nameButton =  @"评价订单";
        cell.detegate = self;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     TLMyOrderList *orderList = self.noEvaluation[indexPath.section];
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


-(void)myOrderFootViewCellEvaluation:(TLMyOrderFootViewCell *)myOrderFootViewCell withOrderList:(TLMyOrderList *)myOrderList
{
    [self.parentViewController performSegueWithIdentifier:TL_MYORDER_EVALUTION sender:myOrderList];
    
}


@end
