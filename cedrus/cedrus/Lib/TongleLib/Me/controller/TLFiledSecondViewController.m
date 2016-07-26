//
//  TLFiledSecondViewController.m
//  tongle
//
//  Created by ruibin liu on 15/6/20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLFiledSecondViewController.h"
#import "TLMyFiledTableViewCell.h"
#import "TLProd_type_List.h"
#import "TLFiledFirstViewController.h"
#import "TLImageName.h"


@interface TLFiledSecondViewController ()

@end

@implementation TLFiledSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 40;
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
/**
 *  重写返回按钮
 */
-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setProd_type_List:(TLProd_type_List *)prod_type_List
{
    _prod_type_List = prod_type_List;
    [self.navigationItem setTitle:prod_type_List.type_name];

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
    return self.prod_type_List.sub_list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMyFiledTableViewCell *cell = [TLMyFiledTableViewCell cellWithTableView:tableView];
    cell.prod_type_List = self.prod_type_List.sub_list[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMyFiledTableViewCell *cell = (TLMyFiledTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone ) {
        cell.isSelected = !cell.isSelected;
        
    }else
    {
        [self performSegueWithIdentifier:@"fieldThird" sender:self.prod_type_List.sub_list[indexPath.row]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLFiledFirstViewController class]]) {
        TLFiledFirstViewController *first = vc;
        first.prod_type_List = sender;
    }
}

@end
