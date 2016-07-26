//
//  TLGroupShopSubmitOrderViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/8.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupShopSubmitOrderViewController.h"
#import "TLImageName.h"
#import "TLPaymentListViewController.h"
#import "TLGroupProductDetail.h"
#import "MBProgressHUD+MJ.h"
#import "UIColor+TL.h"
#import "TLChoiceCouponListViewController.h"
#import "TLGoods_info.h"
#import "TLVoucherBase.h"
#import "TLGroupOrderCreateRequest.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "TLGroupOrderCreate.h"
#import "TLGroupOrder.h"

@interface TLGroupShopSubmitOrderViewController ()<TLChoiceCouponListViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *gpCouponName;
@property (weak, nonatomic) IBOutlet UILabel *gpCouponPrice;
@property (weak, nonatomic) IBOutlet UIButton *jianHaoButton;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *jiahaoButton;
@property (weak, nonatomic) IBOutlet UILabel *orderOldAll;
@property (weak, nonatomic) IBOutlet UILabel *couponMessage;
@property (weak, nonatomic) IBOutlet UILabel *orderNewAllPrice;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic,strong) TLVoucherBase *voucher_base;
@property (nonatomic,assign) int prodNumber;
@property (nonatomic,strong) TLGroupOrderCreateRequest *groupOrderCreateRequest;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,strong) NSMutableDictionary *dictSpec;

//@property (nonatomic,strong) TLGroupProdSpecList *groupProdSpecList;


- (IBAction)couponList:(UIButton *)sender;
- (IBAction)jiahaoButton:(UIButton *)sender;
- (IBAction)jianhaoButton:(UIButton *)sender;
- (IBAction)submitButton:(UIButton *)sender;

@end

@implementation TLGroupShopSubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self setBase];
}

-(void)setBase
{
    if ([_type isEqualToString:@"未付款"]) {
        _gpCouponName.text = _groupOrder.prod_name;
        _gpCouponPrice.text = [NSString stringWithFormat:@"¥%@",_groupOrder.order_price];
        _jianHaoButton.enabled = [_groupOrder.order_qty intValue]-1;
        _couponMessage.text = _groupOrder.voucher_base.vouchers_name;
        _prodNumber = [_groupOrder.order_qty intValue];
        _voucher_base = _groupOrder.voucher_base;
        [self changeWithNumber:_prodNumber];
    }else
    {
        _gpCouponName.text = _groupProductDetail.prod_base_info.prod_name;
        _gpCouponPrice.text = [NSString stringWithFormat:@"¥%@",_groupProductDetail.prod_base_info.price];
        
        _jianHaoButton.enabled = NO;
        _couponMessage.text = @"不使用";
        TLVoucherBase *voucher_base = [[TLVoucherBase alloc]init];
        voucher_base.money = @"0";
        voucher_base.vouchers_number_id = @"";
        _prodNumber = 1;
        _voucher_base = voucher_base;
        [self changeWithNumber:_prodNumber];
    }

    
    [self setLayerWithId:_jianHaoButton];
    [self setLayerWithId:_jiahaoButton];
    [self setLayerWithId:_number];
}

-(void)setLayerWithId:(UIView *)view
{
    CGColorRef colorref = [UIColor getColor:@"d7d7d7"].CGColor;
    
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:1.0];
    [view.layer setBorderColor:colorref];
}

-(void)changeWithNumber:(NSInteger)prodNumber
{
    _number.text = [NSString stringWithFormat:@"%d",(int)prodNumber];
    _orderOldAll.text =  [NSString stringWithFormat:@"¥%.2f",_prodNumber*[[_gpCouponPrice.text substringFromIndex:1] floatValue]];
    _orderNewAllPrice.text = [NSString stringWithFormat:@"¥%.2f",[[_orderOldAll.text substringFromIndex:1] floatValue]-[_voucher_base.money floatValue]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.navigationItem.title = @"提交订单";
}
/**
 *  重写返回按钮
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setGroupProductDetail:(TLGroupProductDetail *)groupProductDetail
{
    _groupProductDetail = groupProductDetail;
    
    TLGroupOrderCreateRequest *groupOrderCreateRequest = [[TLGroupOrderCreateRequest alloc]init];
    groupOrderCreateRequest.product_id = _groupProductDetail.prod_base_info.prod_id;

    groupOrderCreateRequest.relation_id = _groupProductDetail.prod_base_info.relation_id;
    groupOrderCreateRequest.mstore_id = _groupProductDetail.prod_base_info.mstore_id;
    groupOrderCreateRequest.post_id = _groupProductDetail.prod_base_info.post_id;
    
    TLGroupProdSpecList *groupProdSpecList1 = [[TLGroupProdSpecList alloc]init];
    TLGroupProdSpecList *groupProdSpecList2 = [[TLGroupProdSpecList alloc]init];
    TLSpecDetailList *specDetail1 = [[TLSpecDetailList alloc]init];;
    TLSpecDetailList *specDetail2 = [[TLSpecDetailList alloc]init];
    NSMutableDictionary *dictSpec = [NSMutableDictionary dictionary];
    
    if (_groupProductDetail.prod_base_info.spec_detail_list.count > 1) {
        groupProdSpecList1 = _groupProductDetail.prod_base_info.spec_detail_list[0];
        groupProdSpecList2 = _groupProductDetail.prod_base_info.spec_detail_list[1];
        specDetail1 = groupProdSpecList1.spec_detail_list.firstObject;
        specDetail2 = groupProdSpecList2.spec_detail_list.firstObject;
        groupOrderCreateRequest.prod_spec_list = @[@{@"prod_spec_id":groupProdSpecList1.prod_spec_id,@"prod_spec_name":groupProdSpecList1.prod_spec_name,@"spec_detail_id":specDetail1.spec_detail_id,@"spec_detail_name":specDetail1.spec_detail_name},@{@"prod_spec_id":groupProdSpecList2.prod_spec_id,@"prod_spec_name":groupProdSpecList2.prod_spec_name,@"spec_detail_id":specDetail2.spec_detail_id,@"spec_detail_name":specDetail2.spec_detail_name}];
        
        [dictSpec setObject:_groupProductDetail.prod_base_info.prod_id forKey:@"goods_id"];
        [dictSpec setObject:specDetail1.spec_detail_id forKey:@"spec_id1"];
        [dictSpec setObject:specDetail2.spec_detail_id forKey:@"spec_id2"];

    }else
    {
        groupProdSpecList1 = _groupProductDetail.prod_base_info.spec_detail_list.firstObject;
        specDetail1 = groupProdSpecList1.spec_detail_list.firstObject;
        groupOrderCreateRequest.prod_spec_list = @[@{@"prod_spec_id":groupProdSpecList1.prod_spec_id,@"prod_spec_name":groupProdSpecList1.prod_spec_name,@"spec_detail_id":specDetail1.spec_detail_id,@"spec_detail_name":specDetail1.spec_detail_name}];
        [dictSpec setObject:_groupProductDetail.prod_base_info.prod_id forKey:@"goods_id"];
        [dictSpec setObject:specDetail1.spec_detail_id forKey:@"spec_id1"];
        [dictSpec setObject:@"" forKey:@"spec_id2"];
    }

    _dictSpec = dictSpec;
    _groupOrderCreateRequest = groupOrderCreateRequest;
}

-(void)setGroupOrder:(TLGroupOrder *)groupOrder
{
    _groupOrder = groupOrder;
    
    _gpCouponName.text = groupOrder.prod_name;
    _gpCouponPrice.text = [NSString stringWithFormat:@"¥%@",groupOrder.order_price];
    _jianHaoButton.enabled = [groupOrder.order_qty intValue]-1;
    _couponMessage.text = groupOrder.voucher_base.vouchers_name;
    _prodNumber = [groupOrder.order_qty intValue];
    _voucher_base = groupOrder.voucher_base;
    [self changeWithNumber:_prodNumber];
    
    TLGroupOrderCreateRequest *groupOrderCreateRequest = [[TLGroupOrderCreateRequest alloc]init];
    groupOrderCreateRequest.product_id = groupOrder.prod_id;
    groupOrderCreateRequest.relation_id = groupOrder.relation_id;
    groupOrderCreateRequest.order_no = groupOrder.order_no;
    
    TLProdSpecList_size *groupProdSpecList1 = [[TLProdSpecList_size alloc]init];
    TLProdSpecList_size *groupProdSpecList2 = [[TLProdSpecList_size alloc]init];
    NSMutableDictionary *dictSpec = [NSMutableDictionary dictionary];
    
    if (groupOrder.prod_spec_list.count > 1) {
        groupProdSpecList1 = groupOrder.prod_spec_list[0];
        groupProdSpecList2 = groupOrder.prod_spec_list[1];
         groupOrderCreateRequest.prod_spec_list = @[@{@"prod_spec_id":groupProdSpecList1.prod_spec_id,@"prod_spec_name":groupProdSpecList1.prod_spec_name,@"spec_detail_id":groupProdSpecList1.spec_detail_id,@"spec_detail_name":groupProdSpecList1.spec_detail_name},@{@"prod_spec_id":groupProdSpecList2.prod_spec_id,@"prod_spec_name":groupProdSpecList2.prod_spec_name,@"spec_detail_id":groupProdSpecList2.spec_detail_id,@"spec_detail_name":groupProdSpecList2.spec_detail_name}];
        [dictSpec setObject:_groupProductDetail.prod_base_info.prod_id forKey:@"goods_id"];
        [dictSpec setObject:groupProdSpecList1.spec_detail_id forKey:@"spec_id1"];
        [dictSpec setObject:groupProdSpecList2.spec_detail_id forKey:@"spec_id2"];
        
    }else
    {
        groupProdSpecList1 = groupOrder.prod_spec_list.firstObject;
         groupOrderCreateRequest.prod_spec_list = @[@{@"prod_spec_id":groupProdSpecList1.prod_spec_id,@"prod_spec_name":groupProdSpecList1.prod_spec_name,@"spec_detail_id":groupProdSpecList1.spec_detail_id,@"spec_detail_name":groupProdSpecList1.spec_detail_name}];
        [dictSpec setObject:groupOrder.prod_id forKey:@"goods_id"];
        [dictSpec setObject:groupProdSpecList1.spec_detail_id forKey:@"spec_id1"];
        [dictSpec setObject:@"" forKey:@"spec_id2"];

    }
    _dictSpec = dictSpec;
    _groupOrderCreateRequest = groupOrderCreateRequest;
}

-(void)setType:(NSString *)type
{
    _type = type;
}


- (IBAction)submitButton:(UIButton *)sender {
    
    _groupOrderCreateRequest.order_qty = [NSString stringWithFormat:@"%d",(int)_prodNumber];
    _groupOrderCreateRequest.price = [_gpCouponPrice.text substringFromIndex:1];
    _groupOrderCreateRequest.amount = [_orderOldAll.text substringFromIndex:1];
    _groupOrderCreateRequest.order_amount = [_orderNewAllPrice.text substringFromIndex:1];
    _groupOrderCreateRequest.vouchers_number_id = _voucher_base.vouchers_number_id;
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,_groupOrderCreateRequest.user_token,gp_product_order_create_Url];
    
        __weak typeof(self) weakSelf = self;
        [TLBaseTool postWithURL:url param:_groupOrderCreateRequest success:^(id result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                TLGroupOrderCreate *groupOrderCreate = result;
                TLPaymentListViewController *paymentListView = [[TLPaymentListViewController alloc]init];
                paymentListView.order_no = groupOrderCreate.order_no;
                paymentListView.prodType = @"8";
                paymentListView.actionType = @"pay";
                [weakSelf.navigationController pushViewController:paymentListView animated:YES];
            });
        } failure:nil resultClass:[TLGroupOrderCreate class]];
}
- (IBAction)couponList:(UIButton *)sender {

    TLChoiceCouponListViewController *choiceCouponListView = [[TLChoiceCouponListViewController alloc]init];
    choiceCouponListView.delegate = self;
    [_dictSpec setObject:[NSString stringWithFormat:@"%d",_prodNumber] forKey:@"buy_count"];

    choiceCouponListView.vouchers_number_id = _voucher_base.vouchers_number_id;
    choiceCouponListView.goodInfoArray = @[_dictSpec];
    [self.navigationController pushViewController:choiceCouponListView animated:YES];
}

-(void)choiceCouponListViewController:(TLChoiceCouponListViewController *)choiceCouponListView withTLVoucherBase:(TLVoucherBase *)voucher_base
{
    _voucher_base = voucher_base;
    _couponMessage.text = voucher_base.vouchers_name;
    _orderNewAllPrice.text = [NSString stringWithFormat:@"¥%.2f",[[_orderOldAll.text substringFromIndex:1] floatValue]-[_voucher_base.money floatValue]];
}


- (IBAction)jiahaoButton:(UIButton *)sender {
    _prodNumber++;
    _jianHaoButton.enabled = YES;
    [self changeWithNumber:_prodNumber];
}

- (IBAction)jianhaoButton:(UIButton *)sender {
    if (_prodNumber > 1) {
        _prodNumber--;
        [self changeWithNumber:_prodNumber];
    }else
    {
        _jianHaoButton.enabled = NO;
    }
}
@end
