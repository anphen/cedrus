//
//  TLSearchViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-24.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSearchViewController.h"
#import "TLNavigationBar.h"
#import "TLSearchMasterViewController.h"
#import "TLSearchPostViewController.h"
#import "TLSearchMagicShopViewController.h"
#import "TLSearchProdViewController.h"
#import "TLMoshopViewController.h"
#import "TLPostDetailViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLProdPurchaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TLSearch.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLHead.h"
#import "TLCommon.h"
#import "MBProgressHUD+MJ.h"
#import "Url.h"
#import "TLImageName.h"
#import "UIColor+TL.h"
#import "TLHttpTool.h"


@interface TLSearchViewController ()<UIScrollViewDelegate,TLNavigationBarDelegate,UITextFieldDelegate>

@property (nonatomic,weak)      UIScrollView    *marketScrollView;
@property (nonatomic,weak)      TLHead          *tabHead;
@property (nonatomic,strong)    TLSearchMagicShopViewController *searchMagicShopViewController;
@property (nonatomic,strong)    TLSearchMasterViewController    *searchMasterViewController;
@property (nonatomic,strong)    TLSearchPostViewController      *searchPostViewController;
@property (nonatomic,strong)    TLSearchProdViewController      *searchProdViewController;
@property (nonatomic,strong)    NSArray *titleArray;
@end

@implementation TLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self setUpBaseData];
    if (![self.style isEqualToString:@"发现"]) {
        [self hot_search];
    }else
    {
        [self find_search];
    }
    // Do any additional setup after loading the view.
}

-(void)setUpBaseData
{
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
}

//自定义导航栏
- (void)initNavigationBar{
    
    TLNavigationBar *navigationBar = [[TLNavigationBar alloc]init];
    if ([self.style isEqualToString:@"发现"]) {
         [navigationBar creatWithLeftButtonAndtitle:@"查找"];
         navigationBar.frame = CGRectMake(0, 0, ScreenBounds.size.width, 127);
    }else
    {
        [navigationBar creatWithLeftButtonAndtitle:@"热门"];
         navigationBar.frame = CGRectMake(0, 0, ScreenBounds.size.width, 107);
    }
    [self.view addSubview:navigationBar];
    navigationBar.Delegate = self;
    self.navigationBar = navigationBar;
    [self CreateNavigationBar];
}

-(void)tlNavigationBarBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setSearchModel:(TLSearch *)searchModel
{
    _searchModel = searchModel;
}
/**
 *  懒加载达人子控制器
 *
 *  @return 达人子控制器
 */
-(TLSearchMasterViewController *)searchMasterViewController
{
    if (_searchMasterViewController == nil) {
        _searchMasterViewController = [[TLSearchMasterViewController alloc]init];
    }
    return _searchMasterViewController;
}
/**
 *  懒加载魔店子控制器
 *
 *  @return 魔店子控制器
 */
-(TLSearchMagicShopViewController *)searchMagicShopViewController
{
    if (_searchMagicShopViewController == nil) {
        _searchMagicShopViewController = [[TLSearchMagicShopViewController alloc]init];
    }
    return _searchMagicShopViewController;
}
/**
 *  懒加载产品子控制器
 *
 *  @return 产品子控制器
 */
-(TLSearchProdViewController *)searchProdViewController
{
    if (_searchProdViewController == nil) {
        //_searchProdViewController = [[TLSearchProdViewController alloc]init];
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
        _searchProdViewController = [[TLSearchProdViewController alloc]initWithCollectionViewLayout:flowLayout];
    }
    return _searchProdViewController;
}
/**
 *  懒加载帖子子控制器
 *
 *  @return 帖子子控制器
 */
-(TLSearchPostViewController *)searchPostViewController
{
    if (_searchPostViewController == nil) {
        _searchPostViewController = [[TLSearchPostViewController alloc]init];
    }
    return _searchPostViewController;
}


-(void)CreateNavigationBar
{
    /**
     *  设置子控制器的标题
     */
    NSArray *titleArray = @[@"M号",@"M帖",@"M店",@"M品"];
    self.titleArray = titleArray;
    TLHead *tabHead = [[TLHead alloc]init];
    self.tabHead = tabHead;
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
    
    UITextField *find = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, ScreenBounds.size.width-20, 25)];
    find.borderStyle = UITextBorderStyleLine;
    find.layer.masksToBounds = YES;
    find.layer.borderColor = [[UIColor getColor:@"72c6f7"]CGColor];
    find.layer.borderWidth = 1.0f;
    find.placeholder = @"搜索";
    find.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:find];
    self.find = find;
    UIImageView *findImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:TL_SEARCH_ICON]];
    self.find.leftView = findImage;
    self.find.leftViewMode = UITextFieldViewModeAlways;
    self.find.returnKeyType = UIReturnKeySearch;
    self.find.delegate = self;
    if (![self.style isEqualToString:@"发现"]) {
        self.find.hidden = YES;
    }
}
/**
 *  对子控制器的切换
 *
 *  @param sender 被触发的按键
 */
-(void)btnClicked:(UIButton *)sender
{
     self.find.text = nil;
    CGRect frame = [UIScreen mainScreen].bounds;
    for (int i = 0; i< self.titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    int index = (int)(sender.tag-1000) ;
    
    _marketScrollView.contentOffset = CGPointMake(index*frame.size.width, 0);
}

//初始化设置

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

//创建子控制器
-(void)CreatViewControllers
{
    CGRect frame = ScreenBounds;
    /**
     设置子控制器所在scrollView
     */
    UIScrollView *marketScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationBar.bounds.size.height+1, frame.size.width, frame.size.height-(self.navigationBar.bounds.size.height+1))];
    self.marketScrollView = marketScrollView;
    _marketScrollView.showsHorizontalScrollIndicator = NO;
    _marketScrollView.showsVerticalScrollIndicator = NO;
    _marketScrollView.pagingEnabled = YES;
    _marketScrollView.delegate = self;
    _marketScrollView.contentSize = CGSizeMake(self.titleArray.count*frame.size.width, 0);
    [self.view addSubview:_marketScrollView];
    
    /**
     初始化达人子控制器
     */
    self.searchMasterViewController.user_list = self.searchModel.user_list;
    self.searchMasterViewController.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-(self.navigationBar.bounds.size.height+1));
    [self addChildViewController:self.searchMasterViewController];
     [_marketScrollView addSubview:self.searchMasterViewController.view];
    /**
     初始化帖子子控制器
     */
    self.searchPostViewController.post_list = self.searchModel.post_list;
    self.searchPostViewController.view.frame = CGRectMake( frame.size.width,0, frame.size.width, frame.size.height-(self.navigationBar.bounds.size.height+1));
    [self addChildViewController:self.searchPostViewController];
     [_marketScrollView addSubview:self.searchPostViewController.view];
    /**
     初始化魔店子控制器
     */
     self.searchMagicShopViewController.mstore_list = self.searchModel.mstore_list;
    self.searchMagicShopViewController.view.frame = CGRectMake(2*frame.size.width,0, frame.size.width, frame.size.height-(self.navigationBar.bounds.size.height+1));
    [self addChildViewController:self.searchMagicShopViewController];
    [_marketScrollView addSubview:self.searchMagicShopViewController.view];
    /**
     初始化产品子控制器
     */
    self.searchProdViewController.prod_list = self.searchModel.prod_list;
    self.searchProdViewController.view.frame = CGRectMake(3*frame.size.width,0, frame.size.width, frame.size.height-(self.navigationBar.bounds.size.height+1));
    [self addChildViewController:self.searchProdViewController];
    [_marketScrollView addSubview:self.searchProdViewController.view];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     self.find.text = nil;
    //注意。。。
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX/scrollView.frame.size.width;
    int index = (int)(pageDouble + 0.5);
    
    for (int i = 0; i< self.titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        btn.selected = NO;
    }
    UIButton *selectBtn = (UIButton *)[self.view viewWithTag:1000+index];
    selectBtn.selected = YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (self.find.text.length) {
        for (int i = 0; i< self.titleArray.count; i++) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
            if (btn.selected == YES) {
                //[MBProgressHUD showMessage:@"正在查询..."];
                self.find_type = [self findWithType:btn.titleLabel.text];
                self.find_key = self.find.text;
                
                NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,search_Url];
                
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.find_key,@"find_key",self.find_type,@"find_type", nil];
                //发送请求
                [TLHttpTool postWithURL:url params:params success:^(id json) {
                    
                    [MBProgressHUD hideHUD];
                        TLSearch *searchModel = [[TLSearch alloc]initWithDictionary:json[@"body"] error:nil];
                        if ([self.find_type isEqualToString:TL_SEARCH_MASTER])
                        {
                            self.searchMasterViewController.user_list = searchModel.user_list;
                             [self.searchMasterViewController.tableView reloadData];
                        }else if ([self.find_type isEqualToString:TL_SEARCH_POST])
                        {
                            self.searchPostViewController.post_list = searchModel.post_list;
                             [self.searchPostViewController.tableView reloadData];
                        }else if ([self.find_type isEqualToString:TL_SEARCH_SHOP])
                        {
                            self.searchMagicShopViewController.mstore_list = searchModel.mstore_list;
                            [self.searchMagicShopViewController.tableView reloadData];
                        }else
                        {
                            self.searchProdViewController.prod_list = searchModel.prod_list;
                             [self.searchProdViewController.collectionView reloadData];
                        }
                        
                        if ([self.delegate respondsToSelector:@selector(searchViewController:)]) {
                            [self.delegate searchViewController:self];
                        }
                } failure:^(NSError *error) {
                    [MBProgressHUD hideHUD];
                }];
            }
        }
           }
    return YES;
}

-(NSString *)findWithType:(NSString *)Type
{
    if ([Type isEqualToString:@"M号"]) {
        return TL_SEARCH_MASTER;
    }else if([Type isEqualToString:@"M帖"])
    {
        return TL_SEARCH_POST;
    }else if([Type isEqualToString:@"M店"])
    {
        return TL_SEARCH_SHOP;
    }else
    {
        return TL_SEARCH_PROD;
    }
}

-(void)find_search
{
        //[MBProgressHUD showMessage:@"正在查询..."];
        NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,search_Url];
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.find_key,@"find_key",@"",@"find_type", nil];
        //发送请求
        [TLHttpTool postWithURL:url params:params success:^(id json) {
            
            [MBProgressHUD hideHUD];
            TLSearch *searchModel = [[TLSearch alloc]initWithDictionary:json[@"body"] error:nil];
            self.searchModel = searchModel;
            [self CreatViewControllers];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];
}

-(void)hot_search
{
    //[MBProgressHUD showMessage:@"正在加载..."];
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,hot_search_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN, nil];
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        TLSearch *searchModel = [[TLSearch alloc]initWithDictionary:json[@"body"] error:nil];
        self.searchModel = searchModel;
        [self CreatViewControllers];
         [self jumpController];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
    
}



-(void)jumpController
{
    for (int i = 0; i< self.titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        if ([btn.titleLabel.text isEqualToString:self.style]) {
            [self btnClicked:btn];
        }
    }
}

-(BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (object==nil){
        return YES;
    }
    return NO;
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
        prodPurchase.prod_hotProd = sender;
    }
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
