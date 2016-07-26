//
//  TLMainViewController.m
//  TL11
//
//  Created by liu on 15-4-10.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMainViewPostController.h"
#import "TLPostParam.h"
#import "TLPostFrame.h"
#import "TLPostViewCell.h"
#import "TLFriendsPostsRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLHomepage_ads.h"
#import "TLMagicShopAll.h"
#import "TLMagicShopAd.h"
#import "TLMagicRequest.h"
#import "TLMagicShop.h"
#import "MJRefresh.h"
#import "TLHomeAd.h"
#import "TLFriendsPostsAll.h"
#import "TLPostDetailViewController.h"
#import "TLMoshopViewController.h"
#import "TLProdPurchaseViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLIntegrateDetailController.h"
#import "TLImageName.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "UIImage+TL.h"
#import "TLBaseTool.h"
#import "UIImageView+Image.h"
#import "MJExtension.h"
#import "TLBasicData.h"
#import "TLBaseDataMd5List.h"
#import "TLBaseDataMd5.h"
#import "TLPostTopView.h"
#import "TLGroupPurchaseViewController.h"
#import "TLProduct.h"

@interface TLMainViewPostController ()<UIScrollViewDelegate,TLMagicShopAdDelegate,TLPostTopViewDelegate>

@property (nonatomic,weak)      UIPageControl   *pageControl;
@property (nonatomic,weak)      UIScrollView    *scrollView;
@property (nonatomic,strong)    NSMutableArray  *arrayFrame;
@property (nonatomic,strong)    NSArray         *adArray;
//魔店参数模型
@property (nonatomic,strong)    NSMutableArray  *magicShop;
//魔店总的参数模型
@property (nonatomic,strong)    TLMagicShopAll  *magicShopAll;
//魔店广告
@property (nonatomic,strong)    TLMagicShopAd   *magicShopAd;

@property (nonatomic,strong)    NSTimer         *timer;

@property (nonatomic,copy)      NSString        *upDown;

@end

@implementation TLMainViewPostController

//宽度位320时魔店图标高度
int shop_Height_320 = 135;

//不为320时魔店图标高度
int shop_Height_other = 160;
//宽度位320时首行高度
int one_Height_320 = 327;
//不为320时首行高度
int one_Height_other = 352;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBaseDate];
    self.tabBarItem.selectedImage = [UIImage originalImageWithName:TL_MAIN_PRESS];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(-STATUS_FRAME.size.height, 0, 0, 0);
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:MAIN_TO_SHOP];
    self.tabBarController.tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar"]];
    [self RefreshControl];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [self timeOn];
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
    [self homepage_ads];
}

-(void)footerRefresh
{
    self.upDown = PAGEUP;
    [self homepage_ads];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
     [self timeOff];
}

-(NSMutableArray *)arrayFrame
{
    if (_arrayFrame == nil) {
        _arrayFrame = [NSMutableArray array];
    }
    return _arrayFrame;
}

/**
 *  广告栏提取数据
 */

-(void)homepage_ads
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,ads_Url];
    TLPersonalMeg *personMeg = [TLPersonalMegTool currentPersonalMeg];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:personMeg.user_id,TL_USER_ID,personMeg.token,TL_USER_TOKEN,limit_size,@"limit_size",nil];
    __unsafe_unretained __typeof(self) weakSelf = self;
    [TLHttpTool postWithURL:url params:dict success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            TLHomeAd *homeAd = [[TLHomeAd alloc]initWithDictionary:json[@"body"] error:nil];
            weakSelf.adArray = homeAd.top_promotion_list;
            [weakSelf setupScrollView];
            [weakSelf setupPageControl];
            [weakSelf magic_shop];
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakSelf.upDown isEqualToString:PAGEDOWN])
            {
                [weakSelf.tableView.mj_header endRefreshing];
            }else
            {
                [weakSelf.tableView.mj_footer endRefreshing];
            }
        });
    }];
}


/**
 *  增加广告栏
 */
-(void)setupScrollView
{
    CGRect rect = [UIScreen mainScreen].bounds;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame =CGRectMake(0, 0, rect.size.width, ScreenBounds.size.width*9/16);
    scrollView.delegate = self;
    //添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    
   // UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickEventOnImage:)];
    
    for (int index = 0; index < self.adArray.count; index ++) {
        
        TLHomepage_ads *ads = self.adArray[index];
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImageWithURL:ads.mobile_pic_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickEventOnImage:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tapRecognizer];
        tapRecognizer.view.tag = index;
    }
    scrollView.contentSize = CGSizeMake(imageW*self.adArray.count, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.bounces = NO;
    
}

-(void)ClickEventOnImage:(UITapGestureRecognizer *)tapRecognizer
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
    TLHomepage_ads *Homepage = self.adArray[tapRecognizer.view.tag];
    
    
    // need check the select content related_type & object_id
    if ([Homepage.object_id isEqualToString:@""]) {
        return;
    }
    
    switch ([Homepage.promotion_mode intValue]) {
        case 0:
            [self ActivityWithProd:storyboard withHomepage:Homepage];
            break;
        case 1:
            [self ActivityWithPost:storyboard withHomepage:Homepage];
            break;
        case 2:
            [self ActivityWithShop:storyboard withHomepage:Homepage];
            break;
        case 3:
            [self ActivityWithMaster:storyboard withHomepage:Homepage];
            break;
        case 4:
            {
                TLIntegrateDetailController *integrateDetailController = [[TLIntegrateDetailController alloc]init];
                integrateDetailController.homepage_ads = Homepage;
                [self.navigationController pushViewController:integrateDetailController animated:YES];
            }
            break;
        default:
            break;
    }
}


/**
 *  /活动商品
 *
 */
-(void)ActivityWithProd:(UIStoryboard *)storyboard withHomepage:(TLHomepage_ads *)Homepage
{

    if ([Homepage.coupon_flag isEqualToString:TLYES]) {
        TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
        TLProduct *product = [[TLProduct alloc]init];
        product.prod_id = Homepage.object_id;
        product.relation_id = Homepage.relation_id;
        groupPurchaseView.product = product;
        groupPurchaseView.action = prod_activity;
        [self.navigationController pushViewController:groupPurchaseView animated:YES];
    }else
    {
        TLProdPurchaseViewController *prodPurchase = [storyboard instantiateViewControllerWithIdentifier:TL_PROD_PURCHASE];
        prodPurchase.Homepageprod = Homepage;
        [self.navigationController pushViewController:prodPurchase animated:YES];
    }
}



/**
 *  /活动帖子
 *
 */
-(void)ActivityWithPost:(UIStoryboard *)storyboard withHomepage:(TLHomepage_ads *)Homepage
{
    TLPostDetailViewController *postDetail = [storyboard instantiateViewControllerWithIdentifier:TL_POST_DETAIL];
    postDetail.HomepagePost = Homepage;
    [self.navigationController pushViewController:postDetail animated:YES];
}



/**
 *
 * //活动魔店
 */
-(void)ActivityWithShop:(UIStoryboard *)storyboard withHomepage:(TLHomepage_ads *)Homepage
{
    TLMoshopViewController *MoshopView = [storyboard instantiateViewControllerWithIdentifier:TL_MOSHOP];
    MoshopView.HomepageMagicShop = Homepage;
    [self.navigationController pushViewController:MoshopView animated:YES];
}


/**
 *  /活动会员
 *
 */
-(void)ActivityWithMaster:(UIStoryboard *)storyboard withHomepage:(TLHomepage_ads *)Homepage
{
    [[NSUserDefaults standardUserDefaults] setObject:linkMaster forKey:TL_ACTION];
    TLMasterSuperViewController *masterSuper = [storyboard instantiateViewControllerWithIdentifier:TL_MASTER_SUPER];
    masterSuper.HomepageMaster = Homepage;
    [self.navigationController pushViewController:masterSuper animated:YES];
}



/**
 *  增加页码显示
 */
-(void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = self.adArray.count;
    CGFloat centerX = self.tableView.bounds.size.width * TL_PAGECONTROL_X;
    CGFloat centerY = ScreenBounds.size.width*9/16-10;//self.scrollView.bounds.size.height*TL_PAGECONTROL_Y;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, ScreenBounds.size.width, 142);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
   // pageControl.pageIndicatorTintColor = [UIColor blackColor];
}

-(NSMutableArray *)magicShop
{
    if (_magicShop == nil) {
        _magicShop = [NSMutableArray array];
    }
    return _magicShop;
}

/**
 *  魔店图片提取
 */
-(void)magic_shop
{
    [self.magicShopAd removeFromSuperview];
    TLMagicRequest *request = [[TLMagicRequest alloc]init];

    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_mstores_Url];

    __unsafe_unretained __typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:request success:^(id result) {
        weakSelf.magicShopAll = result;
        [weakSelf.magicShop removeAllObjects];
        for (TLMagicShop *shop in weakSelf.magicShopAll.mstore_list)
        {
            [weakSelf.magicShop addObject:shop];
        }
        [weakSelf create_magic_shop];
        [weakSelf setupPostData];
    } failure:^(NSError *error) {
        if ([weakSelf.upDown isEqualToString:PAGEDOWN])
        {
            [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
             [weakSelf.tableView.mj_footer endRefreshing];
        }
    } resultClass:[TLMagicShopAll class]];
    
}

/**
 *  创建图片按钮
 */
-(void)create_magic_shop
{
    if (self.magicShop.count) {
        TLMagicShopAd *magic = [[TLMagicShopAd alloc]init];
        CGFloat magicEdge = 13;
        CGFloat magicMargin = 11;
        magic.delegate = self;
        CGFloat magicW = (ScreenBounds.size.width - 2*magicEdge-3*magicMargin)/4;
        if (ScreenBounds.size.width==320) {
            magic.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), self.scrollView.frame.size.width,magicW+16+35);
        }else
        {
             magic.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), self.scrollView.frame.size.width,magicW+16+35);
        }
        magic.backgroundColor = TLColor(250, 250, 250);
        magic.magicShop = self.magicShop;
        [self.view addSubview:magic];
        self.magicShopAd = magic;
    }
}



/**
 *  增加广告栏翻页功能
 *
 *  @param scrollView 广告栏所在的scrollview
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX/scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
    
}

/**
 *  开启定时
 */
-(void)timeOn
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TLAd_Page_Time target:self selector:@selector(play) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/**
 *  关闭定时
 */
-(void)timeOff
{
    [self.timer invalidate];
    self.timer = nil;
}
/**
 *  开始动画翻页
 */
-(void)play
{
    int i = (int)(self.pageControl.currentPage);
    if (i == (self.adArray.count - 1)) {
        i = -1;
    }
    i++;
    [self.scrollView setContentOffset:CGPointMake(i*self.view.bounds.size.width, 0) animated:YES];
}
/**
 *  拖动时停止翻页
 *
 *  @param scrollView
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self timeOff];
}
/**
 *  停止拖动时，开始自动翻页
 *
 *  @param scrollView
 *  @param decelerate
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self timeOn];
}


-(void)loadBaseDate
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Url,base_data_Url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"base_data_type_json",@"",@"app_inner_no", nil];
    
    [TLHttpTool postWithURL:url params:params success:^(id json)
    {
        [NSKeyedArchiver archiveRootObject:json[@"body"] toFile:TLBaseDataFilePath];
    } failure:nil];
}


/**
 *  开始请求数据
 */
-(void)setupPostData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,friends_posts_Url];
    
    TLFriendsPostsRequest *postRequest = [[TLFriendsPostsRequest alloc]init];
    if (self.arrayFrame.count) {
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            postRequest.post_id = @"";
            postRequest.fetch_count = DownAmount;
        }else
        {
            TLPostFrame *postFrame = self.arrayFrame[self.arrayFrame.count-1];
            postRequest.post_id = postFrame.postParam.post_id;
            postRequest.fetch_count = UpAmount;
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setDictionary:postRequest.keyValues];
    __unsafe_unretained __typeof(self) weakself = self;
    [TLHttpTool postWithURL:url params:params success:^(id json) {
    
        TLFriendsPostsAll *postParamAll = [[TLFriendsPostsAll alloc]initWithDictionary:json[@"body"] error:nil];
        NSMutableArray *temp = [NSMutableArray array];
        for (TLPostParam *postParam in postParamAll.user_follow_post_list) {
            TLPostFrame *postFrame = [[TLPostFrame alloc]init];
            postFrame.postParam = postParam;
            [temp addObject:postFrame];
        }
        if ([weakself.upDown isEqualToString:PAGEDOWN]) {
            weakself.arrayFrame = temp;
           [weakself.tableView.mj_header endRefreshing];
        }else
        {
            [weakself.arrayFrame addObjectsFromArray:temp];
            [weakself.tableView.mj_footer endRefreshing];
        }
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        if ([weakself.upDown isEqualToString:PAGEDOWN])
        {
            [weakself.tableView.mj_header endRefreshing];
        }else
        {
            [weakself.tableView.mj_footer endRefreshing];
        }
    }];
    
}

-(void)JumpControllerWithMagicShopAd
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:MAIN_TO_SHOP];
    self.tabBarController.selectedIndex = 1;
}

-(void)JumpControllerWithMagicImageWithButton:(UIButton *)button
{
    [self performSegueWithIdentifier:TL_MAIN_MO_SHOP sender:self.magicShop[button.tag-1000]];
}

//跳转传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    
    if ([vc isKindOfClass:[TLMoshopViewController class]]) {
        TLMoshopViewController *moshop = vc;
        moshop.magicShop = sender;
    }else if ([vc isKindOfClass:[TLPostDetailViewController class]])
    {
        TLPostDetailViewController *postDetailView = vc;
        postDetailView.postParam = sender;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // Add code to clean up any of your own resources that are no longer necessary.
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.arrayFrame.count) {
        return self.arrayFrame.count+1;
    }else
    {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        return cell;
    }else
    {
        
        TLPostViewCell *cell = [TLPostViewCell cellWithTableView:tableView];
        cell.postFrame = self.arrayFrame[indexPath.row-1];
        cell.topView.delegate = self;
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return  (ScreenBounds.size.width - 59)/4+16+ScreenBounds.size.width*9/16+36;
    }else
    {
        TLPostFrame *postFrame = self.arrayFrame[indexPath.row-1];
        return postFrame.cellHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
    }else
    {
        TLPostFrame *postFrame = self.arrayFrame[indexPath.row-1];
        TLPostParam *postParam = postFrame.postParam;
        [self performSegueWithIdentifier:TL_MAIN_POST sender:postParam];
    }

}

-(void)postTopViewHeadImage:(TLPostTopView *)postTopView WithPostFrame:(TLPostFrame *)postframe
{
    [[NSUserDefaults standardUserDefaults] setObject:linkMaster forKey:TL_ACTION];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
    TLMasterSuperViewController *masterSuper = [storyboard instantiateViewControllerWithIdentifier:TL_MASTER_SUPER];
    [[NSUserDefaults standardUserDefaults] setObject:postframe.postParam.user_id forKey:TL_MASTER];
    [self.navigationController pushViewController:masterSuper animated:YES];
}


@end
