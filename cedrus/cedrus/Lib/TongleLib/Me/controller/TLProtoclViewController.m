//
//  TLProtoclViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-23.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProtoclViewController.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"
#import "TLImageName.h"
#import "Url.h"
#import "TLHttpTool.h"

@interface TLProtoclViewController ()

@property (nonatomic,weak) UIWebView *webView;

- (IBAction)agress:(UIBarButtonItem *)sender;
@end

@implementation TLProtoclViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self loadData];
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    self.webView = webView;
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


-(void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Url,user_agreement_Url];
    
    NSDictionary *dict = [NSDictionary dictionary];
    [TLHttpTool postWithURL:url params:dict success:^(id json) {
        NSDictionary *jsondict = json[@"body"];
        [self.navigationItem setTitle:jsondict[@"title_text"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:jsondict[@"user_agreement_url"]]];
        [self.webView loadRequest:request];
    } failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)agress:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
