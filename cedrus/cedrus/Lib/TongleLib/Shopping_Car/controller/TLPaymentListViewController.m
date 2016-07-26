//
//  TLPaymentListViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/14.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLPaymentListViewController.h"
#import "TLPaymentTableViewCell.h"
#import "TLImageName.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "TLBasicData.h"
#import "TLBaseDateType.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLHttpTool.h"
#import "Url.h"
#import <AlipaySDK/AlipaySDK.h>
#import "TLWeiXin.h"
#import "WXApi.h"
#import "TLGroupOrderDetailViewController.h"
#import "TLMyOrderDetailTableViewController.h"
#import "MBProgressHUD+MJ.h"

@interface TLPaymentListViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong)    TLBasicData    *baseDate;
@property (nonatomic,strong)    TLBaseDateType *payType;
@property (nonatomic,copy)  NSString *pay_method;

@end

@implementation TLPaymentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    [self initNavigationBar];
    self.tableView.scrollEnabled = NO;
    TLBasicData *baseData = [[TLBasicData alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:TLBaseDataFilePath]error:nil];
    self.baseDate = baseData;
    TLBaseDateType *payBaseDataType = baseData.base_data_list[[_prodType intValue]];
    self.payType = payBaseDataType;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    self.navigationItem.title = @"选择支付方式";
}
/**
 *  重写返回按钮
 */
-(void)back
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定取消支付?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResult) name:@"payResult" object:nil];
}

-(void)payResult
{
    if ([_actionType isEqualToString:@"detail"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        if ([_prodType intValue] == 8) {
            TLGroupOrderDetailViewController *groupOrderDetailView = [[TLGroupOrderDetailViewController alloc]init];
            groupOrderDetailView.order_no = _order_no;
            groupOrderDetailView.actionType = _actionType;
            [self.navigationController pushViewController:groupOrderDetailView animated:YES];
        }else
        {
            TLMyOrderDetailTableViewController *myOrderDetailTableView = [[UIStoryboard storyboardWithName:STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:@"myOrderDetailTableViewController"];
            myOrderDetailTableView.order_no = _order_no;
            myOrderDetailTableView.actionType = _actionType;
            [self.navigationController pushViewController:myOrderDetailTableView animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setOrder_no:(NSString *)order_no
{
    _order_no = order_no;
}

-(void)setProdType:(NSString *)prodType
{
    _prodType = prodType;
}

-(void)setActionType:(NSString *)actionType
{
    _actionType = actionType;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.payType.data_list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLPaymentTableViewCell *cell = [TLPaymentTableViewCell cellWithTableView:tableView];
    cell.data = self.payType.data_list[indexPath.row];
    if (indexPath.row == 0) {
        cell.selectPay.selected = YES;
        _pay_method = cell.data.code;
    }
    cell.tag = 1000+indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cancelSelected];
    TLPaymentTableViewCell *cell = (TLPaymentTableViewCell *)[self.view viewWithTag:(1000+indexPath.row)];
    cell.selectPay.selected = YES;
    _pay_method = cell.data.code;
}


-(void)cancelSelected
{
    for (int i = 0; i<self.payType.data_list.count; i++) {
        TLPaymentTableViewCell *cell = (TLPaymentTableViewCell *)[self.view viewWithTag:(1000+i)];
        cell.selectPay.selected = NO;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 0)];
    footerView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    UIButton *submit = [[UIButton alloc]init];
    [submit setTitle:@"去支付" forState:UIControlStateNormal];
    
    [submit setBackgroundImage:[UIImage imageNamed:TL_BTN_TIJIAODINGDAN_NOR] forState:UIControlStateNormal];
    [submit setBackgroundImage:[UIImage imageNamed:TL_BTN_TIJIAODINGDAN_DIS] forState:UIControlStateDisabled];
    [submit setBackgroundImage:[UIImage imageNamed:TL_BTN_TIJIAODINGDAN_DOWN] forState:UIControlStateHighlighted];
    [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    submit.frame = CGRectMake(10, 20, ScreenBounds.size.width-20, 40);
    [footerView addSubview:submit];
    return footerView;
}

-(void)submit:(UIButton *)button
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,_order_no,@"order_no",_pay_method,@"pay_method", nil];
    if ([_pay_method isEqualToString:Alipay_Client]) {
        //支付宝支付
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,alipay_parameter_Url];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            NSDictionary *body = json[@"body"];
            //            TLAilpay *ailpay = [[TLAilpay alloc]initWithDictionary:body[@"alipay_info"] error:nil];
            //            NSString *orderSpec = [ailpay description];
            NSString *ailpay_info = body[@"alipay_info"];
            __weak typeof(self) weakSelf = self;
            [[AlipaySDK defaultService] payOrder:ailpay_info fromScheme:TL_APPSCHEME callback:^(NSDictionary *resultDic) {
                if ([resultDic[@"resultStatus"] intValue] == 9000) {
                    [MBProgressHUD showSuccess:@"支付成功"];
                    [weakSelf payResult];
                }else
                {
                    [MBProgressHUD showError:@"支付失败"];
                }
            }];
        } failure:nil];
        
    }else if ([_pay_method isEqualToString:Online_Bank])
    {//微信支付
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,weixin_pay_parameter_Url];
        
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            NSDictionary *body = json[@"body"];
            TLWeiXin *weiDict = [[TLWeiXin alloc]initWithDictionary:body[@"wexin_pay_info"] error:nil];
            PayReq *req         = [[PayReq alloc] init];
            req.openID          = weiDict.app_id;
            req.partnerId       = weiDict.partner_id;
            req.prepayId        = weiDict.prepay_id;
            req.nonceStr        = weiDict.nonce_str;
            req.timeStamp       = weiDict.timestamp.intValue;
            req.package         = weiDict.package;
            req.sign            = weiDict.sign;
            
            [WXApi sendReq:req];
        } failure:nil];
    }
}


/*
 // Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
