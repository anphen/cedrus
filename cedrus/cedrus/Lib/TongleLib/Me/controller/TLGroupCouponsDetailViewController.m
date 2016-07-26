//
//  TLGroupCouponsDetailViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/18.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupCouponsDetailViewController.h"
#import "TLGroupCouponDetailHeadView.h"
#import "TLGroupCouponDetailRequest.h"
#import "TLGroupPurchaseShopView.h"
#import "TLGroupProdDetailView.h"
#import "TLGroupCouponDetail.h"
#import "TLImageName.h"
#import "UIColor+TL.h"
#import "TLGroupCoupons.h"
#import "TLGroupCouponCode.h"
#import "TLBaseTool.h"
#import "UIImageView+Image.h"
#import "Url.h"
#import "TLGroupPurchaseViewController.h"
#import "TLProduct.h"
#import "TLIntegrateDetailController.h"
#import "TLProdDetailsMeg.h"
#import "TLProdMessageViewController.h"
#import <MessageUI/MessageUI.h>
#import "TLGroupPurchaseShopListController.h"


@interface TLGroupCouponsDetailViewController ()<MFMessageComposeViewControllerDelegate,TLGroupPurchaseShopViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,strong) TLGroupCouponDetail *groupCouponDetail;
@property (nonatomic,weak) UIButton *cover;
@property (nonatomic,weak) UIImageView *qrcodeImage;
@property (nonatomic,weak) UIView *codeBlackView;
@property (nonatomic,weak) UIButton *rightButton;
@end

@implementation TLGroupCouponsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    //[self setSubview];
    // Do any additional setup after loading the view.
}

//自定义导航栏
- (void)initNavigationBar
{
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.frame = CGRectMake(0, 0, 75, 25);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton addTarget:self action:@selector(takeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"再来一单" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor getColor:@"7acafd"] forState:UIControlStateNormal];
    rightButton.enabled = NO;
    _rightButton = rightButton;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"团购券详情";
}
/**
 *  重写返回按钮
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setGroupCoupons:(TLGroupCoupons *)groupCoupons
{
    _groupCoupons = groupCoupons;
}

-(void)setGroupCouponCode:(TLGroupCouponCode *)groupCouponCode
{
    _groupCouponCode = groupCouponCode;
    [self loadData];
}

-(void)loadData
{
    TLGroupCouponDetailRequest *groupCouponDetailRequest = [[TLGroupCouponDetailRequest alloc]init];
    groupCouponDetailRequest.order_no = _groupCoupons.order_no;
    groupCouponDetailRequest.coupon_code = _groupCouponCode.coupon_code;
    groupCouponDetailRequest.out_of_date = _groupCoupons.out_of_date;
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,groupCouponDetailRequest.user_token,gp_coupon_show_Url];
    __weak typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:groupCouponDetailRequest success:^(id result) {
        TLGroupCouponDetail *groupCouponDetail = result;
        _groupCouponDetail = groupCouponDetail;
        _rightButton.enabled = YES;
        [weakSelf setSubview];
    } failure:nil resultClass:[TLGroupCouponDetail class]];
}



-(void)takeOrder:(UIButton *)button
{
    [self actionToProdDetail];
}

-(void)setSubview
{
    TLGroupCouponDetailHeadView *groupCouponDetailHeadView = [TLGroupCouponDetailHeadView createView];
    groupCouponDetailHeadView.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, 268);
    __block NSString *coupon_2d_qrcode_url =  _groupCouponDetail.coupon_codeurl_info.coupon_2d_qrcode_url;
    __block NSString *coupon_1d_qrcode_url = _groupCouponDetail.coupon_codeurl_info.coupon_1d_qrcode_url;
    __weak typeof(self) weakSelf = self;
    groupCouponDetailHeadView.codeblack = ^{
        [weakSelf qrcodeWithurl1:coupon_1d_qrcode_url url2:coupon_2d_qrcode_url];
    };
    groupCouponDetailHeadView.couponDetail = ^{
        [weakSelf actionToProdDetail];
    };
    
    groupCouponDetailHeadView.rebackProduct = ^{
        TLIntegrateDetailController *integrateDetailController = [[TLIntegrateDetailController alloc]init];
        integrateDetailController.order_no = _groupCoupons.order_no;
        integrateDetailController.prodBaseInfo = _groupCouponDetail.prod_base_info;
        [weakSelf.navigationController pushViewController:integrateDetailController animated:YES];
    };
    
    groupCouponDetailHeadView.tendmessage = ^(NSString *string){
        [weakSelf showMassageViewTel:[NSArray arrayWithObject:[TLUserDefaults objectForKey:TLPhone_number]] withMessage:string];
    };
    
    [self.scrollView addSubview:groupCouponDetailHeadView];
    groupCouponDetailHeadView.groupCouponDetail = _groupCouponDetail;
    
    TLGroupPurchaseShopView *groupPurchaseShopView = [[TLGroupPurchaseShopView alloc]init];
    groupPurchaseShopView.coupon_store_info = _groupCouponDetail.coupon_store_info;
    groupPurchaseShopView.delegate = self;
    groupPurchaseShopView.frame = CGRectMake(0, CGRectGetMaxY(groupCouponDetailHeadView.frame), self.scrollView.bounds.size.width, groupPurchaseShopView.height);
    [self.scrollView addSubview:groupPurchaseShopView];
    
    TLGroupProdDetailView *groupProdDetailView = [[TLGroupProdDetailView alloc]init];
    __unsafe_unretained __typeof(self) weakself = self;
    groupProdDetailView.productDetailBlack = ^{
        [weakself productMessageWithType:@"图文详情"];
    };
    groupProdDetailView.groupCouponPurchaseInfo = _groupCouponDetail.coupon_purchase_info;
    groupProdDetailView.frame = CGRectMake(0, CGRectGetMaxY(groupPurchaseShopView.frame), self.scrollView.frame.size.width, groupProdDetailView.height);
    [self.scrollView addSubview:groupProdDetailView];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(groupProdDetailView.frame));
}

-(void)groupPurchaseShopView:(TLGroupPurchaseShopView *)groupPurchaseShopView selectShopListButton:(UIButton *)button
{
    TLGroupPurchaseShopListController *groupPurchaseShopListController = [[TLGroupPurchaseShopListController alloc]init];
    groupPurchaseShopListController.prod_id = _groupCouponDetail.prod_base_info.prod_id;
    [self.navigationController pushViewController:groupPurchaseShopListController animated:YES];
}

-(void)productMessageWithType:(NSString *)type
{
    TLProdDetailsMeg  *prodDetailsMeg = [[TLProdDetailsMeg alloc]init];
    prodDetailsMeg.prod_info.prod_favorited_by_me  = @"0";
    [[NSUserDefaults standardUserDefaults] setObject:_groupCouponDetail.prod_base_info.prod_id forKey:TL_PROD_DETAILS_PROD_ID];
    prodDetailsMeg.prod_info.prod_id = _groupCouponDetail.prod_base_info.prod_id;
    
    TLProdMessageViewController *prodMessageViewController = [[UIStoryboard storyboardWithName:STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:@"prodMessageViewController"];
    prodMessageViewController.prodDetails = prodDetailsMeg.prod_info;
    prodMessageViewController.type = type;
    prodMessageViewController.prodType = @"1";
    [self.navigationController pushViewController:prodMessageViewController animated:YES];
}



-(void)actionToProdDetail
{
    TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
    TLProduct *product = [[TLProduct alloc]init];
    product.prod_id = _groupCouponDetail.prod_base_info.prod_id;
    product.relation_id = _groupCouponDetail.prod_base_info.relation_id;
    groupPurchaseView.product = product;
    groupPurchaseView.action = prod_order;
    [self.navigationController pushViewController:groupPurchaseView animated:YES];
}


-(void)qrcodeWithurl1:(NSString *)url1 url2:(NSString *)url2
{
    UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = CGRectMake(0, 0, ScreenBounds.size.width, ScreenBounds.size.height);
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    [blackView addSubview:cover];
    
    UIView *codeBlackView = [[UIView alloc]init];
    codeBlackView.backgroundColor = [UIColor whiteColor];
    [codeBlackView.layer setMasksToBounds:YES];
    [codeBlackView.layer setCornerRadius:8.0]; //设置矩圆角半径
    codeBlackView.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
    [blackView addSubview:codeBlackView];
    self.codeBlackView = codeBlackView;
    [blackView bringSubviewToFront:codeBlackView];
    
    
    UIImageView *qrcode1 = [[UIImageView alloc]init];
    [qrcode1 setImageWithURL:url1 placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    qrcode1.center = CGPointMake(codeBlackView.frame.size.width/2, codeBlackView.frame.size.height/5);
    [codeBlackView addSubview:qrcode1];
    
    
    UIView *centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor getColor:@"d6d6d6"];
    centerView.center = CGPointMake(codeBlackView.frame.size.width/2, codeBlackView.frame.size.height*2/5);
    [codeBlackView addSubview:centerView];
    
    
    UIImageView *qrcode2 = [[UIImageView alloc]init];
    [qrcode2 setImageWithURL:url2 placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    qrcode2.center = CGPointMake(codeBlackView.frame.size.width/2, codeBlackView.frame.size.height*7/10);
    [codeBlackView addSubview:qrcode2];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.5;
        CGFloat iconWH = TL_QRCODE_WH;
        
        CGFloat iconX = (cover.frame.size.width - iconWH)/2;
        CGFloat iconY = (cover.frame.size.height - iconWH)/2;
        codeBlackView.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
        
        qrcode1.center = CGPointMake(codeBlackView.frame.size.width/2, codeBlackView.frame.size.height/5);
        qrcode1.bounds = CGRectMake(0, 0, codeBlackView.frame.size.height*4/7, codeBlackView.frame.size.height/5);
        
        centerView.center = CGPointMake(codeBlackView.frame.size.width/2, codeBlackView.frame.size.height*2/5);
        centerView.bounds = CGRectMake(0, 0, codeBlackView.frame.size.width-20, 1);
        
        qrcode2.center = CGPointMake(codeBlackView.frame.size.width/2, codeBlackView.frame.size.height*7/10);
        qrcode2.bounds = CGRectMake(0, 0, codeBlackView.frame.size.height*2/5, codeBlackView.frame.size.height*2/5);
        
    }];
}


-(void)smallimg
{
    __unsafe_unretained __typeof(self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakself.cover removeFromSuperview];
        [weakself.codeBlackView removeFromSuperview];
        weakself.cover = nil;
        
    }];
}


-(void)showMassageViewTel:(NSArray *)telArray withMessage:(NSString *)message
{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc]init];
        controller.recipients = telArray;
        controller.body = message;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers]lastObject] navigationItem]setTitle:@"发送手机"];
    }else
    {
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:NO completion:nil];

    switch (result) {
        case MessageComposeResultCancelled:
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        default:
            break;
    }
}

-(void)alertWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
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
