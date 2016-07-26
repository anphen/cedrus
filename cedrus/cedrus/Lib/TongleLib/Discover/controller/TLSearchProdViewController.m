//
//  TLSearchProdViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-24.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSearchProdViewController.h"
//#import "TLProductViewCell.h"
#import "TLProduct.h"
#import "TLCommon.h"
#import "TLProductCollectionViewCell.h"
#import "UIColor+TL.h"
#import "TLGroupPurchaseViewController.h"

@interface TLSearchProdViewController ()

@end

@implementation TLSearchProdViewController


static NSString * const reuseIdentifier = @"TLProductCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.collectionView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[TLProductCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

}

-(void)dismissKeyBoard
{
    [self.parentViewController.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.prod_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TLProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    TLProduct *product = self.prod_list[indexPath.row];
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TLProduct *product = self.prod_list[indexPath.row];
    if ([product.coupon_flag isEqualToString:TLYES]) {
        TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
        groupPurchaseView.product = product;
        groupPurchaseView.action = prod_hot;
        [self.navigationController pushViewController:groupPurchaseView animated:YES];
    }else
    {
        [self.parentViewController performSegueWithIdentifier:TL_FIND_PROD sender:product];
    }

}



@end
