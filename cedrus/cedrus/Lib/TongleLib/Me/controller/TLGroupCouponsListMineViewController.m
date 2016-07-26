//
//  TLGroupCouponsListMineViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupCouponsListMineViewController.h"
#import "TLProdPurchaseViewController.h"
#import "TLPostDetailViewController.h"
#import "TLMoshopViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLIntegrateDetailController.h"
#import "TLGroupCouponMyViewCell.h"
#import "TLGroupCouponVoucherAll.h"
#import "TLImageName.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLHttpTool.h"
#import "UIColor+TL.h"
#import "Url.h"
#import "TLCommon.h"


@interface TLGroupCouponsListMineViewController ()

@property (nonatomic,strong) TLGroupCouponVoucherAll *groupCouponVoucherAll;

@end

@implementation TLGroupCouponsListMineViewController

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
    self.tableView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    self.tableView.rowHeight = 102;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
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
    self.navigationItem.title = @"我的优惠券";
}
/**
 *  重写返回按钮
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,orders_my_vouchers_info_Url];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,@"user_token",nil];
    
    [TLHttpTool postWithURL:url params:dict success:^(id json) {
        TLGroupCouponVoucherAll *groupCouponVoucherAll = [[TLGroupCouponVoucherAll alloc]initWithDictionary:json[@"body"] error:nil];
        _groupCouponVoucherAll = groupCouponVoucherAll;
        [self.tableView reloadData];
    } failure:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _groupCouponVoucherAll.voucher.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLGroupCouponMyViewCell *cell = [TLGroupCouponMyViewCell cellWithTableView:tableView];
    TLGroupCouponVoucher *groupCouponVoucher = _groupCouponVoucherAll.voucher[indexPath.section];
    cell.groupCouponVoucher = groupCouponVoucher;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    cell.actionblock = ^{
        [weakSelf actionShop:groupCouponVoucher];
    };
    return cell;
}


-(void)actionShop:(TLGroupCouponVoucher *)groupCouponVoucher
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
    
    // need check the select content related_type & object_id
    if ([groupCouponVoucher.voucher_link_info.link_type length]) {
        switch ([groupCouponVoucher.voucher_link_info.link_type intValue]) {
            case 0:
                [self ActivityWithProd:storyboard withGroupCouponVoucher:groupCouponVoucher];
                break;
            case 1:
                [self ActivityWithPost:storyboard withGroupCouponVoucher:groupCouponVoucher];
                break;
            case 2:
                [self ActivityWithShop:storyboard withGroupCouponVoucher:groupCouponVoucher];
                break;
            case 3:
                [self ActivityWithMaster:storyboard withGroupCouponVoucher:groupCouponVoucher];
                break;
            case 4:
            {
               self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:TLBASETABA];
            }
                break;
            case 5:
            {
                [self ActivityWithH5:storyboard withGroupCouponVoucher:groupCouponVoucher];
            }
                break;
            default:
                break;
        }
    }
}

/**
 *  /活动商品
 *
 */
-(void)ActivityWithProd:(UIStoryboard *)storyboard withGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
        TLProdPurchaseViewController *prodPurchase = [storyboard instantiateViewControllerWithIdentifier:TL_PROD_PURCHASE];
        prodPurchase.groupCouponVoucher = groupCouponVoucher;
        [self.navigationController pushViewController:prodPurchase animated:YES];
}

/**
 *  /活动帖子
 *
 */
-(void)ActivityWithPost:(UIStoryboard *)storyboard withGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    TLPostDetailViewController *postDetail = [storyboard instantiateViewControllerWithIdentifier:TL_POST_DETAIL];
    postDetail.groupCouponVoucher = groupCouponVoucher;
    [self.navigationController pushViewController:postDetail animated:YES];
}

/**
 *
 * //活动魔店
 */
-(void)ActivityWithShop:(UIStoryboard *)storyboard withGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    TLMoshopViewController *MoshopView = [storyboard instantiateViewControllerWithIdentifier:TL_MOSHOP];
    MoshopView.groupCouponVoucher = groupCouponVoucher;
    [self.navigationController pushViewController:MoshopView animated:YES];
}

/**
 *  /活动会员
 *
 */
-(void)ActivityWithMaster:(UIStoryboard *)storyboard withGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    [[NSUserDefaults standardUserDefaults] setObject:linkMaster forKey:TL_ACTION];
    TLMasterSuperViewController *masterSuper = [storyboard instantiateViewControllerWithIdentifier:TL_MASTER_SUPER];
    masterSuper.groupCouponVoucher = groupCouponVoucher;
    [self.navigationController pushViewController:masterSuper animated:YES];
}

/**
 *  /H5
 *
 */
-(void)ActivityWithH5:(UIStoryboard *)storyboard withGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    TLIntegrateDetailController *integrateDetailController = [[TLIntegrateDetailController alloc]init];
    integrateDetailController.Title = groupCouponVoucher.voucher_link_info.title;
    integrateDetailController.url = groupCouponVoucher.voucher_link_info.link_id;
    [self.navigationController pushViewController:integrateDetailController animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 15)];
    header.backgroundColor = [UIColor getColor:@"f4f4f4"];
    return header;
}


@end
