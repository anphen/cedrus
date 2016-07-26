//
//  TLProdCollectionViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/1/4.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLProdCollectionViewController.h"
#import "TLProductCollectionViewCell.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "TLProduct.h"
#import "TLProductRequest.h"
#import "TLProductViewCell.h"
#import "TLProductAll.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "MJRefresh.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "TLGroupPurchaseViewController.h"

@interface TLProdCollectionViewController ()


@property (nonatomic,strong)    NSMutableArray  *productArray;
@property (nonatomic,strong)    TLProductAll    *productAll;
@property (nonatomic,copy)      NSString        *UpDown;


@end

@implementation TLProdCollectionViewController

static NSString * const reuseIdentifier = @"TLProductCollectionViewCell";





- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor getColor:@"f4f4f4"];

    [self.collectionView registerClass:[TLProductCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self RefreshControl];
}


-(NSMutableArray *)productArray
{
    if (_productArray == nil) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}


-(void)RefreshControl
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerRefresh];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footerRefresh];
    }];
    // 马上进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    
}

-(void)headerRefresh
{
    self.UpDown= PAGEDOWN;
    [self loadProduct];
}

-(void)footerRefresh
{
    self.UpDown = PAGEUP;
    [self loadProduct];
}


-(void)loadProduct
{
    self.url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_products_Url];
    
    TLProductRequest *request = [[TLProductRequest alloc]init];
    if (self.productArray.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            request.prod_id= @"";
            request.fetch_count = DownAmount;
        }else
        {
            TLProduct *prod = self.productArray[self.productArray.count-1];
            request.prod_id = prod.prod_id;
            request.fetch_count = UpAmount;
        }
    }
    
     __unsafe_unretained __typeof(self) weakself = self;
    [TLBaseTool postWithURL:self.url param:request success:^(id result) {
        weakself.productAll = result;
        if ([weakself.UpDown isEqualToString:PAGEDOWN]) {
            [weakself.productArray removeAllObjects];
            for (TLProduct *prod in self.productAll.prod_list) {
                [weakself.productArray addObject:prod];
            }
             [weakself.collectionView.mj_header endRefreshing];
        }else
        {
            [weakself.productArray addObjectsFromArray:self.productAll.prod_list];
            [weakself.collectionView.mj_footer endRefreshing];
        }
        [weakself.collectionView reloadData];
    } failure:^(NSError *error) {
        if ([weakself.UpDown isEqualToString:PAGEDOWN])
        {
            [weakself.collectionView.mj_header endRefreshing];
        }else
        {
             [weakself.collectionView.mj_footer endRefreshing];
        }
    } resultClass:[TLProductAll class]];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TLProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    TLProduct *product = self.productArray[indexPath.row];
    cell.product = product;
    return cell;
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenBounds.size.width-20)/2, (ScreenBounds.size.width-20)/2+60);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 0, 5);
}
#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLProduct *product = self.productArray[indexPath.row];
    if ([product.coupon_flag isEqualToString:TLYES]) {
        TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
        groupPurchaseView.product = product;
        groupPurchaseView.action = prod_collect;
        [self.navigationController pushViewController:groupPurchaseView animated:YES];
    }else
    {
       [self.parentViewController performSegueWithIdentifier:TL_PROD_PURCHASE sender:product];
    }
}


@end
