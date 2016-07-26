//
//  TLChoiceToManageViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLChoiceToManageViewController.h"
#import "TLChoiceToManageViewCell.h"
#import "TLCreateAddressViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLAddress.h"
#import "TLAllAddresses.h"
#import "TLReviseAddressViewController.h"
#import "JSONKit.h"
#import "TLSelectAddressViewController.h"
#import "TLAllAddresses.h"
#import "TLImageName.h"
#import "MBProgressHUD+MJ.h"
#import "Url.h"
#import"TLCommon.h"
#import "TLHttpTool.h"
#import "MJExtension.h"



@interface TLChoiceToManageViewController ()<TLCreateAddressViewControllerDelegate,TLReviseAddressViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,assign) float          height;
@property (nonatomic,strong) TLAllAddresses *AllAddresses;
@property (nonatomic,assign) int            index;
@property (nonatomic,strong) NSIndexPath    *aIndexPath;

@end

@implementation TLChoiceToManageViewController

int rowCount=9;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self createTableView];
    [self initNavigationBar];
    [self loadAddress];
    //rowCount = (int)self.addresses.count;
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
    if ([self.delegate respondsToSelector:@selector(choiceToManageViewControllerDelegate:)]) {
        [self.delegate choiceToManageViewControllerDelegate:self];
    }
}

-(void)loadData
{
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
}

/**
 *  加载我的收货地址
 */
-(void)loadAddress
{
    [MBProgressHUD showMessage:TL_ADDRESS_LOADING];
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,my_addresses_Url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN, nil];
    __unsafe_unretained __typeof(self) weakSelf = self;
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        TLAllAddresses *allAddresses = [TLAllAddresses objectWithKeyValues:json[@"body"]];
        [NSKeyedArchiver archiveRootObject:allAddresses.my_address_list toFile:TLAddressDataFilePath];
        weakSelf.addresses = allAddresses.my_address_list;
        for (int i=0; i<weakSelf.addresses.count; i++) {
            TLAddress *address = weakSelf.addresses[i];
            if ([address.default_flag isEqualToString:@"0"]) {
                weakSelf.index = i;
            }
        }
        [weakSelf.customTableView.homeTableView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
    
}

-(NSMutableArray *)addresses
{
    if (_addresses == nil) {
        _addresses = [NSMutableArray array];
    }
    return _addresses;
}

-(void)createTableView
{
    self.edgesForExtendedLayout =UIRectEdgeTop ;
    if (_customTableView == nil) {
        _customTableView = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 32, self.view.bounds.size.width, self.view.bounds.size.height-110)];
        _customTableView.dataSource = self;
        _customTableView.delegate = self;
        [_customTableView deleRefreshHeaderView];
    }
    [self.view addSubview:_customTableView];
}

-(float)heightForRowAthIndexPath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView
{
    
    return 75;
}

-(void)didSelectedRowAthIndexPath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView
{
    [self performSegueWithIdentifier:TL_REVISE_ADDRESS sender:self.addresses[aIndexPath.row]];
}

-(void)didDeleteCellAtIndexpath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView
{
    self.aIndexPath = aIndexPath;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"删除收货地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *url=  [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,address_remove_Url];
        TLAddress *address = self.addresses[self.aIndexPath.row];
        
        NSArray *jsonArray = @[@{@"address_no":address.address_no}];
        
        NSDictionary *jsonDic = [NSDictionary dictionaryWithObjectsAndKeys:jsonArray,@"address_list", nil];
        
        NSString *jsonString = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,jsonString,@"address_json", nil];
        
        __unsafe_unretained __typeof(self) weakSelf = self;
        [TLHttpTool postWithURL:url params:params success:^(id json) {
            TLAllAddresses *allAddresses = [TLAllAddresses objectWithKeyValues:json[@"body"]];
            [NSKeyedArchiver archiveRootObject:allAddresses.my_address_list toFile:TLAddressDataFilePath];
            [MBProgressHUD showSuccess:TL_ADDRESS_DELETE];
            [weakSelf.addresses removeObjectAtIndex:weakSelf.aIndexPath.row];
            [weakSelf.customTableView.homeTableView reloadData];
        } failure:nil];
    }
}

-(void)didMoreCellAtIndexpath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,address_default_Url];
    TLAddress *address = self.addresses[aIndexPath.row];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,address.address_no,@"address_no", nil];
    __unsafe_unretained __typeof(self) weakSelf = self;
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        TLAllAddresses *allAddresses = [TLAllAddresses objectWithKeyValues:json[@"body"]];
        [NSKeyedArchiver archiveRootObject:allAddresses.my_address_list toFile:TLAddressDataFilePath];
        weakSelf.index = (int)aIndexPath.row;
         [weakSelf.customTableView.homeTableView reloadData];
        [MBProgressHUD showSuccess:TL_ADDRESS_DEFAULT];
    } failure:nil];
}


-(NSInteger)numberOfRowsInTableView:(UITableView *)aTableView InSection:(NSInteger)section FromView:(CustomTableView *)aView
{
    return (int)self.addresses.count-1;
}

-(SlideTableViewCell *)cellForRowInTableView:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView
{
    TLChoiceToManageViewCell *cell = [TLChoiceToManageViewCell cellWithTableview:aTableView];
    cell.address = self.addresses[aIndexPath.row];
    if (aIndexPath.row == self.index) {
        cell.defaultImage.hidden = NO;
    }
    else{
        cell.defaultImage.hidden = YES;
    }
   // self.height = cell.height;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLCreateAddressViewController class]]) {
        TLCreateAddressViewController *createAddressView = vc;
        createAddressView.delegate = self;
    } else if ([vc isKindOfClass:[TLReviseAddressViewController class]]) {
        TLReviseAddressViewController *revise = vc;
        revise.delegate = self;
        revise.address = sender;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createAddressViewController:(TLCreateAddressViewController *)TLCreateAddressViewController WithAddress:(NSMutableArray *)address
{
    self.addresses = address;
    [self.customTableView.homeTableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.addresses toFile:TLAddressDataFilePath];
}

-(void)reviseAddressViewController:(TLReviseAddressViewController *)reviseAddressViewController withAddress:(TLAddress *)address
{
    [self.customTableView.homeTableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.addresses toFile:TLAddressDataFilePath];
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
