//
//  TLMagicShopViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-24.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSearchMagicShopViewController.h"
#import "TLMagicShop.h"
#import "TLMagicShopViewCell.h"
#import "TLCommon.h"

@interface TLSearchMagicShopViewController ()

@end

@implementation TLSearchMagicShopViewController

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
    return self.mstore_list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMagicShopViewCell *cell = [TLMagicShopViewCell cellWithTableView:tableView];
    cell.magicShop = self.mstore_list[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.parentViewController performSegueWithIdentifier:TL_FIND_SHOP sender:self.mstore_list[indexPath.row]];
    
}
@end
