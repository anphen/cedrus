//
//  TLGroupOrderAllListViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/21.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupOrderAllListViewController.h"
#import "TLGroupOrderList.h"
#import "TLGroupOrderListViewCell.h"
#import "TLGroupOrderDetailViewController.h"
#import "TLGroupShopSubmitOrderViewController.h"
#import "TLGroupOrdersListRequest.h"
#import "TLGroupOrderList.h"
#import "Url.h"
#import "TLBaseTool.h"
#import "MJRefresh.h"
#import "RatingBarView.h"
#import "RatingBar.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "MBProgressHUD+MJ.h"


@interface TLGroupOrderAllListViewController ()<TLGroupOrderListViewCellDelagate,RatingBarViewDelegate>

@property (nonatomic,copy) NSString *upDown;
@property (nonatomic,strong) NSMutableArray *groupOrderArray;
@property (nonatomic,weak) UIView *cover;
@property (nonatomic,weak) RatingBarView *ratingBarView;
@end

@implementation TLGroupOrderAllListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.rowHeight = 82;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

-(NSMutableArray *)groupOrderArray
{
    if (_groupOrderArray == nil) {
        _groupOrderArray = [NSMutableArray array];
    }
    return _groupOrderArray;
}


-(void)loadData
{
    TLGroupOrdersListRequest *groupOrdersListRequest = [[TLGroupOrdersListRequest alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,groupOrdersListRequest.user_token,orders_gp_orders_Url];
    
    if (self.groupOrderArray.count)
    {
        if ([self.upDown isEqualToString:PAGEDOWN]) {
            groupOrdersListRequest.order_no = @"";
            groupOrdersListRequest.fetch_count = DownAmount;
        }else
        {
            TLGroupOrder *groupOrder = self.groupOrderArray.lastObject;
            groupOrdersListRequest.order_no = groupOrder.order_no;
            groupOrdersListRequest.fetch_count = UpAmount;
        }
    }
    __weak typeof(self) weakSelf = self;
    [TLBaseTool postWithURL:url param:groupOrdersListRequest success:^(id result) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            TLGroupOrderList *groupOrderList = result;
            
            if ([weakSelf.upDown isEqualToString:PAGEDOWN]) {
                [weakSelf.groupOrderArray removeAllObjects];
                for (TLGroupOrder *groupOrder in groupOrderList.order_list) {
                    [weakSelf.groupOrderArray addObject:groupOrder];
                }
                [weakSelf.tableView.mj_header endRefreshing];
            }else
            {
                for (TLGroupOrder *groupOrder in groupOrderList.order_list) {
                    [weakSelf.groupOrderArray addObject:groupOrder];
                }
                [weakSelf.tableView.mj_footer endRefreshing];
            }
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSError *error)
     {
         if ([weakSelf.upDown isEqualToString:PAGEDOWN])
         {
             [weakSelf.tableView.mj_header endRefreshing];
         }else
         {
             [weakSelf.tableView.mj_footer endRefreshing];
         }
     } resultClass:[TLGroupOrderList class]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupOrderArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLGroupOrderListViewCell *cell = [TLGroupOrderListViewCell cellWithTableview:tableView];
    cell.type = @"0";
    cell.delegate = self;
    cell.groupOrder = self.groupOrderArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLGroupOrder *groupOrder = self.groupOrderArray[indexPath.row];
    
    if ([groupOrder.order_pay_info.pay_status intValue]) {
        TLGroupOrderDetailViewController *groupOrderDetailView = [[TLGroupOrderDetailViewController alloc]init];
        groupOrderDetailView.order_no = groupOrder.order_no;
        [self.parentViewController.navigationController pushViewController:groupOrderDetailView animated:YES];
    }else
    {
        TLGroupOrderListViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

-(void)groupOrderListViewCell:(TLGroupOrderListViewCell *)groupOrderListViewCell button:(UIButton *)button withGroupOrder:(TLGroupOrder *)groupOrder
{
    if ([button.titleLabel.text isEqualToString:@"立即支付"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Tongle_Base" bundle:nil];
        TLGroupShopSubmitOrderViewController *groupShopSubmitOrderView = [storyboard instantiateViewControllerWithIdentifier:@"groupShopSubmitOrderViewController"];
        groupShopSubmitOrderView.groupOrder = groupOrder;
        groupShopSubmitOrderView.type = @"未付款";
        [self.navigationController pushViewController:groupShopSubmitOrderView animated:YES];
    }else
    {
        
        UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
        UIView *cover = [[UIView alloc]init];
        cover.frame = blackView.bounds;
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.0;
        self.cover = cover;
        [blackView addSubview:cover];
        
        
        RatingBarView *ratingBarView = [[RatingBarView alloc]init];
        ratingBarView.backgroundColor = [UIColor whiteColor];
        ratingBarView.alpha = 0.0;
       [blackView addSubview:ratingBarView];
        [blackView bringSubviewToFront:ratingBarView];
        ratingBarView.delegate  = self;
        _ratingBarView = ratingBarView;
        ratingBarView.groupOrder = groupOrder;
        ratingBarView.center = CGPointMake(blackView.bounds.size.width/2, blackView.bounds.size.height/2);
        ratingBarView.bounds = CGRectMake(0, 0, blackView.bounds.size.width-40, 250);
        [UIView animateWithDuration:0.25 animations:^{
            cover.alpha  = 0.3;
            ratingBarView.alpha = 1.0;
        }];
    }
}

-(void)ratingBarViewCancel:(RatingBarView *)ratingBarView
{
    [UIView animateWithDuration:0.25 animations:^{
        _cover.alpha = 0.0;
        _ratingBarView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [_ratingBarView removeFromSuperview];
    }];
}


-(void)ratingBarView:(RatingBarView *)ratingBarView withEstimation:(NSString *)estimation comment:(NSString *)comment groupOrder:(TLGroupOrder *)groupOrder
{

    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,evaluation_create_Url];
        
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:groupOrder.order_no,@"order_no",groupOrder.order_no,@"order_detail_no",groupOrder.prod_id,@"product_id",estimation,@"level",comment,@"memo", nil];
        NSMutableArray *temp = [NSMutableArray array];
        [temp addObject:dic];
        NSDictionary *dictjson = [NSDictionary dictionaryWithObjectsAndKeys:temp,@"rating_detail", nil];
        NSString *stringJson = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dictjson options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id, @"user_id",[TLPersonalMegTool currentPersonalMeg].token, TL_USER_TOKEN,stringJson,@"rating_detail_json", nil];
    __weak typeof(self) weakSelf = self;
        //发送请求
        [TLHttpTool postWithURL:url params:params success:^(id json) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"评价成功"];
                [weakSelf ratingBarViewCancel:nil];
                // 马上进入刷新状态
                [weakSelf.tableView.mj_header beginRefreshing];

            });
        } failure:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)keyboardWillChangeFrame:(NSNotification *)note
{
     UIView *blackView = [[UIApplication sharedApplication].windows lastObject];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat transformY = keyboardFrame.origin.y - blackView.bounds.size.height/2-130;
    
    if (transformY<0) {
        [UIView animateWithDuration:duration animations:^{
            _ratingBarView.transform = CGAffineTransformMakeTranslation(0, transformY);
        }];
    }
}

@end
