//
//  TLAddressViewController.m
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMyAccountViewController.h"
#import "TLMe.h"
#import "TLCommon.h"
#import "TLImageName.h"
#import "UIColor+TL.h"
#import "TLIntegrateDetailController.h"
#import "TLMyPoint.h"
#import "TLHttpTool.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "Url.h"
#import "TLMyAccountModel.h"
#import "UIButton+TL.h"

@interface TLMyAccountViewController ()

@property (nonatomic,strong) TLMyAccountModel *myAccountModel;
@property (nonatomic,weak) UIButton *rightButton;
@end

@implementation TLMyAccountViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loaddata];
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
    
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"兑换申请" forState:UIControlStateNormal];
    [rightButton setTitle:@"兑换申请" forState:UIControlStateHighlighted];
    rightButton.frame = CGRectMake(0, 0, 75, 25);
    _rightButton = rightButton;
    rightButton.hidden = YES;
    [rightButton addTarget:self action:@selector(html:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
/**
 *  重写返回按钮
 */
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loaddata
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,points_Url];
    NSDictionary *point = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN, nil];
    [TLHttpTool postWithURL:url params:point success:^(id json) {
        TLMyAccountModel *myAccountModel = [[TLMyAccountModel alloc]initWithDictionary:json[@"body"] error:nil];
        _myAccountModel = myAccountModel;
        _rightButton.hidden = NO;
        [self.tableView reloadData];
    } failure:nil];
}

-(void)html:(UIButton *)btn
{
    [_rightButton ButtonDelay];
    TLIntegrateDetailController *integrateDetailController = [[TLIntegrateDetailController alloc]init];
    integrateDetailController.user_account_info = _myAccountModel.user_account_info;
        [self.navigationController pushViewController:integrateDetailController animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return _myAccountModel.user_account_info.account_list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"myaccount";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 43, ScreenBounds.size.width-15, 1)];
        line.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [cell.contentView addSubview:line];
    }
    
    TLMyAccount_list *MyAccount =  _myAccountModel.user_account_info.account_list[indexPath.row];
    
    cell.textLabel.text = MyAccount.account_type_name;
    cell.detailTextLabel.text =MyAccount.account_qty;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLIntegrateDetailController *integrateDetailController = [[TLIntegrateDetailController alloc]init];
     TLMyAccount_list *MyAccount =  _myAccountModel.user_account_info.account_list[indexPath.row];
    integrateDetailController.MyAccount = MyAccount;
    [self.navigationController pushViewController:integrateDetailController animated:YES];
}

@end
