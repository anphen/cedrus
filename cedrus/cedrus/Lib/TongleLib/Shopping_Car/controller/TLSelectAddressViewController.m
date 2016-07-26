//
//  TLSelectAddressViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSelectAddressViewController.h"
#import "TLAddressesListViewCell.h"
#import "TLChoiceToManageViewController.h"
#import "TLAddress.h"
#import "TLImageName.h"
#import "TLCommon.h"

@interface TLSelectAddressViewController ()<TLChoiceToManageViewControllerDelegate>

- (IBAction)manageAddress:(UIBarButtonItem *)sender;


@end

@implementation TLSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    self.tableView.rowHeight = 90;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

/**
 *  自定义导航栏
 */
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

/**
 *  懒加载
 *
 *  @return 可变数组
 */
-(NSMutableArray *)allAddresses
{
    _allAddresses = [NSKeyedUnarchiver unarchiveObjectWithFile:TLAddressDataFilePath];
        
    if (_allAddresses == nil)
    {
            _allAddresses = [NSMutableArray array];
    }
    return _allAddresses;
}


- (void)didReceiveMemoryWarning {
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
    return self.allAddresses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLAddressesListViewCell *cell = [TLAddressesListViewCell cellWithTableView:tableView];
    cell.address = self.allAddresses[indexPath.row];
    cell.tag = 1000+indexPath.row;
    if ( [cell.address.default_flag isEqualToString:@"0"]) {
        cell.rightselected = YES;

    }else
    {
        cell.rightselected = NO;
    }
    
    return cell;
}
/**
 *  选中地址
 *
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cancelSelected];
    TLAddressesListViewCell *cell = (TLAddressesListViewCell *)[self.view viewWithTag:(1000+indexPath.row)];
    cell.rightselected = YES;
    [self performSelector:@selector(delay) withObject:nil afterDelay:0.5f];
}

-(void)delay
{
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 *  取消地址
 */
-(void)cancelSelected
{
    for (int i = 0; i<self.allAddresses.count; i++) {
        TLAddressesListViewCell *cell = (TLAddressesListViewCell *)[self.view viewWithTag:(1000+i)];
        cell.rightselected = NO;
    }
}

/**
 *  视图消失处理
 *
 *  @param animated
 */
-(void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
    if (self.allAddresses.count) {
        for (int i = 0; i<self.allAddresses.count; i++) {
            TLAddressesListViewCell *cell = (TLAddressesListViewCell *)[self.view viewWithTag:(1000+i)];
            if (cell.rightselected)
            {
                if ([self.delegate respondsToSelector:@selector(changeAddressWithController:didAddress:)]) {
                    [self.delegate changeAddressWithController:self didAddress:cell.address];
                }
            }
        }

    }else
    {
        if ([self.delegate respondsToSelector:@selector(changeAddressWithController:didNoAddress:)]) {
            [self.delegate changeAddressWithController:self didNoAddress:nil];
        }
    }
}


/**
 *  跳转地址管理控制器
 *
 *  @param sender
 */
- (IBAction)manageAddress:(UIBarButtonItem *)sender {
    //[self performSegueWithIdentifier:@"choicetomanageaddress" sender:self.allAddresses];
    [self performSegueWithIdentifier:TL_CHOICE_TO_MANAGE_ADDRESS sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLChoiceToManageViewController class]]) {
        TLChoiceToManageViewController *choiceToManageView = vc;
        choiceToManageView.delegate = self;
    }
}

/**
 *  选中地址重加载
 *
 *  @param choiceToManageViewController 地址管理控制器
 */
-(void)choiceToManageViewControllerDelegate:(TLChoiceToManageViewController *)choiceToManageViewController
{
    [self.tableView reloadData];
}

@end
