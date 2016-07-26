//
//  TLPostViewController.m
//  TL11
//
//  Created by liu ruibin on 15-4-17.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLPostViewController.h"
#import "TLPostParam.h"
#import "TLPostParamAll.h"
#import "TLPostFrame.h"
#import "TLPostViewCell.h"
#import "TLPostRequest.h"
#import "TLBaseTool.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "MJRefresh.h"
#import "Url.h"



@interface TLPostViewController ()

@property (nonatomic,strong) NSMutableArray *arrayFrame;
@property (nonatomic,strong) TLPostParamAll *postParamAll;
@property (nonatomic,copy) NSString *upDown;

@end

@implementation TLPostViewController

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
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self RefreshControl];
}
/**
 *  懒加载数组
 *
 *  @return 可变数组
 */
-(NSMutableArray *)arrayFrame
{
    if (_arrayFrame == nil) {
        _arrayFrame = [NSMutableArray array];
    }
    return _arrayFrame;
}

/**
 *  配置刷新控件
 */
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

/**
 *  下拉刷新
 */
-(void)headerRefresh
{
    self.upDown = PAGEDOWN;
    [self setupPostData];
}
/**
 *  上拉刷新
 */
-(void)footerRefresh
{
    self.upDown = PAGEUP;
    [self setupPostData];
}

/**
 *  请求帖子数据
 */
-(void)setupPostData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,user_posts_Url];
    TLPostRequest *postRequest = [[TLPostRequest alloc]init];
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
     __unsafe_unretained __typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:postRequest success:^(id result) {
        weakSelf.postParamAll = result;
        NSMutableArray *temp = [NSMutableArray array];
        for (TLPostParam *postParam in self.postParamAll.post_list) {
            TLPostFrame *postFrame = [[TLPostFrame alloc]init];
            postFrame.postParam = postParam;
            [temp addObject:postFrame];
        }
        if ([weakSelf.upDown isEqualToString:PAGEDOWN]) {
            weakSelf.arrayFrame = temp;
           [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
            [weakSelf.arrayFrame addObjectsFromArray:temp];
             [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        if ([weakSelf.upDown isEqualToString:PAGEDOWN])
        {
           [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
           [weakSelf.tableView.mj_footer endRefreshing];
        }
    } resultClass:[TLPostParamAll class]];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrayFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLPostViewCell *cell = [TLPostViewCell cellWithTableView:tableView];
    cell.postFrame = self.arrayFrame[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLPostFrame *postFrame = self.arrayFrame[indexPath.row];
    return postFrame.cellHeight;
}


//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLPostFrame *postFrame = self.arrayFrame[indexPath.row];
    TLPostParam *postParam = postFrame.postParam;
    [self.parentViewController performSegueWithIdentifier:TL_POST_DETAIL_S sender:postParam];
}

@end
