//
//  TLLeadController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-9-28.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLLeadController.h"
#import "ZWIntroductionViewController.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "TLBaseTool.h"
#import "TLBaseDataMd5List.h"


@interface TLLeadController ()

@property (nonatomic, strong) ZWIntroductionViewController *introductionView;
@end

@implementation TLLeadController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Tongle_Base" bundle:nil];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:TLLEADKRY])
    {
        NSArray *coverImageNames = @[@"tongle_lead_001", @"tongle_lead_002", @"tongle_lead_003"];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:nil];
        [self.view addSubview:self.introductionView.view];
        
        __weak TLLeadController *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            //[weakSelf loadBaseDate];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:TLLEADKRY];
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:TLAUTOLAND];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"rememPsw"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"auto_login"];
            weakSelf.view.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"firstnavi"];
        };

    }
    // Do any additional setup after loading the view.
}

-(void)loadBaseDate
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Url,base_data_Url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"base_data_type_json",@"",@"app_inner_no", nil];
    
    [TLHttpTool postWithURL:url params:params success:^(id json)
     {
         [NSKeyedArchiver archiveRootObject:json[@"body"] toFile:TLBaseDataFilePath];
     } failure:nil];
    
    url = [NSString stringWithFormat:@"%@%@",Url,base_data_md5_Url];
    
    NSDictionary *dict = [NSDictionary dictionary];
    [TLBaseTool postWithURL:url param:dict success:^(id result) {
        TLBaseDataMd5List *baseDataMd5List = result;
        [NSKeyedArchiver archiveRootObject:baseDataMd5List toFile:TLBaseDataFilePathMd5];
    } failure:nil resultClass:[TLBaseDataMd5List class]];
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

@end
