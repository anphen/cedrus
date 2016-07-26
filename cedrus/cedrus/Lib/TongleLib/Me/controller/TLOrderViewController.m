//
//  TLOrderViewController.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLOrderViewController.h"
#import "TLAllOrderViewController.h"
#import "TLPendingOrderViewController.h"
#import "TLReceiveProdOrderViewController.h"
#import "TLWaitForEvaluationViewController.h"
#import "TLMyOrderDetailTableViewController.h"
#import "TLMyOrder.h"
#import "TLMyOrdersRequset.h"
#import "TLBaseTool.h"
#import "TLNavigationBar.h"
#import "TLEvaluationView.h"
#import "TLMyOrderFootViewCell.h"
#import "TLMyOrderProdEvaViewController.h"
#import "TLMeViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLOrderDetailList.h"
#import "TLMyOrderDetail.h"
#import "TLPayResultRequest.h"
#import "TLCommon.h"
#import "TLHead.h"

@interface TLOrderViewController ()<UIScrollViewDelegate,TLNavigationBarDelegate>
{
    UIScrollView *_marketScrollView;
    NSArray *_titleArray;
    TLMyOrderDetail *_myOrderDetail;
}

@end

@implementation TLOrderViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    [self CreatViewControllers];
}



//自定义导航栏  
- (void)initNavigationBar{
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, TL_NAVI_BIG_HEIGHT)];
    navigationBar.Delegate = self;
    [navigationBar creatWithLeftButtonAndtitle:@"我的订单"];
    [self.view addSubview:navigationBar];
    self.navigationBar = navigationBar;
    [self CreateNavigationBar];
}
/**
 *  自定义导航栏
 */
-(void)tlNavigationBarBack
{
    if ([self.type isEqualToString:@"提交订单"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    self.type = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxpayResult) name:@"payResult" object:nil];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"payResult" object:nil];
}


-(void)wxpayResult
{
    TLOrderDetailList *orderDetail = [[TLOrderDetailList alloc]init];
    [self performSegueWithIdentifier:TL_MYORDER_DETAIL sender:orderDetail];
}


/**
 *  创建界面切换按键
 */
-(void)CreateNavigationBar
{
    NSArray *titleArray = @[@"全部订单",@"待付款",@"待收货",@"待评价"];
    _titleArray = titleArray;
     TLHead *tabHead = [[TLHead alloc]init];
    [tabHead CreateNavigationBartitleArray:titleArray Controller:self.navigationBar];
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

    TLAllOrderViewController *allorder = [[TLAllOrderViewController alloc]init];
    allorder.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    [self addChildViewController:allorder];
     [_marketScrollView addSubview:allorder.view];
    
    TLPendingOrderViewController *PendingOrder = [[TLPendingOrderViewController alloc]init];
    PendingOrder.view.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    [self addChildViewController:PendingOrder];
    [_marketScrollView addSubview:PendingOrder.view];
    
    TLReceiveProdOrderViewController *ReceiveProdOrder = [[TLReceiveProdOrderViewController alloc]init];
    ReceiveProdOrder.view.frame = CGRectMake(2*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    [self addChildViewController:ReceiveProdOrder];
    [_marketScrollView addSubview:ReceiveProdOrder.view];
    
    TLWaitForEvaluationViewController *WaitForEvaluation = [[TLWaitForEvaluationViewController alloc]init];
    WaitForEvaluation.view.frame = CGRectMake(3*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
    [self addChildViewController:WaitForEvaluation];
    [_marketScrollView addSubview:WaitForEvaluation.view];
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


/**
 *  跳转控制器
 *
 *  @param segue
 *  @param sender
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLMyOrderDetailTableViewController class]]) {
        TLMyOrderDetailTableViewController *myOrderDetailTableView = vc;
        TLOrderDetailList *order = sender;
        myOrderDetailTableView.order_no = order.order_no;
        myOrderDetailTableView.actionType = @"";
    }else if ([vc isKindOfClass:[TLMyOrderProdEvaViewController class]])
    {
        TLMyOrderProdEvaViewController *myOrderProd = vc;
        myOrderProd.myorderList = sender;
    }
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based TLlication, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
