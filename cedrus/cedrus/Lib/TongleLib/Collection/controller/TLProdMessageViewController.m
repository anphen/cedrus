//
//  TLProdMessageViewController.m
//  tongle
//  
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdMessageViewController.h"
#import "TLProdImageViewController.h"
#import "TLProdSpecViewController.h"
#import "TLProdCommentViewController.h"
#import "TLNavigationBar.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLProdDetails.h"
#import "JSONKit.h"
#import "TLHead.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"


@interface TLProdMessageViewController ()<UIScrollViewDelegate,TLNavigationBarDelegate>
{
    UIScrollView *_marketScrollView;
    TLHead  *tabHead;
    NSArray *_titleArray;
    TLProdSpecViewController    *prodSpecViewController;
    TLProdCommentViewController *prodCommentViewController;
}
@end

@implementation TLProdMessageViewController

static int collectBool = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self setUpNavigationBar];
    [self CreatViewControllers];
}

//初始化数据
-(void)getData
{
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    self.product_id = self.prodDetails.prod_id;
    collectBool = [self.prodDetails.prod_favorited_by_me intValue] == 0? 0 : 1;
}

-(void)setUpNavigationBar
{
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, TL_NAVI_BIG_HEIGHT)];
    navigationBar.Delegate = self;
    [navigationBar creatWithLeftAndRightButtonAndtitle:@"商品信息" collectBool:collectBool];
    self.collect = (UIButton *)[navigationBar viewWithTag:100];
    [self.collect addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    self.qrcode = (UIButton *)[navigationBar viewWithTag:101];
    [self.qrcode addTarget:self action:@selector(qrcode:) forControlEvents:UIControlEventTouchUpInside];
    _collect.hidden = [_prodType intValue];
    _qrcode.hidden = [_prodType intValue];
    [self.view addSubview:navigationBar];
    [self CreateNavigationBar];
}

-(void)tlNavigationBarBack
{
    if ([self.delegate respondsToSelector:@selector(prodMessageViewController:withProdDetails:)]) {
         self.prodDetails.prod_favorited_by_me  = [NSString stringWithFormat:@"%d",collectBool];
        [self.delegate prodMessageViewController:self withProdDetails:self.prodDetails];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
}

-(void)CreateNavigationBar
{
    /**
     *  设置子控制器的标题
     */
    NSArray *titleArray = @[@"图文详情",@"规格参数",@"产品评价"];
    tabHead = [[TLHead alloc]init];
    /**
     *  创建按键
     */
    [tabHead CreateNavigationBartitleArray:titleArray Controller:self.view];
    /**
     *  设置按键对子控制器的控制
     */
    _titleArray = titleArray;
    for (UIButton *btn in tabHead.navigationImageView.subviews) {
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)btnClicked:(UIButton *)sender
{
    CGRect frame = [UIScreen mainScreen].bounds;
    for (int i = 0; i< _titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    int index = (int)(sender.tag-1000) ;
    _marketScrollView.contentOffset = CGPointMake(index*frame.size.width, 0);
}


-(void)CreatViewControllers
{
    
    CGRect frame = [UIScreen mainScreen].bounds;
    /**
     初始化子控制器
     */
    TLProdImageViewController *prodImageViewController = [[TLProdImageViewController alloc]init];
    prodImageViewController.view.frame = CGRectMake(0,0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    
    /**
     设置子控制器所在scrollView
     */
    _marketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TL_NAVI_BIG_HEIGHT+1, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1)];
    _marketScrollView.showsHorizontalScrollIndicator = NO;
    _marketScrollView.showsVerticalScrollIndicator = NO;
    _marketScrollView.pagingEnabled = YES;
    _marketScrollView.delegate = self;
    
    [self addChildViewController:prodImageViewController];
    [_marketScrollView addSubview:prodImageViewController.view];
    _marketScrollView.contentSize = CGSizeMake(_titleArray.count*frame.size.width, 0);
    [self.view addSubview:_marketScrollView];
    [self jumpController];
    
}

-(void)jumpController
{
    for (int i = 0; i< _titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        if ([btn.titleLabel.text isEqualToString:self.type]) {
            [self btnClicked:btn];
        }
    }
}


-(void)createSubControllerWithIndex:(double)index frame:(CGRect)frame
{
    if (index == 1) {
        if (prodSpecViewController == nil) {
            prodSpecViewController = [[TLProdSpecViewController alloc]init];
            prodSpecViewController.view.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
            [self addChildViewController:prodSpecViewController];
            [_marketScrollView addSubview:prodSpecViewController.view];
        }
    }
    
    if (index ==2) {
        if (prodCommentViewController == nil) {
            prodCommentViewController = [[TLProdCommentViewController alloc]init];
            prodCommentViewController.view.frame = CGRectMake(2*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
            [self addChildViewController:prodCommentViewController];
            [_marketScrollView addSubview:prodCommentViewController.view];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX/scrollView.frame.size.width;
    int index = (int)(pageDouble + 0.5);
    
    for (int i = 0; i< _titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        btn.selected = NO;
    }
    UIButton *selectBtn = (UIButton *)[self.view viewWithTag:1000+index];
    selectBtn.selected = YES;
    [self createSubControllerWithIndex:index frame:frame];
    
}


//收藏
-(void)collect:(UIButton *)btn
{

        __unsafe_unretained __typeof(self) weakSelf = self;
        if (collectBool) {
            NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,add_Url];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:TL_COLLECT_TYPE_PROD,@"collection_type",self.product_id,@"key_value", nil];
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:dict];
            //NSString *jsonCollect = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
            
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",temp,@"favorites_list_json",self.token,TL_USER_TOKEN,self.prodDetails.relation_id,@"relation_id", nil];
            [TLHttpTool postWithURL:url params:param success:^(id json) {
                collectBool = 0;
                [weakSelf selectImage];
                [MBProgressHUD showSuccess:TL_COLLECT_SUCCESS];
            } failure:nil];
        }else
        {
            NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,remove_Url];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.product_id,@"key_value",TL_COLLECT_TYPE_PROD,@"collection_type",self.token,TL_USER_TOKEN, nil];
            [TLHttpTool postWithURL:url params:param success:^(id json) {
                collectBool = 1;
                [weakSelf selectImage];
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
    btn.enabled = NO;
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = self.view.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallimg) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    [self.view addSubview:cover];
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,product_show_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.product_id, @"prod_id",self.prodDetails.relation_id,@"relation_id",nil];
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    //发送请
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        
        UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:BARCODE_BG]];
        [weakSelf.view addSubview:backImage];
        weakSelf.backImage = backImage;
        backImage.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
        
        UIImageView *qrcode = [[UIImageView alloc]init];
        [qrcode setImageWithURL:json[@"body"][@"prod_qr_code_url"] placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
        qrcode.center = CGPointMake(cover.frame.size.width/2, cover.frame.size.height/2);
        [weakSelf.view addSubview:qrcode];
        weakSelf.qrcodeImage = qrcode;
        [weakSelf.view bringSubviewToFront:qrcode];
        
        [UIView animateWithDuration:0.25 animations:^{
            cover.alpha = 0.5;
            //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"collect__normal" ] forBarMetrics:UIBarMetricsCompact];
            CGFloat iconWH = TL_QRCODE_WH;
            
            CGFloat iconX = (cover.frame.size.width - iconWH)/2;
            CGFloat iconY = (cover.frame.size.height - iconWH)/2;
            qrcode.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
            
            backImage.bounds = CGRectMake(0, 0, ScreenBounds.size.width-20, ScreenBounds.size.width-20);
            backImage.center = qrcode.center;
        }];
        
        
    } failure:nil];
}

-(void)smallimg
{
     __unsafe_unretained __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf.cover removeFromSuperview];
        [weakSelf.qrcodeImage removeFromSuperview];
        weakSelf.cover = nil;
        weakSelf.collect.alpha = 1;
        weakSelf.collect.enabled = YES;
        weakSelf.qrcode.alpha = 1;
        weakSelf.qrcode.enabled = YES;
       [weakSelf.backImage removeFromSuperview];
    }];
}

-(void)setProdType:(NSString *)prodType
{
    _prodType = prodType;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
