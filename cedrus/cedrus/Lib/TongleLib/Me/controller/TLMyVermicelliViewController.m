//
//  TLMyVermicelliViewController.m
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMyVermicelliViewController.h"
#import "TLVermicelliViewCell.h"
#import "TLVermicelliRequest.h"
#import "TLVermicelliModel.h"
#import "TLBaseTool.h"
#import "MJExtension.h"
#import "TLMasterParam.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "MJRefresh.h"
#import "Url.h"
#import "MBProgressHUD+MJ.h"

@interface TLMyVermicelliViewController ()<TLVermicelliViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *vermicelliArray;
@property (nonatomic,strong) TLVermicelliModel *vermicellies;
@property (nonatomic,copy)      NSString        *UpDown;

@end

@implementation TLMyVermicelliViewController

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 68;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self RefreshControl];
}


-(NSMutableArray *)vermicelliArray
{
    if (_vermicelliArray == nil) {
        _vermicelliArray = [NSMutableArray array];
    }
    return _vermicelliArray;
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
    self.UpDown = PAGEDOWN;
   [self loadStatuses];
}
-(void)footerRefresh
{
    self.UpDown = PAGEUP;
    [self loadStatuses];
}

//加载数据

-(void)loadStatuses
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,fans_Url];
    
    TLVermicelliRequest *request = [[TLVermicelliRequest alloc]init];
    if (self.vermicelliArray.count) {
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            request.fetch_count = DownAmount;
            request.fans_user_id = @"";
        }else
        {
            request.fetch_count = UpAmount;
            TLMasterParam *masterParam = self.vermicelliArray.lastObject;
            request.fans_user_id = masterParam.user_id;
        }
    }
    [TLBaseTool postWithURL:url param:request success:^(id result) {
        self.vermicellies = result;
        
        if ([self.UpDown isEqualToString:PAGEDOWN]) {
            [self.vermicelliArray removeAllObjects];
            for (TLMasterParam *masterParam in self.vermicellies.user_fans_list) {
                [self.vermicelliArray addObject:masterParam];
            }
            [self.tableView.mj_header endRefreshing];
        }else
        {
            
            [self.vermicelliArray addObjectsFromArray:self.vermicellies.user_fans_list];
             [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if ([self.UpDown isEqualToString:PAGEDOWN])
        {
            [self.tableView.mj_header endRefreshing];
        }else
        {
             [self.tableView.mj_footer endRefreshing];
        }
    } resultClass:[TLVermicelliModel class]];
    
    
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
    return self.vermicelliArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLVermicelliViewCell *cell = [TLVermicelliViewCell cellWithTableView:tableView];
    cell.masterparam = self.vermicelliArray[indexPath.row];
    cell.delegate  =self;
    cell.tag = indexPath.row;
    
    return cell;
}

-(void)addVermicelliView:(TLVermicelliViewCell *)vermicelliViewCell withBtn:(UIButton *)btn
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,friendships_create_Url];
    TLMasterParam *master = self.vermicelliArray[vermicelliViewCell.tag];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN,master.user_id,@"expert_user_id", nil];
    [TLHttpTool postWithURL:url params:param success:^(id json) {
        
        [MBProgressHUD showSuccess:@"关注成功"];
        btn.titleLabel.text = @"已关注";
    } failure:nil];
}

//选中跳转控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.parentViewController performSegueWithIdentifier:TL_MY_PEOPLE_TO_MASTER sender:self.vermicelliArray[indexPath.row]];

    TLMasterParam *master = self.vermicelliArray[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:master.user_id forKey:TL_MASTER];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

@end
