//
//  TLPostDetailViewController.m
//  tongle
//
//  Created by liu ruibin on 15-5-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLPostDetailViewController.h"
#import "TLProdPurchaseViewController.h"
#import "TLMoshopViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLPostParam.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLPostDetail.h"
#import "TLpostDetailScrollView.h"
#import "TLpostDetailFrame.h"
#import "TLPostDetailViewCell.h"
#import "TLPostDetailContent.h"
#import "UIBarButtonItem+TL.h"
#import "JSONKit.h"
#import "TLShareView.h"
#import <ShareSDK/ShareSDK.h>
#import "TLQrdata.h"
#import "TLHomepage_ads.h"
#import "TLMasterParam.h"
#import "TLCommon.h"
#import "TLHttpTool.h"
#import "Url.h"
#import "TLImageName.h"
#import "MBProgressHUD+MJ.h"
#import "TLMoshopAd.h"
#import "TLGroupPurchaseViewController.h"
#import "TLProduct.h"
#import "TLGroupCouponVoucher.h"


@interface TLPostDetailViewController ()<UITableViewDelegate,UITableViewDataSource,TLShareViewDelegate,postDetailScrollViewdelegate,TLPostDetailContentDelegate,TLPostDetailViewCellDelagate>

@property (nonatomic,strong) TLpostDetailFrame      *postDetailFrame;
@property (nonatomic,strong) TLpostDetailScrollView *postDetail;
@property (nonatomic,weak)   UITableView            *tableView;
@property (nonatomic,weak)   TLShareView            *shareView;
@property (nonatomic,weak)   UIView                 *blackView;
@property (nonatomic,assign) CGFloat                height;

@end

@implementation TLPostDetailViewController


static int collectBool = 0;
static int shareBool = 0;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setData];
    [self AddRigthButton];
    [self loadDate];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
//设置基本数据
-(void)setData
{
    int back_Image_WH = 25;
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = ScreenBounds;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    self.user_nick_name = self.postParam.first_user_nick_name;
    self.navigationItem.title = self.user_nick_name;
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, back_Image_WH, back_Image_WH);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:btn];

    self.navigationItem.leftBarButtonItem = leftButton;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
}
//返回
-(void)back
{
    if (self.qrdata == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//    
//}


-(void)setPostParam:(TLPostParam *)postParam
{
    _postParam = postParam;
    self.post_id = self.postParam.post_id;
}


-(void)setQrdata:(TLQrdata *)qrdata
{
    _qrdata = qrdata;
    self.post_id = self.qrdata.post_id;
}

-(void)setHomepagePost:(TLHomepage_ads *)HomepagePost
{
    _HomepagePost = HomepagePost;
    self.post_id = HomepagePost.object_id;

}
-(void)setAd:(TLMoshopAd *)ad
{
    _ad = ad;
    self.post_id = ad.object_id;
}

-(void)setGroupCouponVoucher:(TLGroupCouponVoucher *)groupCouponVoucher
{
    _groupCouponVoucher = groupCouponVoucher;
    self.post_id = groupCouponVoucher.voucher_link_info.link_id;
}


-(UIView *)blackView
{
    if (_blackView == nil) {
        _blackView = [[UIApplication sharedApplication].windows lastObject];
    }
    return _blackView;
}


-(void)AddRigthButton
{
    UIBarButtonItem *rigthBtn = [UIBarButtonItem rigthButtonItemWithCollectBool:collectBool];
    self.collect = (UIButton *)[[rigthBtn customView] viewWithTag:100];
    [self.collect addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchDown];
    self.share = (UIButton *)[[rigthBtn customView] viewWithTag:101];
    NSString *share = shareBool? TL_SHARE_DISABLE : TL_SHARE_NORMAL;
    [self.share setImage:[UIImage imageNamed:share] forState:UIControlStateNormal];
    [self.share setImage:[UIImage imageNamed:TL_SHARE_PRESS]forState:UIControlStateHighlighted];
    [self.share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = rigthBtn;
}

-(void)collect:(UIButton *)btn
{
    __unsafe_unretained __typeof(self)  weakself = self;
    if (collectBool) {
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,add_Url];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:TL_COLLECT_TYPE_POST,@"collection_type",self.post_id,@"key_value", nil];
        NSArray *temp = @[dict];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",temp,@"favorites_list_json",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN, nil];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            collectBool = 0;
            [weakself selectImage];
            [MBProgressHUD showSuccess:TL_COLLECT_SUCCESS];
        } failure:nil];
    }else
    {
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,remove_Url];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.post_id,@"key_value",TL_COLLECT_TYPE_POST,@"collection_type",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN, nil];
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
-(void)share:(UIButton *)btn
{

    UIButton *cover = [[UIButton alloc]init];
    cover.frame = ScreenBounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    [self.view addSubview:cover];
    self.share.enabled = NO;
    [self createShareView];
    [UIView animateWithDuration:0.25 animations:^{
            cover.alpha = 0.5;
        self.shareView.frame = CGRectMake(20, 100, ScreenBounds.size.width-40, self.shareView.height+10);
    }];
}

-(void)createShareView
{
    TLShareView *shareView = [TLShareView share];
  //  UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    shareView.frame = CGRectMake(ScreenBounds.size.width/2, ScreenBounds.size.height/2, 10, 10);
    shareView.title = self.postDetailFrame.postDetail.user_post_info.post_title;
    shareView.delegate = self;
    shareView.parent_post_id = self.post_id;
    shareView.type_post_prod  = @"帖子转发";
    [self.view addSubview:shareView];
    self.shareView = shareView;
    [self.view bringSubviewToFront:shareView];
    

}

-(void)smallimg
{
    __unsafe_unretained __typeof(self)  weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakself.cover removeFromSuperview];
        [weakself.shareView removeFromSuperview];
        weakself.cover = nil;
        weakself.collect.alpha = 1;
        weakself.collect.enabled = YES;
        weakself.share.alpha = 1;
        weakself.share.enabled = YES;
    }];
}


-(void)TLShareViewCanelButton
{
    [self smallimg];
}

-(void)loadDate
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,post_show_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.post_id,@"post_id", nil];
    __unsafe_unretained __typeof(self)  weakself = self;
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        TLPostDetail *postDetail = [[TLPostDetail alloc]initWithDictionary:json[@"body"] error:nil];
        weakself.navigationItem.title = postDetail.user_post_info.first_user_nick_name;
        collectBool =  [postDetail.user_post_info.post_favorited_by_me intValue];
        [weakself selectImage];
        TLpostDetailFrame *frame = [[TLpostDetailFrame alloc]init];
        frame.postDetail = postDetail;
        weakself.postDetailFrame = frame;
        [weakself creatPostDetail];
        [weakself.tableView reloadData];
    } failure:nil];
}

-(void)creatPostDetail
{
    TLpostDetailScrollView *postDetail = [[TLpostDetailScrollView alloc]init];
    postDetail.postDetailFrame = self.postDetailFrame;
    self.tableView.contentInset = UIEdgeInsetsMake(self.postDetailFrame.height +64, 0, 0, 0);
    postDetail.frame = CGRectMake(0, -self.postDetailFrame.height,  ScreenBounds.size.width,self.postDetailFrame.height);
    [self.tableView addSubview:postDetail];
    postDetail.delegate = self;
}

-(void)postDetailScrollView:(TLpostDetailScrollView *)postDetailScrollView withcode:(UIButton *)button
{
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = ScreenBounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    [self.blackView addSubview:cover];
    
    self.share.enabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.5;
        //self.shareView.frame = CGRectMake(20, 100, ScreenBounds.size.width-40, self.shareView.height+10);
    }];
}

-(void)postDetailScrollView:(TLpostDetailScrollView *)postDetailScrollView withGesture:(UITapGestureRecognizer *)Gesture
{
    [[NSUserDefaults standardUserDefaults] setObject:linkMaster forKey:TL_ACTION];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
    TLMasterSuperViewController *masterSuper = [storyboard instantiateViewControllerWithIdentifier:TL_MASTER_SUPER];
     [[NSUserDefaults standardUserDefaults] setObject:self.postDetailFrame.postDetail.user_post_info.first_user_id forKey:TL_MASTER];
    [self.navigationController pushViewController:masterSuper animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.postDetailFrame.postDetail.user_post_info.post_content.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLPostDetailViewCell *cell = [TLPostDetailViewCell cellWithTableView:tableView];
    cell.postContent = self.postDetailFrame.postDetail.user_post_info.post_content[indexPath.row];
    //cell.postView.delegate  = self;
    cell.delagate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.height = cell.height;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLPostContent *postContent = self.postDetailFrame.postDetail.user_post_info.post_content[indexPath.row];
    
    // need check the select content related_type & object_id
    if ([postContent.related_type isEqualToString:@""] || [postContent.object_id isEqualToString:@""]) {
        return;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
    switch ([postContent.related_type intValue]) {
        case 0:
            [self ActivityWithProd:storyboard withPostContent:postContent];
            break;
        case 1:
            [self ActivityWithPost:storyboard withPostContent:postContent];
            break;
        case 2:
            [self ActivityWithShop:storyboard withPostContent:postContent];
            break;
        case 3:
            [self ActivityWithMaster:storyboard withPostContent:postContent];
            break;
        default:
            break;
    }
}

/**
 *  /活动商品
 *
 */
-(void)ActivityWithProd:(UIStoryboard *)storyboard withPostContent:(TLPostContent *)postContent
{
    if ([postContent.coupon_flag isEqualToString:TLYES]) {
        TLGroupPurchaseViewController *groupPurchaseView = [[TLGroupPurchaseViewController alloc]init];
        TLProduct *product = [[TLProduct alloc]init];
        product.prod_id = postContent.object_id;
        product.relation_id = postContent.relation_id;
        groupPurchaseView.product = product;
        groupPurchaseView.action = prod_post;
        [self.navigationController pushViewController:groupPurchaseView animated:YES];
    }else
    {
        TLProdPurchaseViewController *prodPurchase = [storyboard instantiateViewControllerWithIdentifier:TL_PROD_PURCHASE];
        prodPurchase.postContent = postContent;
        [self.navigationController pushViewController:prodPurchase animated:YES];
    }
}

/**
 *  /活动帖子
 *
 */
-(void)ActivityWithPost:(UIStoryboard *)storyboard withPostContent:(TLPostContent *)postContent
{
    TLPostDetailViewController *postDetail = [storyboard instantiateViewControllerWithIdentifier:TL_POST_DETAIL];
    postDetail.post_id = postContent.object_id;
    [self.navigationController pushViewController:postDetail animated:YES];
}



/**
 *
 * //活动魔店
 */
-(void)ActivityWithShop:(UIStoryboard *)storyboard withPostContent:(TLPostContent *)postContent
{
    TLMoshopViewController *MoshopView = [storyboard instantiateViewControllerWithIdentifier:TL_MOSHOP];
    MoshopView.mstore_id = postContent.object_id;
    [self.navigationController pushViewController:MoshopView animated:YES];
}


/**
 *  /活动会员
 *
 */
-(void)ActivityWithMaster:(UIStoryboard *)storyboard withPostContent:(TLPostContent *)postContent
{
    [[NSUserDefaults standardUserDefaults] setObject:linkMaster forKey:TL_ACTION];
    TLMasterSuperViewController *masterSuper = [storyboard instantiateViewControllerWithIdentifier:TL_MASTER_SUPER];
    masterSuper.postContent = postContent;
    [self.navigationController pushViewController:masterSuper animated:YES];
}

-(void)postDetailViewCell:(TLPostDetailViewCell *)postDetailViewCell
{
     [self.tableView reloadData];
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
        // Dispose of any resources that can be recreated.
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
