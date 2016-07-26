//
//  TLIntegrateDetailController.m
//  tongle
//
//  Created by jixiaofei-mac on 15/11/10.
//  Copyright © 2015年 com.isoftstone. All rights reserved.
//

#import "TLIntegrateDetailController.h"
#import "TLProdDetails.h"
#import "TLImageName.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLMyPoint.h"
#import "TLMyOrderDetail.h"
#import "TLUser_account_info.h"
#import "TLMyAccount_list.h"
#import "TLMoshop.h"
#import "TLHomepage_ads.h"
#import "TLGroupOrderProdBaseInfo.h"
#import "TLHttpTool.h"

@interface TLIntegrateDetailController ()

@property (nonatomic,weak) UIWebView *webView;
@property (nonatomic,strong) NSURLRequest *request;

@end

@implementation TLIntegrateDetailController


-(instancetype)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];

    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    [webView loadRequest:_request];
    self.webView = webView;
    // Do any additional setup after loading the view.
}

-(void)setProdDetails:(TLProdDetails *)prodDetails
{
    _prodDetails = prodDetails;
    self.navigationItem.title =prodDetails.point_rule_title;
    
    NSString *footString = [NSString stringWithFormat:@"mstore_id=%@&product_id=%@",prodDetails.mstore_id,prodDetails.prod_id];
    _request = [TLHttpTool h5LoadWithUrl:prodDetails.point_rule_url footString:footString];

}

-(void)setUser_account_info:(TLUser_account_info *)user_account_info
{
    _user_account_info = user_account_info;
    
    self.navigationItem.title =user_account_info.withdraw_title;
    
    TLMyAccount_list *amount_temp = [[TLMyAccount_list alloc]init];
    for (TLMyAccount_list *account in user_account_info.account_list) {
        if ([account.account_type_id isEqualToString:@"09"]) {
            amount_temp = account;
        }
    }
    NSString *footString = [NSString stringWithFormat:@"amount_valid=%@",amount_temp.account_qty];
    _request = [TLHttpTool h5LoadWithUrl:user_account_info.withdraw_url footString:footString];
}
-(void)setMyAccount:(TLMyAccount_list *)MyAccount
{
    _MyAccount = MyAccount;
    
    self.navigationItem.title =MyAccount.account_detail_title;

    NSString *footString = [NSString stringWithFormat:@"account_id=%@&account_name=%@",MyAccount.account_type_id,MyAccount.account_type_name];
    _request = [TLHttpTool h5LoadWithUrl:MyAccount.account_detail_url footString:footString];
}


-(void)setMyOrderDetail:(TLMyOrderDetail *)myOrderDetail
{
    _myOrderDetail = myOrderDetail;
    self.navigationItem.title =myOrderDetail.order_info.goods_return_title;
    
    NSString *footString = [NSString stringWithFormat:@"order_no=%@",myOrderDetail.order_info.head_info.order_no];
    _request = [TLHttpTool h5LoadWithUrl:myOrderDetail.order_info.goods_return_url footString:footString];

}

-(void)setMoshop:(TLMoshop *)moshop
{
    _moshop = moshop;
    self.navigationItem.title = moshop.vouchers_title;

    _request = [TLHttpTool h5LoadWithUrl:moshop.vouchers_url footString:nil];
}


-(void)setHomepage_ads:(TLHomepage_ads *)homepage_ads
{
    _homepage_ads = homepage_ads;
    
    self.navigationItem.title = homepage_ads.promotion_title;

    _request = [TLHttpTool h5LoadWithUrl:homepage_ads.object_id footString:nil];
}


//-(void)setTitle:(NSString *)Title
//{
//    _Title = Title;
//    self.navigationItem.title = Title;
//}
//
//
//-(void)setUrl:(NSString *)url
//{
//    _url = url;
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?user_id=%@&user_token=%@prod_id=%@",url,[TLPersonalMegTool currentPersonalMeg].user_id,[TLPersonalMegTool currentPersonalMeg].token]],];
//    _request = request;
//}

-(void)setOrder_no:(NSString *)order_no
{
    _order_no = order_no;
}


-(void)setProdBaseInfo:(TLGroupOrderProdBaseInfo *)prodBaseInfo
{
    _prodBaseInfo = prodBaseInfo;
    
    self.navigationItem.title = prodBaseInfo.goods_return_title;
    
    NSString *footString = [NSString stringWithFormat:@"order_no=%@",_order_no];
    _request = [TLHttpTool h5LoadWithUrl:prodBaseInfo.goods_return_url footString:footString];
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
