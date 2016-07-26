//
//  TLProdPurchaseViewController.m
//  tongle
//
//  Created by liu ruibin on 15-5-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdPurchaseViewController.h"
#import "TLProdMessageViewController.h"
#import "TLCheckoutViewController.h"
#import "TLShopCarViewController.h"
#import "TLMoshopViewController.h"
#import "UIBarButtonItem+TL.h"
#import "TLprodPurchaseView.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLProdMegViewCell.h"
#import "TLProdCollectView.h"
#import "TLProduct.h"
#import "TLProdMeg.h"
#import "TLShareView.h"
#import "TLPordDetailRequest.h"
#import "TLBaseTool.h"
#import "TLProdDetailsMeg.h"
#import "TLQrdata.h"
#import "TLShopCreateRequest.h"
#import "JSONKit.h"
#import "TLThis_Shop_Array.h"
#import "TLHomepage_ads.h"
#import "TLPostContent.h"
#import "TLProdCommentRequest.h"
#import "TLProdComment.h"
#import "TLProdDetailCommentCell.h"
#import "TLCommon.h"
#import "TLImageName.h"
#import "Url.h"
#import "UIColor+TL.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+Image.h"
#import "UIButton+TL.h"
#import "TLMoshopAd.h"
#import "TLSubmitOrderModel.h"
#import "TLOrderDetailMeg.h"
#import "TLMyOrderDetailList.h"
#import "TLIntegrateDetailController.h"
#import "TLGroupCouponVoucher.h"


@interface TLProdPurchaseViewController ()<UITableViewDelegate,UITableViewDataSource,TLProdCollectViewDelegate,TLprodPurchaseViewDelegate,TLShareViewDelegate,UIScrollViewDelegate,TLProdMegDelegate,TLProdMessageViewControllerDelegate>

@property (nonatomic,weak)      TLprodPurchaseView  *prodPurchaseView;
@property (nonatomic,weak)      UITableView         *tableView;
@property (nonatomic,weak)      TLProdCollectView   *prodCollectView;
@property (nonatomic,weak)      TLShareView         *shareView;
@property (nonatomic,strong)    TLPordDetailRequest *pordDetailRequest;
@property (nonatomic,strong)    TLProdDetailsMeg    *prodDetailsMeg;
@property (nonatomic,weak)      UIPageControl       *pageControll;
@property (nonatomic,weak)      UIScrollView        *scrollView;
@property (nonatomic,strong)    NSTimer             *timer;
@property (nonatomic,assign)    CGFloat             height;
@property (nonatomic,assign)    CGFloat             headheight;
@property (nonatomic,strong)    NSMutableArray      *specArray;
@property (nonatomic,assign)    int                 amount;
@property (nonatomic,strong)    TLProdComment       *prodComment;
@property (nonatomic,strong)    TLThis_Shop_Array   *shop_array;
@property (nonatomic,copy)      NSString            *prodePrice;


@end

@implementation TLProdPurchaseViewController


static int collectBool = 1;
static int collect = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
    [self AddRigthButton];
    [self loadDate];
    [self loadComment];
    [self setupTableView];
    [self timeOn];
}

//懒加载产品请求
-(TLPordDetailRequest *)pordDetailRequest
{
    if (_pordDetailRequest == nil) {
        _pordDetailRequest  = [[TLPordDetailRequest alloc]init];
    }
    return _pordDetailRequest;
}
//设置基本数据
-(void)setupData
{
    int back_Image_WH = 25;
    
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    self.amount=1;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, back_Image_WH, back_Image_WH);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftButton;
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


-(void)setProdOtherBody:(TLProduct *)prodOtherBody
{
    _prodOtherBody = prodOtherBody;
    [self setProductMessage:prodOtherBody withAction:prod_otherBody];
    
}

-(void)setMstoreproduct:(TLProduct *)mstoreproduct
{
    _mstoreproduct = mstoreproduct;
    [self setProductMessage:mstoreproduct withAction:prod_mstore];
}

-(void)setProduct:(TLProduct *)product
{
    _product = product;
    [self setProductMessage:product withAction:prod_collect];
}
-(void)setMybabyproduct:(TLProduct *)mybabyproduct
{
    _mybabyproduct = mybabyproduct;
    [self setProductMessage:mybabyproduct withAction:prod_meBoby];
}

-(void)setProd_hotProd:(TLProduct *)prod_hotProd
{
    _prod_hotProd = prod_hotProd;
    [self setProductMessage:prod_hotProd withAction:prod_hot];
}

-(void)setMyorderproduct:(TLMyOrderDetailList *)myorderproduct
{
    _myorderproduct = myorderproduct;
    self.pordDetailRequest.product_id = myorderproduct.prod_id;
    //self.pordDetailRequest.relation_id = product.relation_id;
    //self.pordDetailRequest.mstore_id = myorderproduct.mstore_id;
    self.pordDetailRequest.post_id = myorderproduct.post_id;
    self.pordDetailRequest.action = prod_order;
    _prod_id = myorderproduct.prod_id;
}

-(void)setGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    _groupCouponVoucher = groupCouponVoucher;
    
    self.pordDetailRequest.product_id = groupCouponVoucher.voucher_link_info.link_id;
    self.pordDetailRequest.action = prod_activity;
    _prod_id = groupCouponVoucher.voucher_link_info.link_id;
}


-(void)setProductMessage:(TLProduct *)product withAction:(NSString *)action
{
    self.pordDetailRequest.product_id = product.prod_id;
    self.pordDetailRequest.relation_id = product.relation_id;
    self.pordDetailRequest.mstore_id = product.mstore_id;
    self.pordDetailRequest.post_id = product.post_id;
    self.pordDetailRequest.action = action;
    _prod_id = product.prod_id;
}


-(void)setQrdata:(TLQrdata *)qrdata
{
    _qrdata = qrdata;
    self.pordDetailRequest.product_id = qrdata.prod_id;
    self.pordDetailRequest.relation_id = qrdata.relation_id;
    self.pordDetailRequest.mstore_id = qrdata.store_id;
    self.pordDetailRequest.post_id = qrdata.post_id;
    self.pordDetailRequest.action = prod_code;
    _prod_id = qrdata.prod_id;
}

-(void)setHomepageprod:(TLHomepage_ads *)Homepageprod
{
    _Homepageprod = Homepageprod;
    self.pordDetailRequest.product_id = Homepageprod.object_id;
    self.pordDetailRequest.action = prod_activity;
    self.pordDetailRequest.relation_id = Homepageprod.relation_id;
    _prod_id = Homepageprod.object_id;
}

-(void)setPostContent:(TLPostContent *)postContent
{
    _postContent = postContent;
    self.pordDetailRequest.product_id = postContent.object_id;
    self.pordDetailRequest.action = prod_post;
    self.pordDetailRequest.relation_id = postContent.relation_id;
    _prod_id = postContent.object_id;
}

-(void)setAd:(TLMoshopAd *)ad
{
    _ad = ad;
    self.pordDetailRequest.product_id = ad.object_id;
    self.pordDetailRequest.action = prod_activity;
    _prod_id = ad.object_id;
}

-(void)setProdOrg:(TLProduct *)prodOrg
{
    _prodOrg = prodOrg;
    self.pordDetailRequest.product_id = prodOrg.prod_id;
    self.pordDetailRequest.action = prod_org;
    self.pordDetailRequest.relation_id = prodOrg.relation_id;
    _prod_id = prodOrg.prod_id;
}


-(void)loadDate
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,products_show_Url];
    //发送请求
    if (!self.prodDetailsMeg.prod_info.prod_id.length) {
        self.collect.enabled = NO;
        self.qrcode.enabled = NO;
    }
    
    __unsafe_unretained __typeof(self) weakself = self;
    [TLBaseTool postWithURL:url param:self.pordDetailRequest success:^(id result) {
        weakself.prodDetailsMeg = result;
        collectBool = [weakself.prodDetailsMeg.prod_info.prod_favorited_by_me intValue];
        if (weakself.prodDetailsMeg.prod_info.prod_id.length) {
            weakself.collect.enabled = YES;
            weakself.qrcode.enabled = YES;
        }
        _prodePrice = _prodDetailsMeg.prod_info.price_interval;
        [weakself setUpSpecArray];
        [weakself selectImage];
        [weakself setProdPurchaseView];
        [weakself setUpPageControl];
        [weakself createimageButton];
        [weakself footView];
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        weakself.collect.enabled = NO;
        weakself.qrcode.enabled = NO;
    } resultClass:[TLProdDetailsMeg class]];
}

-(void)loadComment
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,evaluation_show_Url];
    TLProdCommentRequest *prodCommentRequest = [[TLProdCommentRequest alloc]init];
    prodCommentRequest.product_id = self.pordDetailRequest.product_id;
    prodCommentRequest.level = TL_BEST;
    prodCommentRequest.fetch_count = PROD_EVA_COUNT;
    __unsafe_unretained __typeof(self) weakself = self;
    [TLBaseTool postWithURL:url param:prodCommentRequest success:^(id result) {
        weakself.prodComment = result;
        [weakself.tableView reloadData];
    } failure:nil resultClass:[TLProdComment class]];
}

-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height-112);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor getColor:TL_PROD_PURCH_BACK_GROUND_COLOR];
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

-(void)addProdCollect
{
    TLProdCollectView *proCollect = [TLProdCollectView prodCollect];
    proCollect.frame = CGRectMake(0, ScreenBounds.size.height, ScreenBounds.size.width, 200);
    proCollect.delegate = self;
    [self.view addSubview:proCollect];
    self.prodCollectView = proCollect;
}

-(void)collect:(UIButton *)btn
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


-(void)ProdCollectViewCancelWithCollect:(BOOL)collectBtn baby:(BOOL)babyBtn
{
    NSDictionary *dict = [NSDictionary dictionary];
     __unsafe_unretained __typeof(self) weakself = self;
    if (collectBtn || babyBtn) {
        
        if (collectBtn) {
            dict = @{@"collection_type":TL_COLLECT_TYPE_PROD,@"key_value":self.prodDetailsMeg.prod_info.prod_id,@"user_id":self.user_id,TL_USER_TOKEN:self.token};
            NSString *url=[NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,remove_Url];
            [TLHttpTool postWithURL:url params:dict success:^(id json) {
                collectBool = 1;
                [weakself selectImage];
                [MBProgressHUD showSuccess:TL_COLLECT_MY_SUCCESS];
            } failure:nil];
            
        }
        if (babyBtn) {
            dict = @{@"collection_type":TL_COLLECT_TYPE_BABY,@"key_value":self.prodDetailsMeg.prod_info.prod_id,@"user_id":self.user_id,TL_USER_TOKEN:self.token};
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
            
            dict = @{@"collection_type":TL_COLLECT_TYPE_PROD,@"key_value":self.prodDetailsMeg.prod_info.prod_id};
            [temp addObject:dict];
        }
        if (babyBtn) {
            dict = @{@"collection_type":TL_COLLECT_TYPE_BABY,@"key_value":self.prodDetailsMeg.prod_info.prod_id};
            [temp addObject:dict];
        }
        
        NSString *url=[NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,add_Url];
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,temp,@"favorites_list_json",self.prodDetailsMeg.prod_info.relation_id,@"realtion_id", nil];
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

-(void)selectImage
{
    NSString *image = collectBool==0?  TL_COLLECT_COLLECT : TL_COLLECT__NORMAL;
    [self.collect setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}
-(void)qrcode:(UIButton *)btn
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
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.pordDetailRequest.user_id, @"user_id",self.pordDetailRequest.TL_USER_TOKEN_REQUEST,TL_USER_TOKEN,self.pordDetailRequest.product_id, @"prod_id",self.pordDetailRequest.relation_id,@"relation_id",nil];
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


-(void)setProdPurchaseView
{
    TLprodPurchaseView *prodPurchaseView = [[TLprodPurchaseView alloc]init];

    if (self.prodDetailsMeg.prod_info.prod_id.length) {
        prodPurchaseView.hidden = NO;
    }else
    {
        prodPurchaseView.hidden = YES;
    }
    prodPurchaseView.delegate = self;
    prodPurchaseView.prod_Price = _prodePrice;
    prodPurchaseView.prodDetails = self.prodDetailsMeg.prod_info;
    self.headheight = prodPurchaseView.height;
    self.tableView.contentInset = UIEdgeInsetsMake(prodPurchaseView.height, 0, 0, 0);
    prodPurchaseView.frame = CGRectMake(0, -prodPurchaseView.height, self.view.bounds.size.width, prodPurchaseView.height);
    self.scrollView = (UIScrollView *)[prodPurchaseView viewWithTag:101];
    self.scrollView.delegate = self;
    [self.tableView addSubview:prodPurchaseView];
    self.prodPurchaseView = prodPurchaseView;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentPoint = self.scrollView.contentOffset.x;
    double Double = currentPoint/self.scrollView.bounds.size.width;
    int page = (int)(Double + 0.5);
    self.pageControll.currentPage = page;
}

/**
 *  增加页码显示
 */

-(void)setUpPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.bounds = CGRectMake(0, 0, ScreenBounds.size.width/2, 20);
    pageControl.numberOfPages = self.prodDetailsMeg.prod_info.prod_pic_url_list.count;
    pageControl.center = CGPointMake(ScreenBounds.size.width/2, self.prodPurchaseView.prodImage.frame.size.height - self.prodPurchaseView.frame.size.height -10);
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.tableView addSubview:pageControl];
    [self.tableView bringSubviewToFront:pageControl];
    self.pageControll = pageControl;
}

-(void)timeOn
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(play) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)timeOff
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)play
{
    int i = (int)self.pageControll.currentPage;
    if (i == self.prodDetailsMeg.prod_info.prod_pic_url_list.count - 1) {
        i=-1;
    }
    i++;
    [self.scrollView setContentOffset:CGPointMake(i*self.scrollView.bounds.size.width, 0) animated:YES];
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self timeOff];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self timeOn];
}
-(void)prodPurchaseViewShare
{
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = ScreenBounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    [self.view addSubview:cover];
    
    [self createShareView];
    __unsafe_unretained __typeof(self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.5;
        //  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"collect__normal" ] forBarMetrics:UIBarMetricsCompact];
        weakself.collect.alpha = 0.5;
        weakself.collect.enabled = NO;
        weakself.qrcode.alpha = 0.5;
        weakself.qrcode.enabled = NO;
        weakself.shareView.frame = CGRectMake(20, 100, ScreenBounds.size.width-40, self.shareView.height+10);
    }];
}

-(void)prodPurchaseViewProdDetails
{
    self.prodDetailsMeg.prod_info.prod_favorited_by_me  = [NSString stringWithFormat:@"%d",collectBool];
    [[NSUserDefaults standardUserDefaults] setObject:self.prodDetailsMeg.prod_info.prod_id forKey:TL_PROD_DETAILS_PROD_ID];
    [self performSegueWithIdentifier:TL_PROD_MESSAGE sender:self.prodDetailsMeg.prod_info];
}

-(void)prodPurchaseViewProdIntegrateDetails
{
    TLIntegrateDetailController *integrateDetailController = [[TLIntegrateDetailController alloc]init];
    integrateDetailController.prodDetails = self.prodDetailsMeg.prod_info;
    [self.navigationController pushViewController:integrateDetailController animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TLProdMessageViewController *vc = segue.destinationViewController;
    vc.delegate = self;
    vc.prodDetails = sender;
    vc.prodType = @"0";
}

-(void)prodMessageViewController:(TLProdMessageViewController *)prodMessageViewController withProdDetails:(TLProdDetails *)prodDetails
{
    self.prodDetailsMeg.prod_info = prodDetails;
    collectBool = [self.prodDetailsMeg.prod_info.prod_favorited_by_me intValue];
    [self selectImage];
}


-(void)createShareView
{
    TLShareView *shareView = [TLShareView share];
    
    shareView.frame = CGRectMake(ScreenBounds.size.width/2, ScreenBounds.size.height/2, 10, 10);
    shareView.product_id = self.prod_id;
    shareView.title = self.prodDetailsMeg.prod_info.prod_name;
    shareView.type_post_prod = @"商品转发";
    shareView.prod_relation_id = self.prodDetailsMeg.prod_info.relation_id;
    shareView.delegate = self;
    [self.view addSubview:shareView];
    self.shareView = shareView;
    [self.view bringSubviewToFront:shareView];
}
-(void)TLShareViewCanelButton
{
    [self smallimg];
}


-(void)footView
{
    int shop_Car_Button_W = 58;
    int shop_Car_Button_H = 48;
    UIButton *shoppingCart = [UIButton buttonWithType:UIButtonTypeCustom];
    shoppingCart.frame = CGRectMake(0, ScreenBounds.size.height-shop_Car_Button_H, shop_Car_Button_W, shop_Car_Button_H);
    if (self.prodDetailsMeg.prod_info.prod_id.length) {
        shoppingCart.hidden = NO;
    }else
    {
        shoppingCart.hidden = YES;
    }
    [shoppingCart setImage:[UIImage imageNamed:TL_SHOPPINGCAR_NORMAL] forState:UIControlStateNormal];
    [shoppingCart setImage:[UIImage imageNamed:TL_SHOPPINGCAR_PRESS] forState:UIControlStateHighlighted];
    [shoppingCart addTarget:self action:@selector(shoppingCart:) forControlEvents:UIControlEventTouchUpInside];
    [shoppingCart setBackgroundColor:[UIColor getColor:TL_SHOPPINGCAR_BACK_GROUND_COLOR]];

    [self.view addSubview:shoppingCart];
    [self.view bringSubviewToFront:shoppingCart];
    
    UIButton *addProdBtn = [[UIButton alloc]initWithFrame:CGRectMake(shop_Car_Button_W, ScreenBounds.size.height-shop_Car_Button_H, (ScreenBounds.size.width-shop_Car_Button_H)/2, shop_Car_Button_H)];
    if (self.prodDetailsMeg.prod_info.prod_id.length) {
        addProdBtn.hidden = NO;
    }else
    {
        addProdBtn.hidden = YES;
    }
    addProdBtn.backgroundColor = [UIColor getColor:TL_ADD_SHOPPINGCAR_BACK_GROUND_COLOR];
    [addProdBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addProdBtn addTarget:self action:@selector(addProd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addProdBtn];
    [self.view bringSubviewToFront:addProdBtn];
    
    UIButton *buyProdBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addProdBtn.frame), ScreenBounds.size.height-shop_Car_Button_H, (ScreenBounds.size.width-shop_Car_Button_H)/2, shop_Car_Button_H)];
    if (self.prodDetailsMeg.prod_info.prod_id.length) {
        buyProdBtn.hidden = NO;
    }else
    {
        buyProdBtn.hidden = YES;
    }
    buyProdBtn.backgroundColor = [UIColor getColor:TL_BUY_BACK_GROUND_COLOR];
    [buyProdBtn addTarget:self action:@selector(ThisProd:) forControlEvents:UIControlEventTouchUpInside];
    [buyProdBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.view addSubview:buyProdBtn];
    [self.view bringSubviewToFront:buyProdBtn];
}

-(void)shoppingCart:(UIButton *)btn
{
    self.tabBarController.selectedIndex = 3;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)addProd:(UIButton *)addProdBtn
{
    [self shopCarWithButton:addProdBtn];
}

-(void)ThisProd:(UIButton *)ThisProd
{
    [self shopCarWithButton:ThisProd];
}

-(void)shopCarWithButton:(UIButton *)btn
{
    [btn ButtonDelay];
    int key = 1;
    for (NSDictionary *dict in self.specArray) {
        key = key && [dict count];
    }
    if (key == 1) {
        if (self.amount) {
            NSString *url =  [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,shopping_carts_create_Url];
            
            TLShopCreateRequest *shopCreate = [[TLShopCreateRequest alloc]init];
            NSString *prod_id = nil;
            
            if (self.qrdata == nil) {
                prod_id = self.prod_id;
            }else
            {
                prod_id = self.qrdata.prod_id;
            }
            NSDictionary *temp = @{@"product_id":prod_id,@"order_qty":[NSString stringWithFormat:@"%d",self.amount] ,@"prod_spec_list":self.specArray};
            NSDictionary *prod = [NSDictionary dictionaryWithObjectsAndKeys:temp,@"product_info", nil];
            NSString *productjson = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:prod options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
            shopCreate.product_info_json = productjson;
            shopCreate.post_id = self.prodDetailsMeg.post_info.post_id;
            shopCreate.realtion_id = self.prodDetailsMeg.prod_info.relation_id;
            shopCreate.mstore_id = self.prodDetailsMeg.prod_info.mstore_id;
            __unsafe_unretained __typeof(self) weakself = self;
            [TLBaseTool postWithURL:url param:shopCreate success:^(id result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    TLThis_Shop_Array *shop_array = result;
                    weakself.shop_array = shop_array;
                    if ([btn.titleLabel.text isEqualToString:@"加入购物车"]) {
                        [MBProgressHUD showSuccess:TL_ADD_SHOPCAR_SUCCESS];
                    }else
                    {
                        if (shop_array.this_shopping_cart.count) {
                            TLShopCar *shopCar = shop_array.this_shopping_cart[0];
                            [weakself actionOrderWithShopCar:shopCar];
                        }
                    }
                });
            } failure:nil resultClass:[TLThis_Shop_Array class]];
        }else
        {
            [MBProgressHUD showError:@"数量不可为零"];
        }
        
    }else
    {
        for (NSDictionary *dict in self.specArray) {
            if ([dict count] == 0) {
                int index = (int)[self.specArray indexOfObject:dict];
                TLProdSpecList *prodSpecList  = self.prodDetailsMeg.prod_info.prod_spec_list[index];
                NSString *tip = [NSString stringWithFormat:@"请选择%@",prodSpecList.prod_spec_name];
                [MBProgressHUD showError:tip];
            }
        }
    }
}

-(void)actionOrderWithShopCar:(TLShopCar *)shopCar
{
    TLSubmitOrderModel *submitOrder = [[TLSubmitOrderModel alloc]init];
    NSMutableArray *prodNoArray = [NSMutableArray array];
    [prodNoArray addObject:shopCar.seq_no];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:prodNoArray,@"product_info", nil];
    NSString *dict_string = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    submitOrder.product_info_json = dict_string;
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,balance_Url];
    __unsafe_unretained __typeof(self) weakself = self;
    [TLBaseTool postWithURL:url param:submitOrder success:^(id result) {
        TLOrderDetailMeg *orderDetailMeg = result;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
        TLCheckoutViewController *checkout = [storyboard instantiateViewControllerWithIdentifier:TL_CHECKOUT];
        checkout.chectoutProduct = self.shop_array.this_shopping_cart;
        checkout.orderDetailMeg = orderDetailMeg;
        [weakself.navigationController pushViewController:checkout animated:YES];
    } failure:nil resultClass:[TLOrderDetailMeg class]];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.prodDetailsMeg.prod_info.prod_id.length) {
        return 1+ ((self.prodComment.product_rating_list.count < 5)? self.prodComment.product_rating_list.count : 5);
    }else
    {
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TLProdMegViewCell *cell = [TLProdMegViewCell cellWithTableCell:tableView];
        cell.prodDetails = _prodDetailsMeg.prod_info;
        _height = cell.prodMegView.height;
        cell.prodMegView.delegate = self;
        cell.backgroundColor = [UIColor greenColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else
    {
        TLProdDetailCommentCell *cell = [TLProdDetailCommentCell cellWithTableCell:tableView];
        cell.prodProductRatingList = self.prodComment.product_rating_list[indexPath.row-1];
        self.height = cell.height;
        cell.commentHide = (indexPath.row == 1)? NO : YES;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height;
}




-(NSMutableArray *)specArray
{
    if (_specArray == nil) {
        _specArray = [NSMutableArray array];
    }
    return _specArray;
}

-(void)setUpSpecArray
{
    for (int i=0; i<self.prodDetailsMeg.prod_info.prod_spec_list.count; i++)
    {
        
        NSDictionary *prod_spec_dict = [[NSDictionary alloc]init];
        [self.specArray addObject:prod_spec_dict];
    }
}

-(void)ProdMeg:(TLProdMeg *)prodMeg withMutableArray:(NSMutableArray *)prod_spec_list_array munber:(int)amount price:(NSString *)price
{
    
    _prodePrice = price;
    self.prodPurchaseView.prod_Price = _prodePrice;
    _specArray = prod_spec_list_array;
    self.amount = amount;
}


-(void)ProdMegCreate:(TLProdMeg *)prodMeg withMutableArray:(NSMutableArray *)prod_spec_list_array
{
    _specArray = prod_spec_list_array;
    _prodePrice = _prodDetailsMeg.prod_info.price_interval;
    self.prodPurchaseView.prod_Price = _prodePrice;
}


-(void)createimageButton
{
    UIButton *imagebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imagebutton setImage:[UIImage imageNamed:@"moshop_icon"] forState:UIControlStateNormal];
    [imagebutton setImage:[UIImage imageNamed:@"moshop_icon"] forState:UIControlStateHighlighted];
    if (self.prodDetailsMeg.prod_info.prod_id.length) {
        imagebutton.enabled = YES;
    }else
    {
        imagebutton.enabled = NO;
    }
    imagebutton.alpha = 0.6;
    imagebutton.bounds = CGRectMake(0, 0, 30, 30);
    imagebutton.center = CGPointMake(ScreenBounds.size.width-24, ScreenBounds.size.width*3/4-30-self.headheight);

    [imagebutton.layer setMasksToBounds:YES];
    [imagebutton.layer setCornerRadius:imagebutton.bounds.size.width/2]; //设置矩圆角半径

    [self.tableView addSubview:imagebutton];
    [self.tableView bringSubviewToFront:imagebutton];
    [imagebutton addTarget:self action:@selector(jumpshop:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)jumpshop:(UIButton *)imagebutton
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Tongle_Base" bundle:nil];
    TLMoshopViewController *moShopController = [storyboard instantiateViewControllerWithIdentifier:@"moshop"];
    moShopController.prod_mstore_id = self.prodDetailsMeg.prod_info.mstore_id;
    [self.navigationController pushViewController:moShopController animated:YES];
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


@end
