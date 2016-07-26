//
//  TLCheckoutViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-2.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLCheckoutViewController.h"
#import "TLSelectAddressViewController.h"
#import "TLProdPurchaseViewController.h"
#import "TLDeliveriesViewController.h"
#import "TLDeliveriesDataViewController.h"
#import "TLAddressViewCell.h"
#import "TLOrderFootViewCell.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLAllAddresses.h"
#import "TLShopCar.h"
#import "TLBasicData.h"
#import "TLBaseDateType.h"
#import "TLBaseTool.h"
#import "TLDataList.h"
#import "JSONKit.h"
#import "NSObject+MJKeyValue.h"
#import "TLNavigationBar.h"
#import "TLOrderMode.h"
#import "TLNewOrderBack.h"
#import "TLOrderViewController.h"
#import "TLCarOrderViewCell.h"
#import "TLImageName.h"
#import "Url.h"
#import "UIColor+TL.h"
#import "TLCommon.h"
#import "TLHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "TLOrderDetailMeg.h"
#import "TLChoiceCouponListViewController.h"
#import "TLVoucherBase.h"
#import "TLPaymentListViewController.h"


@interface TLCheckoutViewController ()<TLSelectAddressViewControllerDelegate,TLDeliveriesViewControllerDelegate,TLDeliveriesDataViewControllerDelegate,TLNavigationBarDelegate,TLOrderFootViewCellDelegate,TLChoiceCouponListViewControllerDelegate>

@property (nonatomic,strong)    UITableViewCell     *express;
@property (nonatomic,strong)    UITableViewCell     *deliveryDate;
@property (nonatomic,strong)    UITableViewCell     *couponcell;
@property (nonatomic,strong)    TLAddressViewCell   *addressViewCell;
@property (nonatomic,strong)    TLOrderFootViewCell *orderFootViewCell;
@property (nonatomic,copy)      NSString            *user_id;
@property (nonatomic,copy)      NSString            *token;
@property (nonatomic,strong)    NSArray             *allAddressre;
@property (nonatomic,strong)    TLBasicData         *baseDate;
@property (nonatomic,strong)    TLBaseDateType      *baseDateType;
@property (nonatomic,strong)    TLDataList          *dataList;
@property (nonatomic,copy)      NSString            *expressWithDetailText;
@property (nonatomic,copy)      NSString            *expressWithCode;
@property (nonatomic,copy)      NSString            *expressWithDateText;
@property (nonatomic,copy)      NSString            *expressWithDateCode;
@property (nonatomic,copy)      NSString            *couponcellText;
@property (nonatomic,copy)      NSString            *couponcellCode;
@property (nonatomic,copy)      NSString            *couponmoney;
@property (nonatomic,strong)    TLAllAddresses      *AllAddresses;
@property (nonatomic,strong)    TLOrderMode         *orderMode;
@property (nonatomic,strong)    UILabel             *prompt;


@end

@implementation TLCheckoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    [self loadAddress];
    [self initNavigationBar];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    
}

-(TLAddressViewCell *)addressViewCell
{
    if (_addressViewCell == nil) {
        TLAddressViewCell *addressViewCell = [TLAddressViewCell Cellwithtable:self.tableView];
        _addressViewCell = addressViewCell;
    }
    return _addressViewCell;
}

/**
 *  配送方式懒加载
 *
 *  @param detailText 配送方式
 *
 *  @return
 */
-(UITableViewCell *)expressWithDetailText:(NSString *)detailText
{
    if (_express == nil) {
        UITableViewCell *express = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        express.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        express.selectionStyle = UITableViewCellSelectionStyleNone;
        express.textLabel.text = @"配送方式";
        express.textLabel.font = [UIFont systemFontOfSize:12];
        [express.textLabel setTextColor:[UIColor getColor:@"5f646e"]];
        express.detailTextLabel.font = [UIFont systemFontOfSize:12];
        [express.detailTextLabel setTextColor:[UIColor getColor:@"5f646e"]];
        _express = express;
    }
    _express.detailTextLabel.text = detailText;
    return _express;
}

/**
 *  配送时间懒加载
 *
 *  @param text 配送时间
 *
 *  @return
 */
-(UITableViewCell *)deliveryDateWithDateText:(NSString *)text
{
    if (_deliveryDate == nil) {
        UITableViewCell *deliveryDate = [[UITableViewCell alloc]init];
        deliveryDate.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        deliveryDate.selectionStyle = UITableViewCellSelectionStyleNone;
        deliveryDate.textLabel.font = [UIFont systemFontOfSize:12];
        [deliveryDate.textLabel setTextColor:[UIColor getColor:@"5f646e"]];
        self.baseDateType = self.baseDate.base_data_list[5];
        self.dataList = self.baseDateType.data_list[0];
        _deliveryDate = deliveryDate;
    }
     _deliveryDate.textLabel.text = text;
    return _deliveryDate;
}

/**
 *  优惠券
 *
 *  @param _couponcell
 *
 *  @return
 */
-(UITableViewCell *)couponcellWithText:(NSString *)Text
{
    if (_couponcell == nil) {
        UITableViewCell *couponcell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        couponcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        couponcell.selectionStyle = UITableViewCellSelectionStyleNone;
        couponcell.textLabel.text = @"使用优惠券";
        couponcell.textLabel.font = [UIFont systemFontOfSize:12];
        [couponcell.textLabel setTextColor:[UIColor getColor:@"5f646e"]];
        couponcell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        [couponcell.detailTextLabel setTextColor:[UIColor getColor:@"5f646e"]];
        _couponcell = couponcell;
    }
    _couponcell.detailTextLabel.text = Text;
    return _couponcell;
}


/**
 *  加载基础数据
 */
-(void)setUpData
{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    TLBasicData *baseData = [[TLBasicData alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:TLBaseDataFilePath]error:nil];
    self.baseDate = baseData;
    
    self.baseDateType = self.baseDate.base_data_list[2];
    self.dataList = self.baseDateType.data_list[0];
    self.expressWithDetailText = self.dataList.name;
    self.expressWithCode = self.dataList.code;


    self.baseDateType = self.baseDate.base_data_list[5];
    self.dataList = self.baseDateType.data_list[0];
    self.expressWithDateText = self.dataList.name;
    self.expressWithDateCode = self.dataList.code;
    
    self.couponcellText = _orderDetailMeg.vouchers_name;
    self.couponcellCode = _orderDetailMeg.vouchers_number_id;
    self.couponmoney = _orderDetailMeg.money;
}

/**
 *  加载我的收货地址
 */
-(void)loadAddress
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,my_addresses_Url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN, nil];
    __unsafe_unretained __typeof(self) weakSelf = self;
        [TLHttpTool postWithURL:url params:params success:^(id json) {
            TLAllAddresses *allAddresses = [TLAllAddresses objectWithKeyValues:json[@"body"]];
            [NSKeyedArchiver archiveRootObject:allAddresses.my_address_list toFile:TLAddressDataFilePath];
            weakSelf.allAddressre = allAddresses.my_address_list;
            if (weakSelf.allAddressre.count) {
                if (weakSelf.prompt != nil) {
                    [weakSelf.prompt removeFromSuperview];
                    weakSelf.prompt = nil;
                }
                weakSelf.addressViewCell.address = weakSelf.allAddressre[0];
                for (TLAddress *address in weakSelf.allAddressre)
                {
                    if ([address.default_flag isEqualToString:@"0"])
                    {
                        weakSelf.addressViewCell.address = address;
                    }
                }
            }else
            {
                //self.addressViewCell.address = nil;
                [weakSelf setPrompt];
            }
            [weakSelf.tableView reloadData];
            
        } failure:nil];
}

-(void)setPrompt
{
    if (self.prompt == nil) {
        UILabel *prompt = [[UILabel alloc]init];
        prompt.text = TL_ADDRESS_ADD_TIPS;
        prompt.textColor = [UIColor redColor];
        prompt.font = [UIFont systemFontOfSize:20];
        prompt.bounds = CGRectMake(0, 0, 200, self.addressViewCell.contentView.bounds.size.height/2);
        prompt.center = CGPointMake(ScreenBounds.size.width/2, self.addressViewCell.contentView.bounds.size.height/2);
        [self.addressViewCell.contentView addSubview:prompt];
        self.prompt = prompt;
    }
}

-(void)setOrderDetailMeg:(TLOrderDetailMeg *)orderDetailMeg
{
    _orderDetailMeg = orderDetailMeg;
}

-(void)setChectoutProduct:(NSArray *)chectoutProduct
{
    _chectoutProduct = chectoutProduct;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    return self.chectoutProduct.count +5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return self.addressViewCell;
    }else if (indexPath.row<=self.chectoutProduct.count && indexPath.row > 0) {
        TLCarOrderViewCell *cell = [TLCarOrderViewCell cellWithTableView:tableView];
        cell.shopcar = self.chectoutProduct[indexPath.row-1];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if (indexPath.row == (self.chectoutProduct.count +1))
    {
        return [self expressWithDetailText:self.expressWithDetailText];;
    }else if(indexPath.row == (self.chectoutProduct.count +2))
    {
        return [self deliveryDateWithDateText:self.expressWithDateText];
    }else if(indexPath.row == (self.chectoutProduct.count +3))
    {
        return [self couponcellWithText:self.couponcellText];
    }
    else //(indexPath.row == (self.chectoutProduct.count +4))
    {
        TLOrderFootViewCell *cell = [TLOrderFootViewCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.orderDetailMeg = self.orderDetailMeg;
        cell.couponmoney = self.couponmoney;
        cell.baseData = self.baseDate;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }else if(indexPath.row<=self.chectoutProduct.count && indexPath.row >0)
    {
        return 100;
    }else if((indexPath.row>self.chectoutProduct.count) && (indexPath.row<self.chectoutProduct.count+4))
    {
        return 50;
    }else //if(indexPath.row == (self.chectoutProduct.count + 3))
    {
        
//        TLBaseDateType *payBaseDataType = self.baseDate.base_data_list[1];
//        if (payBaseDataType.data_list.count <= 3) {
//            //加发票return 509;
//            return 357;
//        }else
//        {
//            //加发票return 543;
//            return 391;
//        }
         return 319;
    }
}

/**
 *  控制器跳转
 *
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self performSegueWithIdentifier:TL_ORDER_ADDRSS sender:self.allAddressre];

    }else if (indexPath.row == (self.chectoutProduct.count + 1)) {
        [self performSegueWithIdentifier:TL_ORDER_DELIVERIES sender:self.baseDate.base_data_list[2]];
    }else if (indexPath.row == (self.chectoutProduct.count + 2))
    {
        [self performSegueWithIdentifier:TL_ORDER_DELIVERIES_DATE sender:self.baseDate.base_data_list[5]];
    }else if (indexPath.row == (self.chectoutProduct.count + 3))
    {
        [self couponProd];
    }
}

-(void)couponProd
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (TLMyShoppingCart *shopCart in _orderDetailMeg.my_shopping_cart) {
        if (shopCart.prod_spec_list.count == 1) {
            TLProdSpecList_size *spec = shopCart.prod_spec_list[0];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:shopCart.prod_id,@"goods_id",spec.spec_detail_id,@"spec_id1",@"",@"spec_id2",shopCart.order_qty,@"buy_count", nil];
            [mutableArray addObject:dict];
        }else
        {
            TLProdSpecList_size *spec0 = shopCart.prod_spec_list[0];
            TLProdSpecList_size *spec1 = shopCart.prod_spec_list[1];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:shopCart.prod_id,@"goods_id",spec0.spec_detail_id,@"spec_id1",spec1.spec_detail_id,@"spec_id2",shopCart.order_qty,@"buy_count", nil];
            [mutableArray addObject:dict];
        }
    }
    TLChoiceCouponListViewController *choiceCouponListView = [[TLChoiceCouponListViewController alloc]init];
    choiceCouponListView.delegate = self;
    choiceCouponListView.vouchers_number_id = self.couponcellCode;
    choiceCouponListView.goodInfoArray = (NSArray *)mutableArray;
    [self.navigationController pushViewController:choiceCouponListView animated:YES];
}

-(void)choiceCouponListViewController:(TLChoiceCouponListViewController *)choiceCouponListView withTLVoucherBase:(TLVoucherBase *)voucher_base
{
    self.couponcellText = voucher_base.vouchers_name;
    self.couponcellCode = voucher_base.vouchers_number_id;
    self.couponmoney = voucher_base.money;
    [self.tableView reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLSelectAddressViewController class]]) {
        TLSelectAddressViewController *selectAddressView = vc;
        selectAddressView.delegate = self;

        }else if ([vc isKindOfClass:[TLDeliveriesViewController class]])
        {
            TLDeliveriesViewController *deliveriesView = vc;
            deliveriesView.baseDateType = sender;
            deliveriesView.delegate = self;
        }else if ([vc isKindOfClass:[TLDeliveriesDataViewController class]])
        {
            TLDeliveriesDataViewController *DeliveriesDate = vc;
            DeliveriesDate.baseDateType = sender;
            DeliveriesDate.delegate = self;
        }else if([vc isKindOfClass:[TLOrderViewController class]])
        {
            TLOrderViewController *order = vc;
            order.type = sender;
        }
}


/**
 *  提交新订单
 *
 *  @param orderFootViewCell
 *  @param orderMode         订单模型
 */
-(void)orderFootViewCell:(TLOrderFootViewCell *)orderFootViewCell withOrderMode:(TLOrderMode *)orderMode
{
    /**
     *  对发票正确进行判断
     */
    if ((![orderMode.invoice_info[@"invoice_type_no"]isEqualToString:@""])&& ([orderMode.invoice_info[@"invoice_title"] isEqual:@""])) {
        [MBProgressHUD showError:TL_INVOICE_TIPS];
    }else
    {
        /**
         *  对地址正确进行验证
         */
        self.orderMode.address_no = self.addressViewCell.address.address_no;
        if ((unsigned long)self.addressViewCell.address.address_no.length == 0) {
            [MBProgressHUD showError:TL_ADDRESS_ADD_TIPS];
        }else
        {
            self.orderMode = orderMode;
            self.orderMode.address_no = self.addressViewCell.address.address_no;
            NSDictionary *shipping_method = [NSDictionary dictionaryWithObjectsAndKeys:self.expressWithCode,@"shipping_method_no",self.expressWithDateCode,@"shipping_time_memo", nil];
            self.orderMode.shipping_method = shipping_method;
            
            NSMutableArray *temp = [NSMutableArray array];
            for (TLShopCar *shopcar in self.chectoutProduct) {
                NSDictionary *product_list = [NSDictionary dictionaryWithObjectsAndKeys:shopcar.seq_no,@"seq_no",shopcar.prod_id,@"product_id", nil];
                [temp addObject:product_list];
            }
            self.orderMode.product_list = temp;
            self.orderMode.invoice_type = TLNO;
            
            if (!self.orderMode.invoice_info.count) {
                self.orderMode.invoice_info = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"invoice_type_no",@"",@"invoice_content_flag",@"",@"invoice_title", nil];
                self.orderMode.invoice_type = TLYES;
            }
            
            NSDictionary *dictOrderModel = [NSDictionary dictionaryWithObjectsAndKeys:self.orderMode.product_list,@"product_list",self.orderMode.address_no,@"address_no",@"",@"pay_type",self.orderMode.invoice_type,@"invoice_type",self.orderMode.shipping_method,@"shipping_method",self.orderMode.invoice_info,@"invoice_info",self.orderMode.order_memo,@"order_memo",self.orderDetailMeg.total_tariff,@"tariff",self.couponcellCode,@"vouchers_number_id", nil];
            NSDictionary *dictJson = [NSDictionary dictionaryWithObjectsAndKeys:dictOrderModel,@"order_info", nil];
            NSString *strJson = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dictJson options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
            
            NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,orders_create_Url];
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,strJson,@"order_info_json",[TLUserDefaults objectForKey:TLBUY_USER_ID],@"buy_user_id", nil];
            __weak typeof(self) weakSelf = self;
            [TLHttpTool postWithURL:url params:params success:^(id json)
             {
                 NSDictionary *dict = json[@"body"];
                 NSDictionary *dictOrderInfo = dict[@"order_info"];
                 /**
                  *  提交成功进行跳转
                  */
               //  [MBProgressHUD showSuccess:TL_ORDER_SUCCESS];
                 
                 TLPaymentListViewController *paymentListView = [[TLPaymentListViewController alloc]init];
                 paymentListView.order_no = dictOrderInfo[@"order_no"];
                 paymentListView.prodType = @"1";
                 paymentListView.actionType = @"pay";
                 [weakSelf.navigationController pushViewController:paymentListView animated:YES];
                 //[self performSegueWithIdentifier:@"ordersuccess" sender:@"提交订单"];
             } failure:nil];
        }
    }
    
}

/**
 *  改变地址
 *
 *  @param selectAddressViewController 地址列表控制器
 *  @param address                     所选择的地址
 */
-(void)changeAddressWithController:(TLSelectAddressViewController *)selectAddressViewController didAddress:(TLAddress *)address
{
    if (self.prompt != nil) {
         [self.prompt removeFromSuperview];
        self.prompt = nil;
    }
   self.addressViewCell.address = address;
   [self.tableView reloadData];
    
}


-(void)changeAddressWithController:(TLSelectAddressViewController *)selectAddressViewController didNoAddress:(TLAddress *)address
{
    //self.addressViewCell.address = nil;
    [self setPrompt];
}
/**
 *  改变配送方式
 *
 *  @param selectAddressViewController 配送方式列表
 *  @param dataList                    配送方式
 */
-(void)changeDeliveriesWithController:(TLDeliveriesViewController *)selectAddressViewController didAddress:(TLDataList *)dataList
{
    self.expressWithDetailText = dataList.name;
    self.expressWithCode = dataList.code;
    [self.tableView reloadData];
}

/**
 *  改变配送时间
 *
 *  @param selectAddressViewController 配送时间列表
 *  @param dataList                    配送时间
 */
-(void)changeDeliveriesDateWithController:(TLDeliveriesDataViewController *)selectAddressViewController didAddress:(TLDataList *)dataList
{
    self.expressWithDateText = dataList.name;
    self.expressWithDateCode = dataList.code;
    [self.tableView reloadData];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}

@end
