//
//  TLGroupOrderDetailViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/21.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupOrderDetailViewController.h"
#import "TLGroupOrderDetail.h"
#import "TLGroupOrderDetailViewCell.h"
#import "TLGroupOrderDetailFooterViewCell.h"
#import "TLGroupOrderDetailCouponViewCell.h"
#import "TLImageName.h"
#import "TLGroupOrderDetailRequest.h"
#import "TLGroupOrderDetail.h"
#import "TLBaseTool.h"
#import "Url.h"
#import "UIColor+TL.h"
#import "TLGroupPurchaseViewController.h"
#import "TLProduct.h"
#import "UIImageView+Image.h"
#import "RatingBarView.h"
#import "MBProgressHUD+MJ.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"

@interface TLGroupOrderDetailViewController ()<RatingBarViewDelegate>

@property (nonatomic,strong) TLGroupOrderDetail *groupOrderDetail;
@property (nonatomic,strong) NSMutableArray *couponArray;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,weak) UIButton *cover;
@property (nonatomic,weak) UIImageView *qrcodeImage;
@property (nonatomic,weak) UIView *codeBlackView;
@property (nonatomic,weak) UIButton *rightButton;
@property (nonatomic,weak) RatingBarView *ratingBarView;


@end

@implementation TLGroupOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    [self initNavigationBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self loadData];
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
    rightButton.hidden = YES;
    _rightButton =rightButton;
    rightButton.frame = CGRectMake(0, 0, 50, 25);
    [rightButton setTitle:@"评价" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(ratingBarAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor getColor:@"7acafd"] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单详情";
}
/**
 *  重写返回按钮
 */
-(void)back
{
    if ([_actionType isEqualToString:@"pay"]) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count]-3)] animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)ratingBarAction
{
    UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    UIView *codeBlackView = [[UIView alloc]init];
    codeBlackView.frame = blackView.bounds;
    codeBlackView.backgroundColor = [UIColor blackColor];
    codeBlackView.alpha = 0.3;
    self.codeBlackView = codeBlackView;
    [blackView addSubview:codeBlackView];
    
    
    RatingBarView *ratingBarView = [[RatingBarView alloc]init];
    ratingBarView.backgroundColor = [UIColor whiteColor];
    [blackView addSubview:ratingBarView];
    [blackView bringSubviewToFront:ratingBarView];
    ratingBarView.delegate  = self;
    _ratingBarView = ratingBarView;
    ratingBarView.center = CGPointMake(blackView.bounds.size.width/2, blackView.bounds.size.height/2);
    [UIView animateWithDuration:0.1 animations:^{
        ratingBarView.bounds = CGRectMake(0, 0, blackView.bounds.size.width-40, 250);
    }];
}


-(void)loadData
{
    TLGroupOrderDetailRequest *groupOrderDetailRequest = [[TLGroupOrderDetailRequest alloc]init];
    groupOrderDetailRequest.order_no = _order_no;
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,groupOrderDetailRequest.user_token,orders_gp_order_detail_Url];
    [TLBaseTool postWithURL:url param:groupOrderDetailRequest success:^(id result) {
        TLGroupOrderDetail *groupOrderDetail = result;
        _groupOrderDetail = groupOrderDetail;
        _rightButton.hidden = [groupOrderDetail.order_base.evaluate_flag intValue];
        [self setDataWithGroupOrderDetail:groupOrderDetail];
        [self.tableView reloadData];
    } failure:nil resultClass:[TLGroupOrderDetail class]];
}


-(void)setOrder_no:(NSString *)order_no
{
    _order_no = order_no;
}

-(void)setActionType:(NSString *)actionType
{
    _actionType = actionType;
}


-(NSMutableArray *)couponArray
{
    if (_couponArray == nil) {
        _couponArray = [NSMutableArray array];
    }
    return _couponArray;
}

-(void)setDataWithGroupOrderDetail:(TLGroupOrderDetail *)groupOrderDetail
{
    [self.couponArray removeAllObjects];
    [self setDictWithArray:groupOrderDetail.unused_coupon_list type:@"可使用"];
    [self setDictWithArray:groupOrderDetail.refunding_coupon_list type:@"退款中"];
    [self setDictWithArray:groupOrderDetail.refund_coupon_list type:@"已退款"];
    [self setDictWithArray:groupOrderDetail.used_coupon_list type:@"已消费"];
    [self setDictWithArray:groupOrderDetail.expire_coupon_list type:@"已过期"];
}

-(void)setDictWithArray:(NSArray *)array type:(NSString *)type
{
    if (array.count) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array,@"couponArray",type,@"couponType", nil];
        [self.couponArray addObject:dict];
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2+ [[NSNumber numberWithInteger:_groupOrderDetail.unused_coupon_list.count] boolValue]+ [[NSNumber numberWithInteger:_groupOrderDetail.refund_coupon_list.count] boolValue] + [[NSNumber numberWithInteger:_groupOrderDetail.used_coupon_list.count] boolValue] + [[NSNumber numberWithInteger:_groupOrderDetail.expire_coupon_list.count] boolValue]+[[NSNumber numberWithInteger:_groupOrderDetail.refunding_coupon_list.count] boolValue];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLGroupOrderDetailViewCell *cell = [TLGroupOrderDetailViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.groupOrderBase = _groupOrderDetail.order_base;
        return cell;
    }
    else if (indexPath.section == (_couponArray.count+1))
    {
        TLGroupOrderDetailFooterViewCell *cell = [TLGroupOrderDetailFooterViewCell cellWithTableView:tableView];
        cell.groupOrderBase = _groupOrderDetail.order_base;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        TLGroupOrderDetailCouponViewCell *cell = [TLGroupOrderDetailCouponViewCell cellWithTableview:tableView indexPath:indexPath];
        __weak typeof(self)weakSelf=self;
        __block NSString *coupon_2d_qrcode_url = _groupOrderDetail.coupon_codeurl_info.coupon_2d_qrcode_url;
        __block NSString *coupon_1d_qrcode_url = _groupOrderDetail.coupon_codeurl_info.coupon_1d_qrcode_url;
        cell.codebutton = ^{
            [weakSelf qrcodeWithurl1:coupon_1d_qrcode_url url2:coupon_2d_qrcode_url];
        };
        cell.groupDetailCouponDict = self.couponArray[indexPath.section-1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.height = cell.height;
        return cell;
    }
    
    return nil;
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



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 86;
    }else if (indexPath.section == (_couponArray.count+1))
    {
        return 93;
    }else
    {
        return self.height;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 30)];
        footer.backgroundColor = [UIColor getColor:@"f4f4f4"];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 10)];
        title.font = [UIFont systemFontOfSize:15];
        title.text = @"团购券";
        title.textColor = [UIColor getColor:@"999999"];
        [footer addSubview:title];
        return footer;
    }
    return nil;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 30;
    }else if(section == (_couponArray.count+1))
    {
        return 0;
    }else
    {
        return 10;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
        TLProduct *product = [[TLProduct alloc]init];
        product.prod_id = _groupOrderDetail.order_base.prod_id;
        product.relation_id = _groupOrderDetail.order_base.relation_id;
        groupPurchaseView.product = product;
        groupPurchaseView.action = prod_order;
        [self.navigationController pushViewController:groupPurchaseView animated:YES];
    }
}


-(void)ratingBarViewCancel:(RatingBarView *)ratingBarView
{
    [self.codeBlackView removeFromSuperview];
    [ratingBarView removeFromSuperview];
}


-(void)ratingBarView:(RatingBarView *)ratingBarView withEstimation:(NSString *)estimation comment:(NSString *)comment groupOrder:(TLGroupOrder *)groupOrder
{
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,evaluation_create_Url];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_groupOrderDetail.order_base.order_no,@"order_no",_groupOrderDetail.order_base.order_no,@"order_detail_no",_groupOrderDetail.order_base.prod_id,@"product_id",estimation,@"level",comment,@"memo", nil];
    NSMutableArray *temp = [NSMutableArray array];
    [temp addObject:dic];
    NSDictionary *dictjson = [NSDictionary dictionaryWithObjectsAndKeys:temp,@"rating_detail", nil];
    NSString *stringJson = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dictjson options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id, @"user_id",[TLPersonalMegTool currentPersonalMeg].token, TL_USER_TOKEN,stringJson,@"rating_detail_json", nil];
    __weak typeof(self) weakSelf = self;
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"评价成功"];
            [weakSelf.codeBlackView removeFromSuperview];
            [_ratingBarView removeFromSuperview];
            // 马上进入刷新状态
            [weakSelf loadData];
            
        });
    } failure:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)keyboardWillChangeFrame:(NSNotification *)note
{
    UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat transformY = keyboardFrame.origin.y - blackView.bounds.size.height/2-130;
    
    if (transformY<0) {
        [UIView animateWithDuration:duration animations:^{
            _ratingBarView.transform = CGAffineTransformMakeTranslation(0, transformY);
        }];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
