//
//  TLMoshopViewController.m
//  tongle
//
//  Created by liu ruibin on 15-5-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMoshopViewController.h"
#import "TLProdPurchaseViewController.h"
#import "TLPostDetailViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLProductCollectionViewCell.h"
#import "TLShopCollectionReusableViewHead.h"
#import "TLProductViewCell.h"
#import "UIBarButtonItem+TL.h"
#import "TLPersonalMegTool.h"
#import "TLHomepage_ads.h"
#import "TLMagicShop.h"
#import "TLPersonalMeg.h"
#import "TLMoshop.h"
#import "TLMoshopAd.h"
#import "TLProduct.h"
#import "JSONKit.h"
#import "TLQrdata.h"
#import "TLImageName.h"
#import "MJRefresh.h"
#import "Url.h"
#import "TLCommon.h"
#import "TLHttpTool.h"
#import "UIImageView+Image.h"
#import "MBProgressHUD+MJ.h"
#import "UIColor+TL.h"
#import "TLIntegrateDetailController.h"
#import "TLGroupPurchaseViewController.h"
#import "TLGroupCouponVoucher.h"


@interface TLMoshopViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) TLMoshop      *moshop;
@property (nonatomic,weak)   UIPageControl *pageControl;
@property (nonatomic,weak)   UIScrollView  *scrollView;
@property (nonatomic,strong) NSTimer       *timer;

@end

@implementation TLMoshopViewController


static NSString * const reuseIdentifier = @"TLProductCollectionViewCell";
static NSString * const findCollectionViewSectionHeaderIdentifier = @"TLShopCollectionReusableViewHead";
static int collectBool = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self TimeOn];
    [self AddRigthButton];
    [self loadData];
    self.collectionView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    [self.collectionView registerClass:[TLProductCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[TLShopCollectionReusableViewHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:findCollectionViewSectionHeaderIdentifier];

}

-(void)setData
{
    int back_Image_WH = 25;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, back_Image_WH, back_Image_WH);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
}
-(void)back
{
    if (self.qrdata == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)setMagicShop:(TLMagicShop *)magicShop
{
    _magicShop = magicShop;
    self.mstore_id = self.magicShop.mstore_id;
    self.navigationItem.title = self.magicShop.mstore_name;
}


-(void)setQrdata:(TLQrdata *)qrdata
{
    _qrdata = qrdata;
    self.mstore_id = self.qrdata.store_id;
}

-(void)setHomepageMagicShop:(TLHomepage_ads *)HomepageMagicShop
{
    _HomepageMagicShop = HomepageMagicShop;
    self.mstore_id = HomepageMagicShop.object_id;
}

-(void)setProd_mstore_id:(NSString *)prod_mstore_id
{
    _prod_mstore_id = prod_mstore_id;
    self.mstore_id = prod_mstore_id;
}

-(void)setGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    _groupCouponVoucher = groupCouponVoucher;
     self.mstore_id = groupCouponVoucher.voucher_link_info.link_id;
}


-(void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,mstores_show_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.mstore_id,@"mstore_id",self.token,TL_USER_TOKEN, nil];
    __unsafe_unretained __typeof(self)  weakself = self;
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        weakself.moshop = [[TLMoshop alloc]initWithDictionary:json[@"body"] error:nil];
        weakself.navigationItem.title = self.moshop.mstore_name;
        collectBool = [weakself.moshop.mstore_favorited_by_me intValue];
        [weakself selectImage];
        [weakself.collectionView reloadData];
    } failure:^(NSError *error) {
    }];
}

/**
 *  增加广告栏
 */
-(void)setupScrollView:(UIView *)view
{
    CGRect rect = [UIScreen mainScreen].bounds;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame =CGRectMake(0, 0, rect.size.width, TLAdHeight);
    scrollView.delegate = self;
    //添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    
    for (int index = 0; index < self.moshop.ad_list.count; index ++) {
        
        TLMoshopAd *ads = self.moshop.ad_list[index];
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImageWithURL:ads.ad_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickEventOnImage:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tapRecognizer];
        tapRecognizer.view.tag = index;
    }
    
    scrollView.contentSize = CGSizeMake(imageW*self.moshop.ad_list.count, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    [view addSubview:scrollView];
    self.scrollView.bounces = NO;
    
    
    
    UIView *groundBackView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), ScreenBounds.size.width, 25)];
    groundBackView.backgroundColor = [UIColor getColor:@"f4f4f4"];
    [view addSubview:groundBackView];
    
    UIButton *TipsButton = [[UIButton alloc]initWithFrame:CGRectMake(10,0, ScreenBounds.size.width-10, 25)];
    [TipsButton addTarget:self action:@selector(tipAction) forControlEvents:UIControlEventTouchUpInside];
    TipsButton.backgroundColor = [UIColor clearColor];
    [groundBackView addSubview:TipsButton];
    
    UILabel *vouchers = [[UILabel alloc]initWithFrame:TipsButton.bounds];
    [TipsButton addSubview:vouchers];
    vouchers.backgroundColor = [UIColor clearColor];
    vouchers.textColor = [UIColor getColor:@"ee0000"];
    vouchers.text = self.moshop.vouchers_text;
    vouchers.font = [UIFont systemFontOfSize:11];
    
    UILabel *list = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(groundBackView.frame)+10, 100, 12)];
    list.text = @"畅销榜";
    [view addSubview:list];
    [self setupPageControl:view];
    
}

-(void)tipAction
{
    TLIntegrateDetailController *integrateDetailController = [[TLIntegrateDetailController alloc]init];
    integrateDetailController.moshop = self.moshop;
    [self.navigationController pushViewController:integrateDetailController animated:YES];
}


-(void)ClickEventOnImage:(UITapGestureRecognizer *)tapRecognizer
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
    TLMoshopAd *ads = self.moshop.ad_list[tapRecognizer.view.tag];
    
    switch ([ads.promotion_mode intValue]) {
        case 0:
            [self ActivityWithProd:storyboard withHomepage:ads];
            break;
        case 1:
            [self ActivityWithPost:storyboard withHomepage:ads];
            break;
        case 3:
            [self ActivityWithMaster:storyboard withHomepage:ads];
            break;
        default:
            break;
    }
}


/**
 *  /活动商品
 *
 */
-(void)ActivityWithProd:(UIStoryboard *)storyboard withHomepage:(TLMoshopAd *)ad
{
    TLProdPurchaseViewController *prodPurchase = [storyboard instantiateViewControllerWithIdentifier:TL_PROD_PURCHASE];
    prodPurchase.ad = ad;
    [self.navigationController pushViewController:prodPurchase animated:YES];
}



/**
 *  /活动帖子
 *
 */
-(void)ActivityWithPost:(UIStoryboard *)storyboard withHomepage:(TLMoshopAd *)ad
{
    TLPostDetailViewController *postDetail = [storyboard instantiateViewControllerWithIdentifier:TL_POST_DETAIL];
    postDetail.ad = ad;
    [self.navigationController pushViewController:postDetail animated:YES];
}





/**
 *  /活动会员
 *
 */
-(void)ActivityWithMaster:(UIStoryboard *)storyboard withHomepage:(TLMoshopAd *)ad
{
    [[NSUserDefaults standardUserDefaults] setObject:linkMaster forKey:TL_ACTION];
    TLMasterSuperViewController *masterSuper = [storyboard instantiateViewControllerWithIdentifier:TL_MASTER_SUPER];
    masterSuper.ad = ad;
    [self.navigationController pushViewController:masterSuper animated:YES];
}


/**
 *  增加页码显示
 */
-(void)setupPageControl:(UIView *)view
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = self.moshop.ad_list.count;
    CGFloat centerX = view.frame.size.width * TL_PAGECONTROL_X;
    CGFloat centerY = self.scrollView.bounds.size.height-10;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, self.scrollView.bounds.size.width, 142);
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [view addSubview:pageControl];
    [view bringSubviewToFront:pageControl];
    self.pageControl = pageControl;
}

-(void)TimeOn
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(play) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)TimeOff
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)play
{
    int i = (int)self.pageControl.currentPage;
    
    if (i == self.moshop.ad_list.count-1) {
        i = -1;
    }
    i++;
    [self.scrollView setContentOffset:CGPointMake(i*self.scrollView.bounds.size.width, 0) animated:YES];
}





-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self TimeOff];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self TimeOn];
}

-(void)AddRigthButton
{
    UIBarButtonItem *rigthBtn = [UIBarButtonItem rigthButtonItemWithCollectBool:collectBool];
    self.collect = (UIButton *)[[rigthBtn customView] viewWithTag:100];
    [self.collect addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchDown];
    self.qrcode = (UIButton *)[[rigthBtn customView] viewWithTag:101];
    [self.qrcode addTarget:self action:@selector(qrcode:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.rightBarButtonItem = rigthBtn;
    
}

-(void)collect:(UIButton *)btn
{
    __unsafe_unretained __typeof(self)  weakself = self;
    if (collectBool) {
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,add_Url];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:TL_COLLECT_TYPE_SHOP,@"collection_type",self.mstore_id,@"key_value",nil];
        NSMutableArray *temp = [NSMutableArray array];
        [temp addObject:dict];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",temp,@"favorites_list_json",self.token,TL_USER_TOKEN, nil];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            collectBool = 0;
            [weakself selectImage];
            [MBProgressHUD showSuccess:TL_COLLECT_SUCCESS];

        } failure:nil];
    }else
    {
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,remove_Url];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.mstore_id,@"key_value",TL_COLLECT_TYPE_SHOP,@"collection_type",self.token,TL_USER_TOKEN, nil];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            collectBool = 1;
            [weakself selectImage];
            [MBProgressHUD showSuccess:TL_COLLECT_CANCEL_SUCCESS];
        } failure:nil];
        
    }
}

-(void)selectImage
{
    NSString *image = collectBool==0? TL_COLLECT_COLLECT : TL_COLLECT__NORMAL;
    [self.collect setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}
-(void)qrcode:(UIButton *)btn
{
    self.qrcode.enabled = NO;
    UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = blackView.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    [blackView addSubview:cover];
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,mstore_show_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.mstore_id, @"mstore_id" ,nil];
    __unsafe_unretained __typeof(self)  weakself = self;
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {

        UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:BARCODE_BG]];
        [blackView addSubview:backImage];
        weakself.backImage = backImage;
        backImage.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
        
        UIImageView *qrcode = [[UIImageView alloc]init];
      
        [qrcode setImageWithURL:json[@"body"][@"mstore_qr_code_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        qrcode.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
        [blackView addSubview:qrcode];
        weakself.qrcodeImage = qrcode;
        [blackView bringSubviewToFront:qrcode];
        
        [UIView animateWithDuration:0.25 animations:^{
            cover.alpha = 0.5;
            CGFloat iconWH = TL_QRCODE_WH;
    
            CGFloat iconX = (blackView.frame.size.width - iconWH)/2;
            CGFloat iconY = (blackView.frame.size.height - iconWH)/2;
            qrcode.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
            
            backImage.bounds = CGRectMake(0, 0, ScreenBounds.size.width-20, ScreenBounds.size.width-20);
            backImage.center = qrcode.center;
        }];
        
        
    } failure:nil];

}

-(void)smallimg
{
    __unsafe_unretained __typeof(self)  weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakself.cover removeFromSuperview];
        [weakself.qrcodeImage removeFromSuperview];
        [weakself.backImage removeFromSuperview];
        weakself.cover = nil;
        weakself.collect.alpha = 1;
        weakself.collect.enabled = YES;
        weakself.qrcode.alpha = 1;
        weakself.qrcode.enabled = YES;
    }];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentX = scrollView.contentOffset.x;
    self.scrollView.contentSize = CGSizeMake(self.moshop.ad_list.count*self.scrollView.bounds.size.width, 0);
    double DoublePage = currentX/scrollView.bounds.size.width;
    int pageInt = (int)(DoublePage + 0.5);
    self.pageControl.currentPage = pageInt;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil)
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;
        // Dispose of any resources that can be recreated.
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.moshop.prod_list.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    TLProduct *product = self.moshop.prod_list[indexPath.row];
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
    TLProduct *product = self.moshop.prod_list[indexPath.row];
    if ([product.coupon_flag isEqualToString:TLYES]) {
        TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
        groupPurchaseView.product = product;
        groupPurchaseView.action = prod_mstore;
        [self.navigationController pushViewController:groupPurchaseView animated:YES];
    }else
    {
         [self performSegueWithIdentifier:TL_NOSHOP_PRODUCT sender:product];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
      TLShopCollectionReusableViewHead *shopCollectionReusableViewHead = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:findCollectionViewSectionHeaderIdentifier forIndexPath:indexPath];
    
    
    if (kind == UICollectionElementKindSectionHeader){
        [self setupScrollView:shopCollectionReusableViewHead];
    }
    shopCollectionReusableViewHead.backgroundColor = [UIColor whiteColor];
    return shopCollectionReusableViewHead;
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 250);
}


//跳转传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLProdPurchaseViewController class]])
    {
        TLProdPurchaseViewController *prodPurchase = vc;
        prodPurchase.mstoreproduct = sender;
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row==0) {
//        return 230;
//    }else
//    {
//        return 100;
//    }
//}

@end
