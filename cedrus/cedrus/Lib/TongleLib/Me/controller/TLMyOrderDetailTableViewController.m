//
//  TLMyOrderDetailTableViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMyOrderDetailTableViewController.h"
#import "TLMyOrderDetailHeadTableViewCell.h"
#import "TLIntegrateDetailController.h"
#import "TLOrderSingleViewCell.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLMyOrderDetail.h"
#import "TLMyOrderDetailFootTableViewCell.h"
#import "TLMyOrderDetailList.h"
#import "TLProdPurchaseViewController.h"
#import "TLMyOrderList.h"
#import "TLMyOrderProdEvaViewController.h"
#import "TLPayResultRequest.h"
#import "TLImageName.h"
#import "MJRefresh.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "TLCommon.h"
#import "MBProgressHUD+MJ.h"
#import "WXApi.h"
#import "TLAilpay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "TLWeiXin.h"
#import "UIButton+TL.h"
#import "TLPaymentListViewController.h"

@interface TLMyOrderDetailTableViewController ()<TLMyOrderDetailHeadTableViewCellDetegate,UIAlertViewDelegate,TLMyOrderDetailFootTableViewCellDelegate>

@property (nonatomic,strong) TLMyOrderDetail *myOrderDetail;
@property (nonatomic,weak)   UIButton *rightButton;


@end

@implementation TLMyOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
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

-(void)back
{
    if ([_actionType isEqualToString:@"pay"]) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count]-3)] animated:YES];
    }else  if ([_actionType isEqualToString:@"payOrderList"])
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count]-2)] animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header endRefreshing];
    
    [self RefreshControl];
}

-(void)RefreshControl
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerRefresh];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];

}

-(void)headerRefresh
{
    [self loadData];
}

-(void)loadData
{
    if (self.order_no.length == 0) {
         NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,orders_show_Url];
        TLPayResultRequest *payResult = [[TLPayResultRequest alloc]init];
        [TLBaseTool postWithURL:url param:payResult success:^(id result) {
            self.myOrderDetail = result;
            [self setRightButton];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        } resultClass:[TLMyOrderDetail class]];
    }else
    {
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,orders_show_Url];
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.order_no,@"order_no", nil];
        //发送请求
        [TLHttpTool postWithURL:url params:params success:^(id json) {
            TLMyOrderDetail *result = [[TLMyOrderDetail alloc]initWithDictionary:json[@"body"] error:nil];
            self.myOrderDetail = result;
            [self setRightButton];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSError *error) {
             [self.tableView.mj_header endRefreshing];
        }];
    }
    
}



-(void)setRightButton
{
    if ([self.myOrderDetail.order_info.head_info.status isEqualToString:TL_NO_EVALUATED] || [self.myOrderDetail.order_info.head_info.status isEqualToString:TL_EVALUATED]) {
        
        UIButton *rightButton = [[UIButton alloc]init];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [rightButton setTitle:@"返修／退换货" forState:UIControlStateNormal];
        [rightButton setTitle:@"返修／退换货" forState:UIControlStateHighlighted];
        rightButton.frame = CGRectMake(0, 0, 85, 25);
        [rightButton addTarget:self action:@selector(backProduct) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];

        _rightButton = rightButton;
        
    }
}

-(void)backProduct
{
    [_rightButton ButtonDelay];
    TLIntegrateDetailController *integrateDetailController = [[TLIntegrateDetailController alloc]init];
    integrateDetailController.myOrderDetail  = self.myOrderDetail;
    [self.navigationController pushViewController:integrateDetailController animated:YES];
}

-(void)setOrder_no:(NSString *)order_no
{
    _order_no = order_no;
}

-(void)setActionType:(NSString *)actionType
{
    _actionType = actionType;
}


- (void)didReceiveMemoryWarning {
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
    return self.myOrderDetail.order_info.order_detail.count+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TLMyOrderDetailHeadTableViewCell *cell = [TLMyOrderDetailHeadTableViewCell cellWithTableView:tableView];
        cell.myOrderDetail = self.myOrderDetail;
        cell.detegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.height = cell.height;
        return cell;
    }else if ((indexPath.row>0) && (indexPath.row <= self.myOrderDetail.order_info.order_detail.count))
    {
        TLOrderSingleViewCell *cell = [TLOrderSingleViewCell cellWithTableView:tableView];
        cell.myOrderDetailList = self.myOrderDetail.order_info.order_detail[indexPath.row-1];
        return cell;
    }else
    {
        TLMyOrderDetailFootTableViewCell *cell = [TLMyOrderDetailFootTableViewCell cellWithTableView:tableView];
        cell.myOrderDetail = self.myOrderDetail;
        cell.delegate = self;
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    //return 0;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row>0) && (indexPath.row <= self.myOrderDetail.order_info.order_detail.count))
    {
        TLMyOrderDetailList *myOrderDetailList = self.myOrderDetail.order_info.order_detail[indexPath.row-1];
        [self performSegueWithIdentifier:TL_ORDER_FETAIL_TO_PROD_DETAIL sender:myOrderDetailList];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLProdPurchaseViewController class]]) {
        TLProdPurchaseViewController *ProdPurchase = vc;
        ProdPurchase.myorderproduct = sender;
    }else if ([vc isKindOfClass:[TLMyOrderProdEvaViewController class]])
    {
        TLMyOrderProdEvaViewController *MyOrderProdEvaView = vc;
        MyOrderProdEvaView.order_no =  _myOrderDetail.order_info.head_info.order_no;

        NSMutableArray *temp = [NSMutableArray array];
        for (TLMyOrderDetailList *myOrderDetailList in _myOrderDetail.order_info.order_detail) {
            TLMyOrderProdDetail *myOrderProdDetail = [[TLMyOrderProdDetail alloc]init];
            myOrderProdDetail.order_detail_no = myOrderDetailList.order_detail_no;
            myOrderProdDetail.prod_pic_url = myOrderDetailList.prod_pic_url;
            myOrderProdDetail.prod_name = myOrderDetailList.prod_name;
            [temp addObject:myOrderProdDetail];
        }
        MyOrderProdEvaView.myorderListArray = temp;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return self.height;
    }else if ((indexPath.row>0) && (indexPath.row <= self.myOrderDetail.order_info.order_detail.count))
    {
        return 80;
    }else
    {
        return 150;
    }

}

-(void)TLMyOrderDetailHeadTableViewCell:(TLMyOrderDetailHeadTableViewCell *)myOrderDetailHeadTableViewCell withBtn:(UIButton *)btn
{
    if ([[btn titleForState:UIControlStateNormal] isEqualToString:@"立即支付"]) {
        [self payProduct];
    }else if([[btn titleForState:UIControlStateNormal] isEqualToString:@"删除订单"]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"删除订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }else if ([[btn titleForState:UIControlStateNormal] isEqualToString:@"确认收货"])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确认收货" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }else if ([[btn titleForState:UIControlStateNormal] isEqualToString:@"评价订单"])
    {
        [self performSegueWithIdentifier:TL_ORDER_DETAIL_EVA sender:nil];
    }
}

-(void)payProduct
{
    TLPaymentListViewController *paymentListView = [[TLPaymentListViewController alloc]init];
    paymentListView.order_no = self.order_no;
    paymentListView.prodType = @"1";
    paymentListView.actionType = @"detail";
    [self.navigationController pushViewController:paymentListView animated:YES];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if ([alertView.title isEqualToString:@"删除订单"] || [alertView.title isEqualToString:@"取消订单"]) {
            NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,orders_remove_Url];
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.order_no,@"order_no", nil];
            //发送请求
            [TLHttpTool postWithURL:url params:params success:^(id json) {
                [MBProgressHUD showSuccess:@"删除订单成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } failure:nil];
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,confirm_Url];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.order_no,@"order_no", nil];
            [TLHttpTool postWithURL:url params:param success:^(id json) {
                [MBProgressHUD showSuccess:@"确认收货成功"];
                [self RefreshControl];
            } failure:nil];
        }
    }
}

-(void)MyOrderDetailFootTableViewCell:(TLMyOrderDetailFootTableViewCell *)myOrderDetailFoot
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"取消订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
-(void)MyOrderDetailFootTableViewCellAgainSub:(TLMyOrderDetailFootTableViewCell *)myOrderDetailFoot
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,re_customers_Url];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.order_no,@"order_no", nil];
    [TLHttpTool postWithURL:url params:param success:^(id json) {
        [MBProgressHUD showSuccess:@"提交成功"];
        [self RefreshControl];
    } failure:nil];

}


@end
