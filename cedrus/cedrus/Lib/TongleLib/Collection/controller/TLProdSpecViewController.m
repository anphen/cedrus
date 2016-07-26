//
//  TLProdSpecViewController.m
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdSpecViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLProdParam.h"
#import "TLProdParamViewCell.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLHttpTool.h"

@interface TLProdSpecViewController ()

@property (nonatomic,copy)      NSString    *user_id;
@property (nonatomic,copy)      NSString    *product_id;
@property (nonatomic,copy)      NSString    *token;
@property (nonatomic,strong)    TLProdParam *prodParam;
@property (nonatomic,strong)    NSArray     *prodParamArray;
@property (nonatomic,assign)    CGFloat     rowHeight;


@end

@implementation TLProdSpecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setSectionIndexColor:[UIColor clearColor]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setBackgroundView:nil];
}

-(void)loadData
{
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    self.product_id = [[NSUserDefaults standardUserDefaults] objectForKey:TL_PROD_DETAILS_PROD_ID];
    
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,specification_show_Url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id, @"user_id",self.token, TL_USER_TOKEN,self.product_id,@"product_id", nil];
    __unsafe_unretained __typeof(self) weakself = self;
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        TLProdParam *result = [[TLProdParam alloc]initWithDictionary:json[@"body"] error:nil];
        weakself.prodParamArray = result.prod_parameter_list;
        [weakself.tableView reloadData];
    } failure:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil)
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;
        // Dispose of any resources that can be recreated.
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.prodParamArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLProdParamViewCell *cell = [TLProdParamViewCell cellWithTableView:tableView];
    cell.prodParamsterList = self.prodParamArray[indexPath.row];
    self.rowHeight = cell.height;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

@end
