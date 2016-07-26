//
//  TLDeliveriesDataViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-5.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLDeliveriesDataViewController.h"
#import "TLBaseDateType.h"
#import "TLDataList.h"
#import "TLDeliveriesViewCell.h"
#import "TLCommon.h"
#import "TLImageName.h"

@interface TLDeliveriesDataViewController ()

@property (nonatomic,strong) NSArray *deliveriesDate;

@end

@implementation TLDeliveriesDataViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self initNavigationBar];
    self.tableView.rowHeight = 44;
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
/**
 *  重写返回按钮
 */
-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setBaseDateType:(TLBaseDateType *)baseDateType
{
    _baseDateType = baseDateType;
    self.deliveriesDate = baseDateType.data_list;
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
    return self.deliveriesDate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLDeliveriesViewCell *cell = [TLDeliveriesViewCell cellWithTableview:tableView];
    cell.dataList = self.baseDateType.data_list[indexPath.row];
    if (indexPath.row == 0) {
        cell.rightselected = YES;
    }
    cell.tag = 1000+indexPath.row;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cancelSelected];
    TLDeliveriesViewCell *cell = (TLDeliveriesViewCell *)[self.view viewWithTag:(1000+indexPath.row)];
    cell.rightselected = YES;
     [self performSelector:@selector(delay) withObject:nil afterDelay:0.5f];
}

-(void)delay
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cancelSelected
{
    for (int i = 0; i<self.baseDateType.data_list.count; i++) {
        TLDeliveriesViewCell *cell = (TLDeliveriesViewCell *)[self.view viewWithTag:(1000+i)];
        cell.rightselected = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (int i = 0; i<self.baseDateType.data_list.count; i++) {
        TLDeliveriesViewCell *cell = (TLDeliveriesViewCell *)[self.view viewWithTag:(1000+i)];
        if (cell.rightselected) {
            [self.delegate changeDeliveriesDateWithController:self didAddress:self.deliveriesDate[i]];
        }
    }
}
@end
