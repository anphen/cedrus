//
//  TLChoiceCouponListViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/31.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLChoiceCouponListViewController.h"
#import "TLImageName.h"
#import "TLChoiceCouponListViewCell.h"
#import "TLGoods_info.h"
#import "TLChoiceCouponListRequest.h"
#import "TLVoucher.h"
#import "Url.h"
#import "TLBaseTool.h"


@interface TLChoiceCouponListViewController ()

@property (nonatomic,strong) TLVoucher *voucher;

@end

@implementation TLChoiceCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    self.tableView.rowHeight = 40;
    [self loaddata];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    self.navigationItem.title = @"选择优惠券";
}
/**
 *  重写返回按钮
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(choiceCouponListViewController:withTLVoucherBase:)]) {
        [self.delegate choiceCouponListViewController:self withTLVoucherBase:_voucher_base];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    TLChoiceCouponListRequest *choiceCouponListRequest = [[TLChoiceCouponListRequest alloc]init];
    choiceCouponListRequest.goods_info = _goodInfoArray;
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,choiceCouponListRequest.user_token,useful_vouchers_info_Url];
    [TLBaseTool postWithURL:url param:choiceCouponListRequest success:^(id result) {
        TLVoucher *voucher = result;
        _voucher = voucher;
        [self.tableView reloadData];
    } failure:nil resultClass:[TLVoucher class]];
}


-(void)setGoodInfoArray:(NSArray *)goodInfoArray
{
    _goodInfoArray = goodInfoArray;
    
}


-(void)setVouchers_number_id:(NSString *)vouchers_number_id
{
    _vouchers_number_id = vouchers_number_id;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _voucher.voucher.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLChoiceCouponListViewCell *cell = [TLChoiceCouponListViewCell cellWithTableView:tableView];
    TLVoucherBaseDict *dict = _voucher.voucher[indexPath.row];
    cell.voucherBase = dict.voucher_base;
    if ([dict.voucher_base.vouchers_number_id isEqualToString:_vouchers_number_id]) {
        cell.seleteType.selected = YES;
        _voucher_base = dict.voucher_base;
    }
    cell.tag = 1000+indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cancelSelected];
    TLChoiceCouponListViewCell *cell = (TLChoiceCouponListViewCell *)[self.view viewWithTag:(1000+indexPath.row)];
    cell.seleteType.selected = YES;
    TLVoucherBaseDict *dict = _voucher.voucher[indexPath.row];
    _voucher_base = dict.voucher_base;

    [self performSelector:@selector(back) withObject:nil afterDelay:0.5f];
}


-(void)cancelSelected
{
    for (int i = 0; i<_voucher.voucher.count; i++) {
        TLChoiceCouponListViewCell *cell = (TLChoiceCouponListViewCell *)[self.view viewWithTag:(1000+i)];
        cell.seleteType.selected = NO;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
