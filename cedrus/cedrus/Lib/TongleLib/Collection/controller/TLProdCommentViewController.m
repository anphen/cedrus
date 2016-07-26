//
//  TLProdCommentViewController.m
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdCommentViewController.h"
#import "TLProdCommentRequest.h"
#import "TLProdCommentViewCell.h"
#import "TLProdComment.h"
#import "TLBaseTool.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "MJRefresh.h"
#import "Url.h"


@interface TLProdCommentViewController ()
@property (nonatomic,strong)    TLProdComment   *prodComment;
@property (nonatomic,strong)    NSMutableArray  *prodCommentArray;
@property (nonatomic,assign)    CGFloat         height;
@property (nonatomic,copy)      NSString        *upDown;

@end

@implementation TLProdCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.height = 44;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self RefreshControl];
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
    [self loadData];
}

-(void)footerRefresh
{
    self.upDown = PAGEUP;
    [self loadData];
}

-(NSMutableArray *)prodCommentArray
{
    if (_prodCommentArray == nil) {
        _prodCommentArray = [NSMutableArray array];
    }
    return _prodCommentArray;
}


-(void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,evaluation_show_Url];
    TLProdCommentRequest *prodCommentRequest = [[TLProdCommentRequest alloc]init];

    if (self.prodCommentArray.count) {
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            prodCommentRequest.fetch_count = DownAmount;
            prodCommentRequest.rating_doc_no = @"";
        }else
        {
            prodCommentRequest.fetch_count = UpAmount;
            TLProdProductRatingList *productRating = self.prodCommentArray.lastObject;
            prodCommentRequest.rating_doc_no = productRating.rating_doc_no;
        }
    }
    [TLBaseTool postWithURL:url param:prodCommentRequest success:^(id result) {
          self.prodComment = result;
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            [self.prodCommentArray removeAllObjects];
            for (TLProdProductRatingList *productRating in self.prodComment.product_rating_list) {
                [self.prodCommentArray addObject:productRating];
            }
            [self.tableView.mj_header endRefreshing];
        }else
        {
            for (TLProdProductRatingList *productRating in self.prodComment.product_rating_list) {
                [self.prodCommentArray addObject:productRating];
            }
             [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if ([self.upDown isEqualToString:PAGEDOWN])
        {
            [self.tableView.mj_header endRefreshing];
        }else
        {
             [self.tableView.mj_footer endRefreshing];
        }
    }resultClass:[TLProdComment class]];
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
        self.view = nil;
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

    return self.prodCommentArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLProdCommentViewCell *cell = [TLProdCommentViewCell cellWithTableCell:tableView];
    cell.prodProductRatingList = self.prodCommentArray[indexPath.row];
    self.height = cell.height;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height;
}
@end
