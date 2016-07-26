//
//  TLMasterSuperViewController.m
//  tongle
//
//  Created by liu ruibin on 15-5-13.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMasterSuperViewController.h"
#import "TLReplaceViewController.h"
#import "TLMasterProductViewController.h"
#import "TLProdPurchaseViewController.h"
#import "TLPostDetailViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "UIBarButtonItem+TL.h"
#import "JSONKit.h"
#import "TLMasterParam.h"
#import "TLNavigationBar.h"
#import "TLQrdata.h"
#import "TLHomepage_ads.h"
#import "TLPostContent.h"
#import "TLHead.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"
#import "TLMoshopAd.h"
#import "TLExpertUserRequest.h"
#import "TLBaseTool.h"
#import "TLExpertUserMessage.h"
#import "UIButton+TL.h"
#import "TLGroupCouponVoucher.h"

@interface TLMasterSuperViewController ()<UIScrollViewDelegate,TLNavigationBarDelegate>
{
    UIScrollView *_marketScrollView;
    TLHead *tabHead;
    NSArray *_titleArray;
}

@end

@implementation TLMasterSuperViewController

static  TLMasterProductViewController    *masterProductViewController = nil;
//收藏标志位
static int collectBool = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
    [self initNavigationBar];
    [self CreatViewControllers];
}

//自定义导航栏

- (void)initNavigationBar{
    
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, TL_NAVI_BIG_HEIGHT)];
    [navigationBar creatWithLeftAndRightButtonAndtitle:self.user_nick_name collectBool:collectBool];
    self.collect = (UIButton *)[navigationBar viewWithTag:100];
    [self.collect addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    self.qrcode = (UIButton *)[navigationBar viewWithTag:101];
    [self.qrcode addTarget:self action:@selector(qrcode:) forControlEvents:UIControlEventTouchUpInside];
    
    navigationBar.Delegate = self;
    [self.view addSubview:navigationBar];
    self.navigationBar = navigationBar;
    [self CreateNavigationBar];
    
}

//控制器返回
-(void)tlNavigationBarBack
{
    if (self.qrdata == nil) {
         [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.qrdata = nil;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO];
    masterProductViewController = nil;
    [masterProductViewController removeFromParentViewController];
    
}

//初始化数据
-(void)getData
{
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    self.expert_user_id = [[NSUserDefaults standardUserDefaults]objectForKey:TL_MASTER];
    [self loadExpertUser];
}

-(void)setMaster:(TLMasterParam *)master
{
    _master = master;
    collectBool = [master.user_favorited_by_me intValue];
    [self selectImage];
    self.user_nick_name = master.user_nick_name;
}


-(void)setQrdata:(TLQrdata *)qrdata
{
    _qrdata = qrdata;
    [[NSUserDefaults standardUserDefaults] setObject:qrdata.user_id forKey:TL_MASTER];
}

-(void)setHomepageMaster:(TLHomepage_ads *)HomepageMaster
{
    _HomepageMaster = HomepageMaster;
     [[NSUserDefaults standardUserDefaults] setObject:HomepageMaster.object_id forKey:TL_MASTER];
}

-(void)setPostContent:(TLPostContent *)postContent
{
    _postContent = postContent;
    [[NSUserDefaults standardUserDefaults] setObject:postContent.object_id forKey:TL_MASTER];
}

-(void)setAd:(TLMoshopAd *)ad
{
    _ad = ad;
    [[NSUserDefaults standardUserDefaults] setObject:ad.object_id forKey:TL_MASTER];
}

-(void)setGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    _groupCouponVoucher = groupCouponVoucher;
    [[NSUserDefaults standardUserDefaults] setObject:groupCouponVoucher.voucher_link_info.link_id forKey:TL_MASTER];
}


-(void)loadExpertUser
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,expert_user_info_Url];
    TLExpertUserRequest *expertUserRequest = [[TLExpertUserRequest alloc]init];
    expertUserRequest.expert_user_id = [[NSUserDefaults standardUserDefaults] objectForKey:TL_MASTER];
    __unsafe_unretained __typeof(self) weakself = self;
    [TLBaseTool postWithURL:url param:expertUserRequest success:^(id result) {
        TLExpertUserMessage *expertUserMessage = result;
        weakself.expertUserMessage = expertUserMessage;
        collectBool = [expertUserMessage.user_favorited_by_me intValue];
        [weakself selectImage];
        [weakself.navigationBar setCenterTitle:expertUserMessage.user_nick_name];
        weakself.user_nick_name = expertUserMessage.user_nick_name;
    } failure:nil resultClass:[TLExpertUserMessage class]
     ];

}


//收藏
-(void)collect:(UIButton *)btn
{
    if (collectBool) {
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,add_Url];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:TL_COLLECT_TYPE_MASTER,@"collection_type",self.expert_user_id,@"key_value", nil];
        NSMutableArray *temp = [NSMutableArray array];
        [temp addObject:dict];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",temp,@"favorites_list_json",self.token,TL_USER_TOKEN,@"",@"relation_id", nil];
         __unsafe_unretained __typeof(self) weakself = self;
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            collectBool = 0;
            [weakself selectImage];
            [MBProgressHUD showSuccess:TL_COLLECT_SUCCESS];
        } failure:nil];
        
    }else
    {
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,remove_Url];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.expert_user_id,@"key_value",TL_COLLECT_TYPE_MASTER,@"collection_type",self.token,TL_USER_TOKEN, nil];
          __unsafe_unretained __typeof(self) weakself = self;
        [TLHttpTool postWithURL:url params:param success:^(id json) {
             collectBool = 1;
            [weakself selectImage];
            [MBProgressHUD showSuccess:TL_COLLECT_CANCEL_SUCCESS];
        } failure:nil];
        
    }

}

//设置按键图片
-(void)selectImage
{
    NSString *image = collectBool==0? TL_COLLECT_COLLECT : TL_COLLECT__NORMAL;
    [self.collect setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

//二维码
-(void)qrcode:(UIButton *)btn
{
    [btn ButtonDelay];
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = self.view.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    [self.view addSubview:cover];
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_show_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.expert_user_id, @"expert_user_id" ,nil];
    __unsafe_unretained __typeof(self) weakself = self;
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        
        UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:BARCODE_BG]];
        [weakself.view addSubview:backImage];
        weakself.backImage = backImage;
        backImage.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
        
        UIImageView *qrcode = [[UIImageView alloc]init];
        [qrcode setImageWithURL:json[@"body"][@"user_qr_code_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        qrcode.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
        [weakself.view addSubview:qrcode];
        weakself.qrcodeImage = qrcode;
        [weakself.view bringSubviewToFront:qrcode];
        
        [UIView animateWithDuration:0.25 animations:^{
            cover.alpha = 0.5;
            //使导航栏透明
          //  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"collect__normal" ] forBarMetrics:UIBarMetricsCompact];
            weakself.collect.alpha = 0.5;
            weakself.collect.enabled = NO;
            weakself.qrcode.alpha = 0.5;
            weakself.qrcode.enabled = NO;
            CGFloat iconWH = TL_QRCODE_WH;
            CGFloat iconX = (cover.frame.size.width - iconWH)/2;
            CGFloat iconY = (cover.frame.size.height - iconWH)/2 - 20;
            qrcode.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
            
            backImage.bounds = CGRectMake(0, 0, ScreenBounds.size.width-20, ScreenBounds.size.width-20);
            backImage.center = qrcode.center;
            
        }];

        
    } failure:nil];
}

-(void)smallimg
{
    __unsafe_unretained __typeof(self) weakself = self;
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



-(void)CreateNavigationBar
{
    /**
     *  设置子控制器的标题
     */
    NSArray *titleArray = @[@"更新",@"产品"];
    tabHead = [[TLHead alloc]init];
    /**
     *  创建按键
     */
    [tabHead CreateNavigationBartitleArray:titleArray Controller:self.navigationBar];
    /**
     *  设置按键对子控制器的控制
     */
    for (UIButton *btn in tabHead.navigationImageView.subviews) {
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    _titleArray = titleArray;
    
}
/**
 *  对子控制器的切换
 *
 *  @param sender 被触发的按键
 */
-(void)btnClicked:(UIButton *)sender
{
    CGRect frame = [UIScreen mainScreen].bounds;
    for (int i = 0; i< _titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.navigationBar viewWithTag:1000+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    int index = (int)(sender.tag-1000) ;
    //[self createSubControllerWithIndex:index frame:frame];
    _marketScrollView.contentOffset = CGPointMake(index*frame.size.width, 0);
}

-(void)CreatViewControllers
{
    
    CGRect frame = [UIScreen mainScreen].bounds;
    /**
     初始化子控制器
     */
    TLReplaceViewController *replace = [[TLReplaceViewController alloc]init];
    replace.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    
    /**
     设置子控制器所在scrollView
     */
    _marketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TL_NAVI_BIG_HEIGHT+1, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1)];
    _marketScrollView.showsHorizontalScrollIndicator = NO;
    _marketScrollView.showsVerticalScrollIndicator = NO;
    _marketScrollView.pagingEnabled = YES;
    _marketScrollView.delegate = self;
    // NSArray * array = @[bigV,post,magicShop,products];
    
    [self addChildViewController:replace];
    [_marketScrollView addSubview:replace.view];
    
    _marketScrollView.contentSize = CGSizeMake(_titleArray.count*frame.size.width, 0);
    [self.view addSubview:_marketScrollView];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX/scrollView.frame.size.width;
    int index = (int)(pageDouble + 0.5);
    
    for (int i = 0; i< _titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.navigationBar viewWithTag:1000+i];
        btn.selected = NO;
    }
    UIButton *selectBtn = (UIButton *)[self.navigationBar viewWithTag:1000+index];
    selectBtn.selected = YES;
    if (masterProductViewController == nil) {
        masterProductViewController = [[TLMasterProductViewController alloc]init];
        masterProductViewController.view.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
        [self addChildViewController:masterProductViewController];
        [_marketScrollView addSubview:masterProductViewController.view];
    }
    
}

//跳转传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    
    if ([vc isKindOfClass:[TLProdPurchaseViewController class]])
        {
        TLProdPurchaseViewController *prodPurchase = vc;
        prodPurchase.prodOtherBody = sender;
        }else if ([vc isKindOfClass:[TLPostDetailViewController class]])
        {
            TLPostDetailViewController *postdetail = vc;
            postdetail.postParam = sender;
        }
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
