//
//  TLCollectViewController.m
//
//  Created by liu ruibin on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLCollectViewController.h"
#import "TLMasterViewController.h"
#import "TLMagicShopViewController.h"
//#import "TLProductsViewController.h"
#import "TLProdCollectionViewController.h"
#import "TLPostViewController.h"
#import "TLMainViewPostController.h"
#import "TLMasterSuperViewController.h"
#import "TLMagicShopAd.h"
#import "TLMoshopViewController.h"
#import "TLPostDetailViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLProdPurchaseViewController.h"
#import "TLNavigationBar.h"
#import "TLHead.h"
#import "TLImageName.h"
#import "TLCommon.h"
#import "UIImage+TL.h"

@interface TLCollectViewController ()<UIScrollViewDelegate>

{
    UIScrollView *_marketScrollView;
    TLHead *tabHead;
    NSArray *_titleArray;
    //初始化为空
    TLPostViewController *postViewController;
    TLMagicShopViewController *magicShopViewController;
    TLProdCollectionViewController *prodCollectionViewController ;

}

@end

@implementation TLCollectViewController

////初始化为空
//static TLPostViewController *postViewController = nil;
//static TLMagicShopViewController *magicShopViewController = nil;
//static TLProductsViewController *productsViewController = nil;



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.tabBarItem.selectedImage = [UIImage originalImageWithName:TL_COLLECT_PRESS];
    [self initNavigationBar];
    [self CreatViewControllers];
    
}

//自定义导航栏
- (void)initNavigationBar{
    
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, TL_NAVI_BIG_HEIGHT)];
    [navigationBar creatWithTitle:@"收藏"];
    [self.view addSubview:navigationBar];
    [self CreateNavigationBar];
    
}




//初始化设置

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES];
    CGRect frame = [UIScreen mainScreen].bounds;
    for (UIButton *btn in tabHead.navigationImageView.subviews) {
        if (btn.selected == YES) {
            int index = (int)(btn.tag-1000) ;
            _marketScrollView.contentOffset = CGPointMake(index*frame.size.width, 0);
        }
    }
    [self jumpShop];
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
    NSArray *titleArray = @[@"M号",@"M帖",@"M店",@"M品"];
    tabHead = [[TLHead alloc]init];
    /**
     *  创建按键
     */
    [tabHead CreateNavigationBartitleArray:titleArray Controller:self.view];
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
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    int index = (int)(sender.tag-1000) ;

    _marketScrollView.contentOffset = CGPointMake(index*frame.size.width, 0);
}
//懒加载子控制器
-(void)createSubControllerWithIndex:(double)index frame:(CGRect)frame
{
    if (index > 0 && index <= 1) {
        if (postViewController == nil) {
            postViewController = [[TLPostViewController alloc]init];
            postViewController.view.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1-self.tabBarController.tabBar.frame.size.height);
            [self addChildViewController:postViewController];
            [_marketScrollView addSubview:postViewController.view];
        }
    }
    
    if (index > 1&& index <=2) {
        if (magicShopViewController == nil) {
            magicShopViewController = [[TLMagicShopViewController alloc]init];
            magicShopViewController.view.frame = CGRectMake(2*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1-self.tabBarController.tabBar.frame.size.height);
            [self addChildViewController:magicShopViewController];
            [_marketScrollView addSubview:magicShopViewController.view];
        }
    }
    
    if (index > 2&& index <=3) {
        if (prodCollectionViewController == nil) {
            UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
            prodCollectionViewController = [[TLProdCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];

            prodCollectionViewController.view.frame = CGRectMake(3*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1-self.tabBarController.tabBar.frame.size.height);
            [self addChildViewController:prodCollectionViewController];
            [_marketScrollView addSubview:prodCollectionViewController.view];
        }
    }
}

//创建子控制器
-(void)CreatViewControllers
{
    
     CGRect frame = ScreenBounds;
    /**
     初始化子控制器
     */
    TLMasterViewController *masterV = [[TLMasterViewController alloc]init];
    masterV.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1-self.tabBarController.tabBar.frame.size.height);

    /**
     设置子控制器所在scrollView
     */
    _marketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TL_NAVI_BIG_HEIGHT+1, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1-self.tabBarController.tabBar.frame.size.height)];
    _marketScrollView.showsHorizontalScrollIndicator = NO;
    _marketScrollView.showsVerticalScrollIndicator = NO;
    _marketScrollView.pagingEnabled = YES;
    _marketScrollView.delegate = self;
   // NSArray * array = @[bigV,post,magicShop,products];

    _marketScrollView.contentSize = CGSizeMake(_titleArray.count*frame.size.width, 0);
    [_marketScrollView addSubview:masterV.view];
    [self.view addSubview:_marketScrollView];
    [self addChildViewController:masterV];
    [self jumpShop];
    
}

-(void)jumpShop
{
      CGRect frame = ScreenBounds;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:MAIN_TO_SHOP]) {
        if (magicShopViewController == nil) {
            magicShopViewController = [[TLMagicShopViewController alloc]init];
            magicShopViewController.view.frame = CGRectMake(2*frame.size.width, 0, frame.size.width, frame.size.height-TL_NAVI_BIG_HEIGHT-1-self.tabBarController.tabBar.frame.size.height);
            [self addChildViewController:magicShopViewController];
            [_marketScrollView addSubview:magicShopViewController.view];
        }
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+2];
        [self btnClicked:btn];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:MAIN_TO_SHOP];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

    CGRect frame = ScreenBounds;
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
    [self createSubControllerWithIndex:index frame:frame];
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
        TLPostDetailViewController *postdetail = vc;
        postdetail.postParam = sender;
    }else if ([vc isKindOfClass: [TLMasterSuperViewController class]])
    {
        TLMasterSuperViewController *master = vc;
        master.master = sender;
    }else if ([vc isKindOfClass:[TLProdPurchaseViewController class]])
    {
        TLProdPurchaseViewController *prodPurchase = vc;
        prodPurchase.product = sender;
    }
}



- (void)didReceiveMemoryWarning
{
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
