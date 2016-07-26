//
//  TLProfitViewController.m
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLProfitViewController.h"
#import "TLProfitCurveViewController.h"
#import "TLBalanceCurveViewController.h"
#import "TLIntegralCurveViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "JSONKit.h"
#import "TLMy_Income.h"
#import "TLNavigationBar.h"
#import "TLCommon.h"
#import "TLHead.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"

@interface TLProfitViewController ()<UIScrollViewDelegate,TLNavigationBarDelegate>
{
    UIScrollView *_marketScrollView;
    NSArray *_titleArray;
}

@end

@implementation TLProfitViewController

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
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    [self setUpData];
}



//自定义导航栏

- (void)initNavigationBar{
    
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, TL_NAVI_BIG_HEIGHT)];
      [navigationBar creatWithLeftButtonAndtitle:@"我的收益"];
    
    navigationBar.Delegate = self;
    [self.view addSubview:navigationBar];
    self.navigationBar = navigationBar;
    [self CreateNavigationBar];
}

-(void)tlNavigationBarBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)CreateNavigationBar
{
    NSArray *titleArray = @[@"收益分析",@"账户余额",@"积分"];
    _titleArray = titleArray;
    TLHead *tabHead = [[TLHead alloc]init];
    [tabHead CreateNavigationBartitleArray:titleArray Controller:self.view];
    for (UIButton *btn in tabHead.navigationImageView.subviews) {
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    TLProfitCurveViewController *profit = [[TLProfitCurveViewController alloc]init];
    TLBalanceCurveViewController *balance = [[TLBalanceCurveViewController alloc]init];
    TLIntegralCurveViewController *integral = [[TLIntegralCurveViewController alloc]init];
    _marketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TL_NAVI_BIG_HEIGHT+1, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1)];
    _marketScrollView.showsHorizontalScrollIndicator = NO;
    _marketScrollView.showsVerticalScrollIndicator = NO;
    _marketScrollView.pagingEnabled = YES;
    _marketScrollView.delegate = self;
    _marketScrollView.contentSize = CGSizeMake(_titleArray.count*frame.size.width, 0);
    NSArray * array = @[profit,balance,integral];
    
    for (int i = 0; i<array.count; i++) {
        UIViewController *controllersuber = array[i];
        controllersuber.view.frame = CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1);
        [self addChildViewController:controllersuber];
        [_marketScrollView addSubview:controllersuber.view];
    }
    [self.view addSubview:_marketScrollView];
    

}

-(void)setUpData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,incomes_Url];
    NSArray *temp = [NSArray array];
    temp = @[@{@"income_type":TL_CONSUMPTION_INTEGRAL},@{@"income_type":TL_INTEGRAL_REBATE},@{@"income_type":TL_ACCOUNT_BALANCE}];
    
    NSDictionary *list =  [NSDictionary dictionaryWithObjectsAndKeys:temp,@"types", nil];
    
    
    self.json = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:list options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    
    NSDictionary *paramDay = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,TL_DAY,@"period_type",self.json,@"income_type_list", nil];
    
     NSDictionary *paramWeek = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,TL_WEEK,@"period_type",self.json,@"income_type_list", nil];
    
    
     NSDictionary *paramMon = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,TL_MOON,@"period_type",self.json,@"income_type_list", nil];
    
     NSDictionary *paramYear = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,TL_YEAR,@"period_type",self.json,@"income_type_list", nil];
    
    dispatch_queue_t queue = dispatch_queue_create("qingqiu", DISPATCH_QUEUE_SERIAL);
    MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在加载数据..."];
    hud.dimBackground = NO;
    dispatch_sync(queue, ^{
        //[MBProgressHUD showMessage:@"正在加载数据..."];
        [TLHttpTool postWithURL:url params:paramDay success:^(id json) {
            TLMy_Income *my_income = [TLMy_Income objectWithKeyValues:json[@"body"]];
            [NSKeyedArchiver archiveRootObject:my_income toFile:TLMyDayFilePath];
           // [self CreatViewControllers];
        } failure:nil];
        
        [TLHttpTool postWithURL:url params:paramWeek success:^(id json) {
            TLMy_Income *my_income = [TLMy_Income objectWithKeyValues:json[@"body"]];
            [NSKeyedArchiver archiveRootObject:my_income toFile:TLMyWeekFilePath];
        } failure:nil];
        
        [TLHttpTool postWithURL:url params:paramMon success:^(id json) {
            TLMy_Income *my_income = [TLMy_Income objectWithKeyValues:json[@"body"]];
            [NSKeyedArchiver archiveRootObject:my_income toFile:TLMyMonFilePath];
        } failure:nil];

        
        [TLHttpTool postWithURL:url params:paramYear success:^(id json) {
            TLMy_Income *my_income = [TLMy_Income objectWithKeyValues:json[@"body"]];
            [NSKeyedArchiver archiveRootObject:my_income toFile:TLMyYearFilePath];
            [MBProgressHUD hideHUD];
            [self CreatViewControllers];
        } failure:nil];

    });
}

/**
 *  创建切换视图
 *
 *  @param  scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
