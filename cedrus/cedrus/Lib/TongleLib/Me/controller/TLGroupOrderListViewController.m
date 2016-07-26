//
//  TLGroupCouponsOrderViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/17.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupOrderListViewController.h"
#import "TLGroupOrderAllListViewController.h"
#import "TLGroupOrderUnusedListViewController.h"
#import "TLGroupOrderRefundViewController.h"
#import "TLImageName.h"
#import "TLHead.h"
#import "TLNavigationBar.h"
#import "TLCommon.h"

@interface TLGroupOrderListViewController ()<TLNavigationBarDelegate,UIScrollViewDelegate>
{
    UIScrollView *_marketScrollView;
    NSArray *_titleArray;
    TLNavigationBar *_navigationBar;
}
@end

@implementation TLGroupOrderListViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self CreatViewControllers];
    // Do any additional setup after loading the view.
}


//自定义导航栏
- (void)initNavigationBar{
    [self.navigationController setNavigationBarHidden:YES];
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, TL_NAVI_BIG_HEIGHT)];
    navigationBar.Delegate = self;
    [navigationBar creatWithLeftButtonAndtitle:@"团购订单"];
    [self.view addSubview:navigationBar];
    _navigationBar = navigationBar;
    [self CreateNavigationBar];
}
/**
 *  自定义导航栏
 */
-(void)tlNavigationBarBack
{
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


/**
 *  创建界面切换按键
 */
-(void)CreateNavigationBar
{
    NSArray *titleArray = @[@"全部",@"未消费",@"退款单"];
    _titleArray = titleArray;
    TLHead *tabHead = [[TLHead alloc]init];
    [tabHead CreateNavigationBartitleArray:titleArray Controller:_navigationBar];
    for (UIButton *btn in tabHead.navigationImageView.subviews) {
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}


/**
 *  点击界面切换按键
 *
 *  @param sender
 */
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


/**
 *  加载子控制器
 */
-(void)createSubController
{
    CGRect frame = [UIScreen mainScreen].bounds;
    
    TLGroupOrderAllListViewController *allorder = [[TLGroupOrderAllListViewController alloc]init];
    allorder.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    [self addChildViewController:allorder];
    [_marketScrollView addSubview:allorder.view];
    
    TLGroupOrderUnusedListViewController *unusedOrder = [[TLGroupOrderUnusedListViewController alloc]init];
    unusedOrder.view.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    [self addChildViewController:unusedOrder];
    [_marketScrollView addSubview:unusedOrder.view];
    
    TLGroupOrderRefundViewController *refundProdOrder = [[TLGroupOrderRefundViewController alloc]init];
    refundProdOrder.view.frame = CGRectMake(2*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    [self addChildViewController:refundProdOrder];
    [_marketScrollView addSubview:refundProdOrder.view];

}



/**
 *  创建默认控制器
 */
-(void)CreatViewControllers
{
    CGRect frame = [UIScreen mainScreen].bounds;
    
    _marketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TL_NAVI_BIG_HEIGHT+1, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1)];
    _marketScrollView.showsHorizontalScrollIndicator = NO;
    _marketScrollView.showsVerticalScrollIndicator = NO;
    _marketScrollView.delegate = self;
    _marketScrollView.pagingEnabled = YES;
    _marketScrollView.contentSize = CGSizeMake(_titleArray.count*frame.size.width, 0);
    [self createSubController];
    [self.view addSubview:_marketScrollView];
}



/**
 *  创建切换视图
 *
 *  @param  scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //CGRect frame = ScreenBounds;
    //注意。。。
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX/scrollView.frame.size.width;
    int index = (int)(pageDouble + 0.5);
    
    for (int i = 0; i< _titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        btn.selected = NO;
    }
    UIButton *selectBtn = (UIButton *)[self.view viewWithTag:1000+index];
    selectBtn.selected = YES;
    
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

@end
