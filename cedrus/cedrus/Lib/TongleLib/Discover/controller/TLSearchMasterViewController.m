//
//  TLSearchMasterViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-24.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSearchMasterViewController.h"
#import "TLMasterParam.h"
#import "TLMasterViewCell.h"
#import "TLSearchViewController.h"
#import "TLCommon.h"

@interface TLSearchMasterViewController ()

@end

@implementation TLSearchMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 68;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
//    [self.tableView addGestureRecognizer:tapGesture];

}

-(void)dismissKeyBoard
{
    [self.parentViewController.view endEditing:YES];
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
    return self.user_list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLMasterViewCell *cell = [TLMasterViewCell cellWithTableView:tableView];
    cell.masterparam = self.user_list[indexPath.row];
    return cell;
}

//选中跳转控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ self.parentViewController performSegueWithIdentifier:TL_FIND_MASTER sender:self.user_list[indexPath.row]];
    TLMasterParam *master = self.user_list[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:master.user_id forKey:TL_MASTER];
}


@end
