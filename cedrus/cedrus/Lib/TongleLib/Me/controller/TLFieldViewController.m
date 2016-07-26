//
//  TLFieldViewController.m
//  tongle
//
//  Created by liu on 15-4-22.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLFieldViewController.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLProd_Type.h"
#import "TLMyFiledTableViewCell.h"
#import "TLFiledFirstViewController.h"
#import "JSONKit.h"
#import "MBProgressHUD+MJ.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "TLImageName.h"
#import "TLCommon.h"



@interface TLFieldViewController ()

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,strong) TLProd_Type *prod_list;

- (IBAction)fieldSave:(UIBarButtonItem *)sender;

@end

@implementation TLFieldViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self loadBaseDate];
    [self setUpDate];
    
    // Do any additional setup after loading the view.
}


/**
 *  加载基本数据
 */
-(void)loadBaseDate
{
    self.user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    self.token = [TLPersonalMegTool currentPersonalMeg].token;
    self.tableView.rowHeight = 40;
    NSArray *resultArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSelectField"];
    [[NSUserDefaults standardUserDefaults] setObject:resultArray forKey:@"selectFiled"];
}
/**
 *  加载网络数据
 */
-(void)setUpDate
{
    [MBProgressHUD showMessage:@"正在加载..."];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,product_types_Url];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN, nil];
    [TLHttpTool postWithURL:url params:param success:^(id json) {
        [MBProgressHUD hideHUD];
        TLProd_Type *prod_list = [[TLProd_Type alloc]initWithDictionary:json[@"body"] error:nil];
        self.prod_list = prod_list;
        [self.tableView reloadData];
    
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
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
    if ([self.sign isEqualToString:@"设置"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self jumptabbar];
    }
}

-(void)jumptabbar
{
    NSString *apptype = [[NSUserDefaults standardUserDefaults] objectForKey:APPTYPE];
    if ([apptype isEqualToString:@"community"]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_Community" bundle:nil];
        self.view.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"community_tabbar"];
    }else
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
        self.view.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:TLBASETABA];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.prod_list.type_list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMyFiledTableViewCell *cell = [TLMyFiledTableViewCell cellWithTableView:tableView];
    cell.prod_type_List = self.prod_list.type_list[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMyFiledTableViewCell *cell = (TLMyFiledTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone ) {
      cell.isSelected = YES;
    }else
    {
        [self performSegueWithIdentifier:@"fieldFirst" sender:self.prod_list.type_list[indexPath.row]];
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based TLlication, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fieldSave:(UIBarButtonItem *)sender {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,product_types_create_Url];
    
    NSArray *resultArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectFiled"];
    
    NSDictionary *dictjson = [NSDictionary dictionaryWithObjectsAndKeys:resultArray,@"type_list", nil];
    
    NSString *stringJson = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dictjson options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];

    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.user_id,@"user_id",self.token,TL_USER_TOKEN,stringJson,@"type_info", nil];
    [TLHttpTool postWithURL:url params:param success:^(id json) {
        [MBProgressHUD showSuccess:@"保存成功"];
        [[NSUserDefaults standardUserDefaults] setObject:resultArray forKey:@"lastSelectField"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.sign isEqualToString:@"设置"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
               [self jumptabbar];
            }
        });
    } failure:^(NSError *error) {
        if ([self.sign isEqualToString:@"设置"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self jumptabbar];
        }
    }];
}
@end
