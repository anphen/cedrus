//
//  TLGroupPurchaseViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/1.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupPurchaseViewController.h"
#import "UIBarButtonItem+TL.h"
#import "TLImageName.h"
#import "TLGroupPurchaseViewShopView.h"
#import "TLCommon.h"
#import "TLGroupPurchaseShopView.h"
#import "TLGroupPurchaseShopListController.h"
#import "TLGroupShopSubmitOrderViewController.h"
#import "TLGroupProductDetail.h"
#import "TLGroupProdDetailView.h"
#import "TLGroupProdPruchaseNoticeView.h"
#import "TLGroupCouponStoreInfo.h"
#import "TLProduct.h"
#import "TLBaseTool.h"
#import "TLGroupProductDetailRequest.h"
#import "Url.h"
#import "UIColor+TL.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "UIImageView+Image.h"
#import "TLShareView.h"
#import "TLProdCollectView.h"
#import "MBProgressHUD+MJ.h"
#import "TLProdDetailsMeg.h"
#import "TLProdMessageViewController.h"
#import "TLLandViewController.h"
#import "UIApplication+ActivityViewController.h"

@interface TLGroupPurchaseViewController ()<TLGroupPurchaseShopViewDelegate,TLShareViewDelegate,TLProdCollectViewDelegate,UIScrollViewDelegate,TLProdMessageViewControllerDelegate>

@property (nonatomic,weak)   UIButton       *collect;
@property (nonatomic,weak)   UIButton       *qrcode;
@property (nonatomic,weak)   UIScrollView   *scrollView;
@property (nonatomic,weak)   UIScrollView   *scrollViewHead;
@property (nonatomic,weak)   UIPageControl  *pageControll;
@property (nonatomic,weak) TLGroupPurchaseViewShopView *groupPurchaseViewShopView;
@property (nonatomic,weak) TLGroupPurchaseShopView *groupPurchaseShopView;
@property (nonatomic,weak) TLGroupProdDetailView  *groupProdDetailView;
@property (nonatomic,weak) TLGroupProdPruchaseNoticeView  *groupProdPruchaseNoticeView;
@property (nonatomic,weak)  TLProdCollectView   *prodCollectView;
@property (nonatomic,strong) TLGroupProductDetail *groupProductDetail;
@property (nonatomic,strong) TLGroupProductDetailRequest *gpProductDetailRequest;
@property (nonatomic,weak)   TLShareView         *shareView;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,weak) UILabel *moneySign;
@property (nonatomic,weak) UILabel *price;
@property (nonatomic,weak) UILabel *showPrice;
@property (nonatomic,weak) UIButton *sumbitBtn;
@property (nonatomic,weak) UIButton *cover;
@property (nonatomic,weak) UIImageView *backImage;
@property (nonatomic,weak) UIImageView *qrcodeImage;

@end


static int collectBool = 1;
static int collect = 0;


@implementation TLGroupPurchaseViewController


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.navigationItem.title = @"商品详情";
        self.view.backgroundColor = [UIColor whiteColor];
        //self.scrollView.bounces = NO;
    }
    return self;
}



-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self setBaseView];

}



-(void)setProduct:(TLProduct *)product
{
    _product = product;
}

-(void)setAction:(NSString *)action
{
    _action = action;
    [self loadGpProductData];
}


-(void)loadGpProductData
{

    TLGroupProductDetailRequest *gpProductDetailRequest = [[TLGroupProductDetailRequest alloc]init];
    gpProductDetailRequest.product_id = _product.prod_id;
    gpProductDetailRequest.post_id = _product.post_id;
    gpProductDetailRequest.action = _action;
    gpProductDetailRequest.mstore_id = _product.mstore_id;
    gpProductDetailRequest.relation_id = _product.relation_id;
    _gpProductDetailRequest = gpProductDetailRequest;
    //发送请求
    if (!_product.prod_id.length) {
        self.collect.enabled = NO;
        self.qrcode.enabled = NO;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,gpProductDetailRequest.user_token,gp_product_show_Url];
    
    __unsafe_unretained __typeof(self) weakself = self;
    [TLBaseTool postWithURL:url param:gpProductDetailRequest success:^(id result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            TLGroupProductDetail *groupProductDetail = result;
            _groupProductDetail = groupProductDetail;
            collectBool = [groupProductDetail.prod_base_info.prod_favorited_by_me intValue];
            if (groupProductDetail.prod_base_info.prod_id.length) {
                weakself.collect.enabled = YES;
                weakself.qrcode.enabled = YES;
            }
            [weakself createSubview];
        });
    } failure:^(NSError *error) {
        weakself.collect.enabled = NO;
        weakself.qrcode.enabled = NO;
    } resultClass:[TLGroupProductDetail class]];
}


-(void)createSubview
{
    [self selectImage];
    [self creatGroupPurchaseView];
    [self setUpPageControl];
    [self createShop];
    [self setGroupProdDetailView];
    [self setGroupProdPruchaseNoticeView];
    [self setFooterView];
    [self timeOn];
}

-(void)selectImage
{
    NSString *image = collectBool==0?  TL_COLLECT_COLLECT : TL_COLLECT__NORMAL;
    [self.collect setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

-(void)setBaseView
{
    [self setNavigationItem];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height-55.8)];
    scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    UILabel *moneySign = [[UILabel alloc]init];
    moneySign.font = [UIFont systemFontOfSize:15];
    moneySign.text = @"¥";
    moneySign.textColor = [UIColor getColor:@"ff6937"];
    [self.view  addSubview:moneySign];
    _moneySign = moneySign;
    
    
    UILabel *price = [[UILabel alloc]init];
    price.font = [UIFont systemFontOfSize:30];
    price.textColor = [UIColor getColor:@"ff6937"];
    [self.view  addSubview:price];
    _price = price;
    
    UILabel *showPrice = [[UILabel alloc]init];
    showPrice.font = [UIFont systemFontOfSize:15];
    showPrice.textColor = [UIColor getColor:@"c3c3c3"];
    [self.view  addSubview:showPrice];
    _showPrice = showPrice;
    
    UIButton *sumbitBtn = [[UIButton alloc]init];
    [sumbitBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [sumbitBtn setBackgroundImage:[UIImage imageNamed:TL_BTN_LIJIQIANGGOU_NOR] forState:UIControlStateNormal];
    [sumbitBtn setBackgroundImage:[UIImage imageNamed:TL_BTN_LIJIQIANGGOU_DOWN] forState:UIControlStateHighlighted];
    [sumbitBtn setBackgroundImage:[UIImage imageNamed:TL_BTN_LIJIQIANGGOU_DIS] forState:UIControlStateDisabled];

    [sumbitBtn addTarget:self action:@selector(sumbit:) forControlEvents:UIControlEventTouchUpInside];
    sumbitBtn.backgroundColor = [UIColor greenColor];
    [self.view  addSubview:sumbitBtn];
    _sumbitBtn = sumbitBtn;
}


-(void)sumbit:(UIButton *)button
{
    if ([[TLPersonalMegTool currentPersonalMeg].user_type isEqualToString:TL_USER_TOURIST]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
        TLLandViewController *landController = [storyBoard instantiateViewControllerWithIdentifier:@"land"];
        landController.backType = TLYES;
        landController.headtitle = @"登录";
        landController.hide = @"隐藏";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"auto_login"];
        [[[UIApplication sharedApplication] activityViewController].navigationController pushViewController:landController animated:YES];
    }else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Tongle_Base" bundle:nil];
        TLGroupShopSubmitOrderViewController *groupShopSubmitOrderView = [storyboard instantiateViewControllerWithIdentifier:@"groupShopSubmitOrderViewController"];
        groupShopSubmitOrderView.groupProductDetail = _groupProductDetail;
        [self.navigationController pushViewController:groupShopSubmitOrderView animated:YES];
    }
}


-(void)setNavigationItem
{
    
    int back_Image_WH = 25;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, back_Image_WH, back_Image_WH);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    UIBarButtonItem *rigthBtn = [UIBarButtonItem rigthButtonItemWithCollectBool:collectBool];
    self.collect = (UIButton *)[[rigthBtn customView] viewWithTag:100];
    [self.collect addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchDown];
    self.qrcode = (UIButton *)[[rigthBtn customView] viewWithTag:101];
    [self.qrcode addTarget:self action:@selector(qrcode:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = rigthBtn;
}

-(void)creatGroupPurchaseView
{
    TLGroupPurchaseViewShopView *groupPurchaseViewShopView = [[TLGroupPurchaseViewShopView alloc]init];
    groupPurchaseViewShopView.groupProductDetail = self.groupProductDetail;
    __unsafe_unretained __typeof(self) weakself = self;
    groupPurchaseViewShopView.productDetailBlack = ^{
         [weakself productMessageWithType:@"图文详情"];
    };
    groupPurchaseViewShopView.productEvaluateBlack = ^{
        [weakself productMessageWithType:@"产品评价"];
    };
    
    groupPurchaseViewShopView.productShareBlack = ^{
        UIButton *cover = [[UIButton alloc]init];
        cover.frame = ScreenBounds;
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.0;
        [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
        weakself.cover = cover;
        [weakself.view addSubview:cover];
        
        [weakself createShareView];
        [UIView animateWithDuration:0.25 animations:^{
            cover.alpha = 0.5;
            //  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"collect__normal" ] forBarMetrics:UIBarMetricsCompact];
            weakself.collect.alpha = 0.5;
            weakself.collect.enabled = NO;
            weakself.qrcode.alpha = 0.5;
            weakself.qrcode.enabled = NO;
            weakself.shareView.frame = CGRectMake(20, 100, ScreenBounds.size.width-40, weakself.shareView.height+10);
        }];
    };

    _groupPurchaseViewShopView = groupPurchaseViewShopView;
    self.scrollViewHead = groupPurchaseViewShopView.prodImage;
    self.scrollViewHead.delegate = self;
    groupPurchaseViewShopView.frame =  CGRectMake(0, 0, self.scrollView.frame.size.width, groupPurchaseViewShopView.height) ;

    [self.scrollView addSubview:groupPurchaseViewShopView];
}

-(void)productMessageWithType:(NSString *)type
{
    TLProdDetailsMeg  *prodDetailsMeg = [[TLProdDetailsMeg alloc]init];
    prodDetailsMeg.prod_info.prod_favorited_by_me  = [NSString stringWithFormat:@"%d",collectBool];
    [[NSUserDefaults standardUserDefaults] setObject:_groupProductDetail.prod_base_info.prod_id forKey:TL_PROD_DETAILS_PROD_ID];
    prodDetailsMeg.prod_info.prod_id = _groupProductDetail.prod_base_info.prod_id;
    prodDetailsMeg.prod_info.relation_id = _groupProductDetail.prod_base_info.relation_id;
    TLProdMessageViewController *prodMessageViewController = [[UIStoryboard storyboardWithName:STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:@"prodMessageViewController"];
    prodMessageViewController.delegate = self;
    prodMessageViewController.prodDetails = prodDetailsMeg.prod_info;
    prodMessageViewController.type = type;
    prodMessageViewController.prodType = @"1";
    [self.navigationController pushViewController:prodMessageViewController animated:YES];
}



-(void)prodMessageViewController:(TLProdMessageViewController *)prodMessageViewController withProdDetails:(TLProdDetails *)prodDetails
{
    collectBool = [prodDetails.prod_favorited_by_me intValue];
    [self selectImage];
}


/**
 *  增加页码显示
 */

-(void)setUpPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.hidesForSinglePage = YES;
    pageControl.bounds = CGRectMake(0, 0, ScreenBounds.size.width/2, 20);
    pageControl.numberOfPages = self.groupProductDetail.prod_base_info.prod_pic_url_list.count;
    pageControl.center = CGPointMake(ScreenBounds.size.width/2, self.scrollViewHead.bounds.size.height -10);
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.scrollView addSubview:pageControl];
    [self.scrollView bringSubviewToFront:pageControl];
    self.pageControll = pageControl;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentPoint = scrollView.contentOffset.x;
    double Double = currentPoint/self.scrollViewHead.bounds.size.width;
    _pageControll.currentPage = (int)(Double + 0.5);
}

-(void)timeOn
{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(play) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)timeoff
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)play
{
    int i = (int)self.pageControll.currentPage;
    if (i == self.groupProductDetail.prod_base_info.prod_pic_url_list.count-1) {
        i = -1;
    }
    i++;
    [self.scrollViewHead setContentOffset:CGPointMake(i*self.scrollViewHead.bounds.size.width, 0) animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self timeoff];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self timeOn];
}




-(void)createShareView
{
    TLShareView *shareView = [TLShareView share];
    
    shareView.frame = CGRectMake(ScreenBounds.size.width/2, ScreenBounds.size.height/2, 10, 10);
    shareView.product_id = _groupProductDetail.prod_base_info.prod_id;
    shareView.title = _groupProductDetail.prod_base_info.prod_name;
    shareView.type_post_prod = @"商品转发";
    shareView.prod_relation_id = _groupProductDetail.prod_base_info.relation_id;
    shareView.delegate = self;
    [self.view addSubview:shareView];
    self.shareView = shareView;
    [self.view bringSubviewToFront:shareView];
}



-(void)createShop
{
    TLGroupPurchaseShopView *groupPurchaseShopView = [[TLGroupPurchaseShopView alloc]init];
    groupPurchaseShopView.coupon_store_info =_groupProductDetail.coupon_store_info;
    groupPurchaseShopView.delegate = self;
    groupPurchaseShopView.frame =  CGRectMake(0, CGRectGetMaxY(_groupPurchaseViewShopView.frame), self.scrollView.frame.size.width,groupPurchaseShopView.height ) ;
    _groupPurchaseShopView = groupPurchaseShopView;
    [self.scrollView addSubview:groupPurchaseShopView];
}


-(void)TLShareViewCanelButton
{
    [self smallimg];
}

-(void)setGroupProdDetailView
{
    TLGroupProdDetailView *groupProdDetailView = [[TLGroupProdDetailView alloc]init];
     __unsafe_unretained __typeof(self) weakself = self;
    groupProdDetailView.productDetailBlack = ^{
         [weakself productMessageWithType:@"图文详情"];
    };
    groupProdDetailView.groupCouponPurchaseInfo = _groupProductDetail.coupon_purchase_info;
    groupProdDetailView.frame = CGRectMake(0, CGRectGetMaxY(_groupPurchaseShopView.frame), self.scrollView.frame.size.width, groupProdDetailView.height);
    _groupProdDetailView = groupProdDetailView;
    [self.scrollView addSubview:groupProdDetailView];
    
}

-(void)setGroupProdPruchaseNoticeView
{
    TLGroupProdPruchaseNoticeView *groupProdPruchaseNoticeView = [[TLGroupProdPruchaseNoticeView alloc]init];
    groupProdPruchaseNoticeView.groupProductDetail = _groupProductDetail;
    groupProdPruchaseNoticeView.frame = CGRectMake(0, CGRectGetMaxY(_groupProdDetailView.frame), self.scrollView.frame.size.width, groupProdPruchaseNoticeView.height);
    _groupProdPruchaseNoticeView = groupProdPruchaseNoticeView;
    [self.scrollView addSubview:groupProdPruchaseNoticeView];
     self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(groupProdPruchaseNoticeView.frame));
}

-(void)setFooterView
{
    CGSize moneySignSize = [_moneySign.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];

    _price.text = _groupProductDetail.prod_base_info.price;

    CGSize priceSize = [_price.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:30]}];
    
    _price.frame = CGRectMake(10+moneySignSize.width, CGRectGetMaxY(_scrollView.frame)+10, priceSize.width, priceSize.height);
    _moneySign.frame = CGRectMake(10,CGRectGetMaxY(_price.frame) - moneySignSize.height-5, moneySignSize.width, moneySignSize.height);
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName :[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" ￥%@",_groupProductDetail.prod_base_info.show_price] attributes:attribtDic];
    _showPrice.attributedText = attribtStr;
    
    
    CGSize showPriceSize = [[NSString stringWithFormat:@" ￥%@",_groupProductDetail.prod_base_info.show_price] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    
    _showPrice.frame = CGRectMake(CGRectGetMaxX(_price.frame)+5, CGRectGetMaxY(_price.frame)-showPriceSize.height-5, showPriceSize.width+5, showPriceSize.height);
    
    _sumbitBtn.frame = CGRectMake(self.scrollView.frame.size.width-2*priceSize.height-40, CGRectGetMaxY(_scrollView.frame), 2*priceSize.height+40, priceSize.height+20);
    
    TLGroupUiBtnControlList *groupUiBtnControl = _groupProductDetail.ui_btn_control_list.firstObject;
    if (![groupUiBtnControl.btn_status intValue]) {
        _sumbitBtn.enabled  = YES;
    }else
    {
        _sumbitBtn.enabled  = NO;
    }
    [_sumbitBtn setTitle:groupUiBtnControl.btn_name forState:UIControlStateNormal];
}



-(void)collect:(UIButton *)button
{
    __unsafe_unretained __typeof(self) weakself = self;
    if (!collect) {
        [self addProdCollect];
        [UIView animateWithDuration:0.25 animations:^{
            weakself.prodCollectView.frame = CGRectMake(0, ScreenBounds.size.height-200, ScreenBounds.size.width, 200);
            collect = 1;
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            weakself.prodCollectView.frame =CGRectMake(0, ScreenBounds.size.height, ScreenBounds.size.width, 200);
            collect = 0;
        }];
    }
}


-(void)addProdCollect
{
    TLProdCollectView *proCollect = [TLProdCollectView prodCollect];
    proCollect.frame = CGRectMake(0, ScreenBounds.size.height, ScreenBounds.size.width, 200);
    proCollect.delegate = self;
    [self.view addSubview:proCollect];
    self.prodCollectView = proCollect;
}


-(void)ProdCollectViewCancelWithCollect:(BOOL)collectBtn baby:(BOOL)babyBtn
{
    NSDictionary *dict = [NSDictionary dictionary];
    __unsafe_unretained __typeof(self) weakself = self;
    if (collectBtn || babyBtn) {
        
        if (collectBtn) {
            dict = @{@"collection_type":TL_COLLECT_TYPE_PROD,@"key_value":_groupProductDetail.prod_base_info.prod_id,@"user_id":_gpProductDetailRequest.user_id,TL_USER_TOKEN:_gpProductDetailRequest.TL_USER_TOKEN_REQUEST};
            NSString *url=[NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,remove_Url];
            [TLHttpTool postWithURL:url params:dict success:^(id json) {
                collectBool = 1;
                [weakself selectImage];
                [MBProgressHUD showSuccess:TL_COLLECT_MY_SUCCESS];
            } failure:nil];
            
        }
        if (babyBtn) {
            dict = @{@"collection_type":TL_COLLECT_TYPE_BABY,@"key_value":_groupProductDetail.prod_base_info.prod_id,@"user_id":_gpProductDetailRequest.user_id,TL_USER_TOKEN:_gpProductDetailRequest.TL_USER_TOKEN_REQUEST};
            NSString *url=[NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,remove_Url];
            [TLHttpTool postWithURL:url params:dict success:^(id json) {
                collectBool = 1;
                [weakself selectImage];
                [MBProgressHUD showSuccess:TL_COLLECT_MY_CANCEL_SUCCESS];
            } failure:nil];
        }
    }
    [UIView animateWithDuration:0.25 animations:^{
        weakself.prodCollectView.frame =CGRectMake(0, ScreenBounds.size.height, ScreenBounds.size.width, 200);
        collect = 0;
    }];
    
    
}

-(void)ProdCollectViewSureWithCollect:(BOOL)collectBtn baby:(BOOL)babyBtn
{
    NSDictionary *dict = [NSDictionary dictionary];
    NSMutableArray *temp = [NSMutableArray array];
    __unsafe_unretained __typeof(self) weakself = self;
    if (collectBtn || babyBtn) {
        if (collectBtn) {
            
            dict = @{@"collection_type":TL_COLLECT_TYPE_PROD,@"key_value":_groupProductDetail.prod_base_info.prod_id};
            [temp addObject:dict];
        }
        if (babyBtn) {
            dict = @{@"collection_type":TL_COLLECT_TYPE_BABY,@"key_value":_groupProductDetail.prod_base_info.prod_id};
            [temp addObject:dict];
        }
        
        NSString *url=[NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,add_Url];
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_gpProductDetailRequest.user_id,@"user_id",_gpProductDetailRequest.TL_USER_TOKEN_REQUEST,TL_USER_TOKEN,temp,@"favorites_list_json",_groupProductDetail.prod_base_info.relation_id,@"realtion_id", nil];
        [TLHttpTool postWithURL:url params:params success:^(id json) {
            collectBool = 0;
            [weakself selectImage];
            [MBProgressHUD showSuccess:@"收藏成功"];
        } failure:nil];
    }
    [UIView animateWithDuration:0.25 animations:^{
        weakself.prodCollectView.frame =CGRectMake(0, ScreenBounds.size.height, ScreenBounds.size.width, 200);
        collect = 0;
    }];
    
}



-(void)qrcode:(UIButton *)button
{
    self.qrcode.enabled = NO;
    UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = self.view.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    [blackView addSubview:cover];
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,product_show_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_gpProductDetailRequest.user_id, @"user_id",_gpProductDetailRequest.user_token,TL_USER_TOKEN,_gpProductDetailRequest.product_id, @"prod_id",_gpProductDetailRequest.relation_id,@"relation_id",nil];
    __unsafe_unretained __typeof(self) weakself = self;
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        
        UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:BARCODE_BG]];
        [weakself.view addSubview:backImage];
        weakself.backImage = backImage;
        backImage.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
        
        UIImageView *qrcode = [[UIImageView alloc]init];
        [qrcode setImageWithURL:json[@"body"][@"prod_qr_code_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        qrcode.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
        [blackView addSubview:qrcode];
        weakself.qrcodeImage = qrcode;
        [blackView bringSubviewToFront:qrcode];
        
        [UIView animateWithDuration:0.25 animations:^{
            cover.alpha = 0.5;
            CGFloat iconWH = TL_QRCODE_WH;
            
            CGFloat iconX = (cover.frame.size.width - iconWH)/2;
            CGFloat iconY = (cover.frame.size.height - iconWH)/2;
            qrcode.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
            
            backImage.bounds = CGRectMake(0, 0, ScreenBounds.size.width-20, ScreenBounds.size.width-20);
            backImage.center = qrcode.center;
        }];
        
        
    } failure:^(NSError *error) {
        weakself.qrcode.enabled = YES;
    }];
}


-(void)smallimg
{
    __unsafe_unretained __typeof(self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakself.cover removeFromSuperview];
        [weakself.qrcodeImage removeFromSuperview];
        [weakself.shareView removeFromSuperview];
        [weakself.backImage removeFromSuperview];
        weakself.cover = nil;
        weakself.shareView = nil;
        weakself.collect.alpha = 1;
        weakself.collect.enabled = YES;
        weakself.qrcode.alpha = 1;
        weakself.qrcode.enabled = YES;
    }];
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)groupPurchaseShopView:(TLGroupPurchaseShopView *)groupPurchaseShopView selectShopListButton:(UIButton *)button
{
    TLGroupPurchaseShopListController *groupPurchaseShopList = [[TLGroupPurchaseShopListController alloc]init];
    groupPurchaseShopList.groupProductDetail = _groupProductDetail;
    [self.navigationController pushViewController:groupPurchaseShopList animated:YES];
}


@end
