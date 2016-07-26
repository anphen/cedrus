//
//  TLMyOrderProdEvaViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-17.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMyOrderProdEvaViewController.h"
#import "TLMyorderEvaViewCell.h"
#import "TLMyOrderList.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLProdEvaResult.h"
#import "JSONKit.h"
#import "TLImageName.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "RatingBarView.h"

@interface TLMyOrderProdEvaViewController ()<TLMyorderEvaViewCellDelegate,UITableViewDataSource,RatingBarViewDelegate>

@property (nonatomic,weak) UIButton         *selectButton;
@property (nonatomic,weak) RatingBarView *ratingBarView;

@end

@implementation TLMyOrderProdEvaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableview = [[UITableView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    tableview.frame = CGRectMake(0, 0, ScreenBounds.size.width, ScreenBounds.size.height-65);
    [self.view addSubview:tableview];
    self.tableview = tableview;
    self.tableview.rowHeight = 83;
    self.tableview.dataSource = self;
    [self initNavigationBar];
}


//自定义导航栏
- (void)initNavigationBar
{
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:TL_NAVI_BACK_NORMAL] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:TL_NAVI_BACK_PRESS] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setMyorderList:(TLMyOrderList *)myorderList
{
    _myorderList = myorderList;
    _order_no = myorderList.order_no;
    _myorderListArray = myorderList.prod_detail;
}

-(void)setMyorderListArray:(NSArray *)myorderListArray
{
    _myorderListArray = myorderListArray;
}

-(void)setOrder_no:(NSString *)order_no
{
    _order_no = order_no;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _myorderListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMyorderEvaViewCell *cell = [TLMyorderEvaViewCell cellWithTableView:tableView];
    cell.OrderProdDetail = self.myorderListArray[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)MyorderEvaViewCell:(TLMyorderEvaViewCell *)myorderEvaViewCell withOrderProd:(TLMyOrderProdDetail *)myOrderProdDetail withBtn:(UIButton *)btn
{
    self.myOrderProdDetail = myOrderProdDetail;
    self.selectButton = btn;
    
    UIView *blackView = [[UIView alloc]init];
    blackView.frame = self.view.bounds;
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.0;
    [self.view addSubview:blackView];
    self.blackView = blackView;
    
    
    RatingBarView *ratingBarView = [[RatingBarView alloc]init];
    ratingBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ratingBarView];
    ratingBarView.alpha = 0.0;
    [self.view bringSubviewToFront:ratingBarView];
    ratingBarView.delegate  = self;
    _ratingBarView = ratingBarView;
    ratingBarView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    ratingBarView.bounds = CGRectMake(0, 0, blackView.bounds.size.width-40, 250);
    [UIView animateWithDuration:0.25 animations:^{
        blackView.alpha = 0.3;
        ratingBarView.alpha = 1.0;
    }];
    

}

-(void)ratingBarViewCancel:(RatingBarView *)ratingBarView
{
    [UIView animateWithDuration:0.25 animations:^{
        _blackView.alpha = 0.0;
        _ratingBarView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [_blackView removeFromSuperview];
        [_ratingBarView removeFromSuperview];
    }];
}

-(void)ratingBarView:(RatingBarView *)ratingBarView withEstimation:(NSString *)estimation comment:(NSString *)comment groupOrder:(TLGroupOrder *)groupOrder
{
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,evaluation_create_Url];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_order_no,@"order_no",self.myOrderProdDetail.order_detail_no,@"order_detail_no",self.myOrderProdDetail.prod_id,@"product_id",estimation,@"level",comment,@"memo", nil];

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
            NSMutableArray *temp = [NSMutableArray array];
            for (TLMyOrderProdDetail *OrderProdDetail in self.myorderListArray) {
                [temp addObject:OrderProdDetail];
            }
            [temp removeObject:self.myOrderProdDetail];
            weakSelf.myorderListArray = temp;
            [weakSelf.tableview reloadData];
            if (weakSelf.myorderListArray.count == 0) {
                [weakSelf back];
            }
            
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
