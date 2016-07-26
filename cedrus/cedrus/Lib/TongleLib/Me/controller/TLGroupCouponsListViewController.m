//
//  TLGroupCouponsViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/17.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupCouponsListViewController.h"
#import "TLImageName.h"
#import "UIColor+TL.h"
#import "TLGroupOrderListViewController.h"
#import "TLGroupCouponsListRequest.h"
#import "TLGroupCouponsList.h"
#import "TLGroupCouponsListViewCell.h"
#import "TLGroupCouponsDetailViewController.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "UIImageView+Image.h"
#import "MJRefresh.h"

@interface TLGroupCouponsListViewController ()<TLGroupCouponsListViewCellDelegate>

@property (nonatomic,strong) TLGroupCouponsList *groupCouponsList;
@property (strong,nonatomic) NSMutableArray *typeArray;//cell状态
@property (nonatomic,strong) NSMutableArray *couponsArray;
@property (nonatomic,weak) UIButton *cover;
@property (nonatomic,weak) UIImageView *qrcodeImage;
@property (nonatomic,weak) UIView *codeBlackView;
@property (nonatomic,copy) NSString *upDown;
@end

@implementation TLGroupCouponsListViewController


-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"我的团购券";
    [self initNavigationBar];
    [self RefreshControl];
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
    [rightButton addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"团购订单" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor getColor:@"999999"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
/**
 *  重写返回按钮
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self RefreshControl];
//}


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
    self.upDown = PAGEDOWN;
    [self loadData];
}

-(void)footerRefresh
{
    self.upDown = PAGEUP;
    [self loadData];
}


-(NSMutableArray *)typeArray
{
    if (_typeArray == nil) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}

-(NSMutableArray *)couponsArray
{
    if (_couponsArray == nil) {
        _couponsArray = [NSMutableArray array];
    }
    return _couponsArray;
}


-(void)loadData
{
    TLGroupCouponsListRequest *groupCouponsListRequest = [[TLGroupCouponsListRequest alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,groupCouponsListRequest.user_token,gp_coupons_Url];
    if (self.couponsArray.count)
    {
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            groupCouponsListRequest.order_no = @"";
            groupCouponsListRequest.out_of_date = @"";
            groupCouponsListRequest.fetch_count = DownAmount;
        }else
        {
            TLGroupCoupons *groupCoupons = self.couponsArray.lastObject;
            groupCouponsListRequest.order_no = groupCoupons.order_no;
            groupCouponsListRequest.out_of_date = groupCoupons.out_of_date;
            groupCouponsListRequest.fetch_count = UpAmount;
        }
    }
    __weak typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:groupCouponsListRequest success:^(id result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            TLGroupCouponsList *groupCouponsList = result;
            
            if ([weakSelf.upDown isEqualToString:PAGEDOWN]) {
                [weakSelf.couponsArray removeAllObjects];
                [weakSelf.typeArray removeAllObjects];
                for (TLGroupCoupons *groupCoupons in groupCouponsList.coupon_list) {
                    [weakSelf.couponsArray addObject:groupCoupons];
                    if (groupCoupons.coupon_code_list.count>2) {
                        [weakSelf.typeArray addObject:@1];
                    }else{
                        [weakSelf.typeArray addObject:@0];
                    }
                }
                [weakSelf.tableView.mj_header endRefreshing];
            }else
            {
                for (TLGroupCoupons *groupCoupons in groupCouponsList.coupon_list) {
                    [weakSelf.couponsArray addObject:groupCoupons];
                    if (groupCoupons.coupon_code_list.count>2) {
                        [weakSelf.typeArray addObject:@1];
                    }else{
                        [weakSelf.typeArray addObject:@0];
                    }
                }
                [weakSelf.tableView.mj_footer endRefreshing];
            }
             [weakSelf.tableView reloadData];
        });
    } failure:^(NSError *error)
     {
         if ([weakSelf.upDown isEqualToString:PAGEDOWN])
         {
             [weakSelf.tableView.mj_header endRefreshing];
         }else
         {
             [weakSelf.tableView.mj_footer endRefreshing];
         }
     }resultClass:[TLGroupCouponsList class]];
}



-(void)order:(UIButton *)button
{
    TLGroupOrderListViewController *groupOrderListView = [[TLGroupOrderListViewController alloc]init];
    [self.navigationController pushViewController:groupOrderListView animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.couponsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TLGroupCouponsListViewCell *cell = [TLGroupCouponsListViewCell cellWithTableview:tableView indexPath:indexPath];
    cell.delegate = self;
    NSInteger i=[_typeArray[indexPath.section] intValue];
    cell.backgroundColor = [UIColor getColor:@"f4f4f4"];
    TLGroupCoupons *groupCoupons = self.couponsArray[indexPath.row];
    cell.groupCoupons  = groupCoupons;
    cell.showType = _typeArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self)weakSelf=self;
    cell.showCellBlock=^{
        switch (i) {
            case 1:
                [weakSelf.typeArray replaceObjectAtIndex:indexPath.row withObject:@2];
                break;
            case 2:
                [weakSelf.typeArray replaceObjectAtIndex:indexPath.row withObject:@1];
                break;
            default:
                break;
        }
        //[weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [weakSelf.tableView reloadData];
    };
    __block NSString *coupon_2d_qrcode_url = groupCoupons.coupon_codeurl_info.coupon_2d_qrcode_url;
    __block NSString *coupon_1d_qrcode_url = groupCoupons.coupon_codeurl_info.coupon_1d_qrcode_url;
    cell.showCellCodeBlock = ^{
        [weakSelf qrcodeWithurl1:coupon_1d_qrcode_url url2:coupon_2d_qrcode_url];
    };
    return cell;
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



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    unsigned long height=0;
    NSInteger i=[self.typeArray[indexPath.row] intValue];
    TLGroupCoupons *groupCoupons = self.couponsArray[indexPath.row];
    NSArray *numbers= groupCoupons.coupon_code_list;
    switch (i) {
        case 0:
            height= 50+numbers.count*37;
            break;
        case 1:
            height= 37*2+90;
            break;
        case 2:
            height= 50+numbers.count*37+40;
            break;
        default:
            NSLog(@"cell高度出现错误，请检查");
            break;
    }
    return height;

}

-(void)groupCouponsListViewCell:(TLGroupCouponsListViewCell *)groupCouponsListViewCell withCoupon:(TLGroupCouponCode *)couponCode withTLGroupCoupons:(TLGroupCoupons *)groupCoupons
{
    TLGroupCouponsDetailViewController *groupCouponsDetailView = [[TLGroupCouponsDetailViewController alloc]init];
    groupCouponsDetailView.groupCoupons = groupCoupons;
    groupCouponsDetailView.groupCouponCode = couponCode;
    [self.navigationController pushViewController:groupCouponsDetailView animated:YES];
}


@end
