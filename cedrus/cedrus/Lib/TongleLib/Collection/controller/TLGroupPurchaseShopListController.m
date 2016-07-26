//
//  TLGroupPurchaseShopListController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/7.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupPurchaseShopListController.h"
#import "TLGroupPurchaseShopViewList.h"
#import "UIColor+TL.h"
#import "TLImageName.h"
#import "TLGroupCouponStoreInfo.h"
#import "TLGroupShopListRequest.h"
#import "TLGroupProductDetail.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "TLGroupCouponStoreInfoSuper.h"
#import "MJRefresh.h"
#import "TLGroupShopsListFooterViewCell.h"

@interface TLGroupPurchaseShopListController ()

@property (nonatomic,copy) NSString *upDown;
@property (nonatomic,strong) NSMutableArray *storeArray;
@property (nonatomic,assign) CGFloat height;

@end


@implementation TLGroupPurchaseShopListController

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"商户列表";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
/**
 *  重写返回按钮
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
    self.upDown = PAGEDOWN;
     [self loadShopList];
}

-(void)footerRefresh
{
    self.upDown = PAGEUP;
     [self loadShopList];
}


-(void)setGroupProductDetail:(TLGroupProductDetail *)groupProductDetail
{
    _groupProductDetail = groupProductDetail;
    _prod_id = _groupProductDetail.prod_base_info.prod_id;
}

-(void)setProd_id:(NSString *)prod_id
{
    _prod_id = prod_id;
}

-(NSMutableArray *)storeArray
{
    if (_storeArray == nil) {
        _storeArray = [NSMutableArray array];
    }
    return _storeArray;
}

-(void)loadShopList
{
    TLGroupShopListRequest *groupShopListRequest = [[TLGroupShopListRequest alloc]init];
    groupShopListRequest.product_id = _prod_id;
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,groupShopListRequest.user_token,shop_list_show_Url];
    
    if (self.storeArray.count)
    {
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            groupShopListRequest.code = @"";
            groupShopListRequest.fetch_count = DownAmount;
        }else
        {
            TLGroupStoreList *groupStore = self.storeArray.lastObject;
            groupShopListRequest.code = groupStore.code;
            groupShopListRequest.fetch_count = UpAmount;
        }
    }
     __unsafe_unretained __typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:groupShopListRequest success:^(id result) {
        TLGroupCouponStoreInfoSuper *groupCouponStoreInfoSuper = result;
        
        if ([weakSelf.upDown isEqualToString:PAGEDOWN]) {
            [weakSelf.storeArray removeAllObjects];
            for (TLGroupStoreList *groupStore in groupCouponStoreInfoSuper.coupon_store_info.store_list) {
                [weakSelf.storeArray addObject:groupStore];
            }
            [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
            for (TLGroupStoreList *groupStore in groupCouponStoreInfoSuper.coupon_store_info.store_list) {
                [weakSelf.storeArray addObject:groupStore];
            }
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error)
     {
         if ([weakSelf.upDown isEqualToString:PAGEDOWN])
         {
             [weakSelf.tableView.mj_header endRefreshing];
         }else
         {
             [weakSelf.tableView.mj_footer endRefreshing];
         }
     }resultClass:[TLGroupCouponStoreInfoSuper class]];
}
    
    
    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _storeArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TLGroupStoreList *groupStore =  _storeArray[indexPath.section];

    if (indexPath.row == 0) {
        TLGroupPurchaseShopViewList *cell = [TLGroupPurchaseShopViewList cellWithTableView:tableView];
        cell.groupStore = groupStore;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        
        
        TLGroupShopsListFooterViewCell *cell = [TLGroupShopsListFooterViewCell cellWithTableCell:tableView];
        cell.groupStore = groupStore;
        _height = cell.height;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 95;
    }else
    {
        return  _height;
    }
    return 20;
}



//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    TLGroupStoreList *groupStore = _storeArray[indexPath.section];
//    if (indexPath.row == 2) {
//        NSString *str = [NSString stringWithFormat:@"tel:%@",groupStore.phone];
//        UIWebView *callWebView = [[UIWebView alloc]init];
//        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//        [self.tableView addSubview:callWebView];
//    }
//}




@end
