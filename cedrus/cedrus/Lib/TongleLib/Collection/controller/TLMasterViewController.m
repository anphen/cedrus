//
//  TLBigVViewController.m
//  TL11
//
//  Created by liu ruibin on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMasterViewController.h"
#import "TLMasterViewCell.h"
#import "TLMasterRequest.h"
#import "TLBaseTool.h"
#import "TLMasterAllParam.h"
#import "MJExtension.h"
#import "TLMasterParam.h"
#import "TLCollectViewController.h"
#import "TLMyPeopleViewController.h"
#import "MJRefresh.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLLandViewController.h"


@interface TLMasterViewController ()

@property (nonatomic,strong) NSMutableArray *master;
@property (nonatomic,strong) TLMasterAllParam *allparam;
@property (nonatomic,copy) NSString *upDown;

@end

@implementation TLMasterViewController

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
    self.tableView.rowHeight = 68;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self RefreshControl];

}

-(NSMutableArray *)master
{
    if (_master == nil) {
        _master = [NSMutableArray array];
    }
    return _master;
}

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

-(void)headerRefresh
{
    self.upDown = PAGEDOWN;
    [self loadStatuses];
}

-(void)footerRefresh
{
    self.upDown = PAGEUP;
    [self loadStatuses];
}
//加载数据

-(void)loadStatuses
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,friends_Url];
    
    TLMasterRequest *request = [[TLMasterRequest alloc]init];
    if (self.master.count) {
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            request.expert_user_id = @"";
            request.fetch_count = DownAmount;
        }else
        {
            TLMasterParam *masterParam = self.master.lastObject;
            request.expert_user_id = masterParam.user_id;
            request.fetch_count = UpAmount;
        }
    }
    __unsafe_unretained __typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:request success:^(id result) {
        weakSelf.allparam = result;
        if ([weakSelf.upDown isEqualToString:PAGEDOWN]) {
            [weakSelf.master removeAllObjects];
            for (TLMasterParam *masterParam in weakSelf.allparam.user_follow_friend_list) {
                [weakSelf.master addObject:masterParam];
            }
            [weakSelf.tableView.mj_header endRefreshing];
        }else
        {
            for (TLMasterParam *master in weakSelf.allparam.user_follow_friend_list) {
                [weakSelf.master addObject:master];
            }
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
    } resultClass:[TLMasterAllParam class]];


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
    return self.master.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMasterViewCell *cell = [TLMasterViewCell cellWithTableView:tableView];
    cell.masterparam = self.master[indexPath.row];
    
    
    return cell;
}

//选中跳转控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id vc = self.parentViewController;
    if ([vc isKindOfClass:[TLCollectViewController class]]) {
         [ self.parentViewController performSegueWithIdentifier:TL_SUPER_MASTER sender:self.master[indexPath.row]];
    }else if ([vc isKindOfClass:[TLMyPeopleViewController class]])
    {
        [self.parentViewController performSegueWithIdentifier:TL_PEOPLE_TO_MASTER sender:self.master[indexPath.row]];
    }
    TLMasterParam *master = self.master[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:master.user_id forKey:TL_MASTER];
    [[NSUserDefaults standardUserDefaults] setObject:linkMaster forKey:TL_ACTION];
}


@end
