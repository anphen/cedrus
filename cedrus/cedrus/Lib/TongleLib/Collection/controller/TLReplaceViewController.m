//
//  TLReplaceViewController.m
//  tongle
//
//  Created by liu ruibin on 15-5-13.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLReplaceViewController.h"
#import "TLMasterSuperViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLPostFrame.h"
#import "TLPostParam.h"
#import "TLMasterPost.h"
#import "TLPostViewCell.h"
#import "TLExpert_Post.h"
#import "MJRefresh.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "MBProgressHUD+MJ.h"


@interface TLReplaceViewController ()

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,strong) NSMutableArray *arrayFrame;
@property (nonatomic,copy) NSString *expert_user_id;
@property (nonatomic,copy) NSString *UpDown;

@end

@implementation TLReplaceViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.expert_user_id = [[NSUserDefaults standardUserDefaults] objectForKey:TL_MASTER];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self RefreshControl];
}
/**
 *  配置刷新
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
//下拉刷新
-(void)headerRefresh
{
    self.UpDown = PAGEDOWN;
    [self setupPostData];
}
//上拉刷新
-(void)footerRefresh
{
    self.UpDown = PAGEUP;
    [self setupPostData];
}

//加载数据
-(void)setupPostData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,posts_user_posts_Url];
    TLExpert_Post *expert_post = [[TLExpert_Post alloc]init];
    expert_post.expert_user_id = self.expert_user_id;
    if (self.arrayFrame.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            expert_post.fetch_count = DownAmount;
            expert_post.post_id = @"";
        }else
        {
            expert_post.fetch_count = UpAmount;
            TLPostFrame *postFrame = self.arrayFrame[self.arrayFrame.count-1];
            expert_post.post_id = postFrame.postParam.post_id;
        }
    }
     __unsafe_unretained __typeof(self) weakSelf = self;
    //发送请求
    [TLBaseTool postWithURL:url param:expert_post success:^(id json) {
        TLMasterPost *result = [[TLMasterPost alloc]initWithDictionary:json[@"body"] error:nil];
        NSMutableArray *temp = [NSMutableArray array];
        for (TLPostParam *postParam in result.user_post_list) {
            TLPostFrame *postFrame = [[TLPostFrame alloc]init];
            postFrame.postParam = postParam;
            [temp addObject:postFrame];
        }
        if ([weakSelf.UpDown isEqualToString:PAGEDOWN]) {
            weakSelf.arrayFrame = temp;
             [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
            [weakSelf.arrayFrame addObjectsFromArray:temp];
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        if ([weakSelf.UpDown isEqualToString:PAGEDOWN])
        {
            [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
           [weakSelf.tableView.mj_footer endRefreshing];
        }
    }];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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

//选中跳转控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TLPostFrame *postFrame = self.arrayFrame[indexPath.row];
    TLPostParam *postParam = postFrame.postParam;
    [self.parentViewController performSegueWithIdentifier:TL_MASTER_POST sender:postParam];
}
@end
