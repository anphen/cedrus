//
//  CKLeadController.m
//  ChouKe
//
//  Created by jixiaofei-mac on 16/5/26.
//  Copyright © 2016年 ilingtong. All rights reserved.
//

#import "CKLeadController.h"
#import "ZWIntroductionViewController.h"
#import "TLCommon.h"
#import "Url.h"
#import "TLHttpTool.h"
#import "TLBaseTool.h"
#import "TLBaseDataMd5List.h"


@interface CKLeadController ()

@property (nonatomic, strong) ZWIntroductionViewController *introductionView;

@end

@implementation CKLeadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:TLLEADKRY])
    {
        NSArray *coverImageNames = @[@"tongle_lead_001", @"tongle_lead_002", @"tongle_lead_003"];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:nil];
        [self.view addSubview:self.introductionView.view];
        
        __weak CKLeadController *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:TLLEADKRY];
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:TLAUTOLAND];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"rememPsw"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"auto_login"];
            weakSelf.view.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ckfirstnavi"];
        };
        
    }
    
    // Do any additional setup after loading the view.
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
