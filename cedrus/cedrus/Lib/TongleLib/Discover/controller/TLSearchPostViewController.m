//
//  TLSearchPostViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-24.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSearchPostViewController.h"
#import "TLPostFrame.h"
#import "TLPostViewCell.h"
#import "TLCommon.h"
@interface TLSearchPostViewController ()

@property (nonatomic,strong) NSArray *arrayFrame;
@end

@implementation TLSearchPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupFrame];
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
    return self.post_list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLPostViewCell *cell = [TLPostViewCell cellWithTableView:tableView];
    cell.postFrame = self.arrayFrame[indexPath.row];
        return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [self setupFrame];
    TLPostFrame *postFrame = self.arrayFrame[indexPath.row];
    return postFrame.cellHeight;
}

-(void)setupFrame
{
    NSMutableArray *temp = [NSMutableArray array];
    for (TLPostParam *postParam in self.post_list) {
        TLPostFrame *postFrame = [[TLPostFrame alloc]init];
        postFrame.postParam = postParam;
        [temp addObject:postFrame];
    }
    self.arrayFrame = temp;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLPostFrame *postFrame = self.arrayFrame[indexPath.row];
    TLPostParam *postParam = postFrame.postParam;
    [self.parentViewController performSegueWithIdentifier:TL_FIND_POST sender:postParam];
}
@end
