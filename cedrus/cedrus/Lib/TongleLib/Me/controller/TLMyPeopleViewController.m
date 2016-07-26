//
//  TLMyPeopleViewController.m
//  TL11
//
//  Created by liu on 15-4-12.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMyPeopleViewController.h"
//#import "TLMyAttentionViewController.h"
#import "TLMasterViewController.h"
#import "TLMyVermicelliViewController.h"
#import "TLNavigationBar.h"
#import "TLMasterSuperViewController.h"
#import "TLCommon.h"
#import "TLHead.h"

@interface TLMyPeopleViewController ()<TLNavigationBarDelegate,UIScrollViewDelegate>
{
    UIScrollView *_marketScrollView;
    NSArray *_titleArray;
}

@end

@implementation TLMyPeopleViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, TL_NAVI_BIG_HEIGHT)];
    navigationBar.Delegate = self;
    [navigationBar creatWithLeftButtonAndtitle:@"我的人脉圈"];
    [self.view addSubview:navigationBar];
    self.navigationBar = navigationBar;
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

-(void)CreateNavigationBar
{
    
    NSArray *titleArray = @[@"我的关注",@"我的粉丝"];
    _titleArray = titleArray;
    TLHead *tabHead = [[TLHead alloc]init];
    [tabHead CreateNavigationBartitleArray:titleArray Controller:self.view];
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
    TLMasterViewController *master = [[TLMasterViewController alloc]init];
    TLMyVermicelliViewController *vermicelli = [[TLMyVermicelliViewController alloc]init];

    _marketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TL_NAVI_BIG_HEIGHT+1, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1)];
    _marketScrollView.showsHorizontalScrollIndicator = NO;
    _marketScrollView.showsVerticalScrollIndicator = NO;
    _marketScrollView.delegate = self;
    _marketScrollView.pagingEnabled = YES;
    NSArray * array = @[master,vermicelli];
    
    for (int i = 0; i<array.count; i++) {
        UIViewController *controllersuber = array[i];
        controllersuber.view.frame = CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1-self.tabBarController.tabBar.bounds.size.height);
        [self addChildViewController:controllersuber];
        [_marketScrollView addSubview:controllersuber.view];
    }
      _marketScrollView.contentSize = CGSizeMake(_titleArray.count*frame.size.width, 0);
    [self.view addSubview:_marketScrollView];
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


//跳转传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    
    if ([vc isKindOfClass: [TLMasterSuperViewController class]])
    {
        TLMasterSuperViewController *master = vc;
        master.master = sender;
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
