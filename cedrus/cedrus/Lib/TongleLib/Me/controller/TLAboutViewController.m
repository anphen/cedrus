//
//  TLAboutViewController.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-27.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLAboutViewController.h"
#import "TLFunctionViewController.h"
#import "TLBaseTool.h"
#import "TLVersionRequest.h"
#import "TLVersionParam.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "UIColor+TL.h"
#import "TLImageName.h"
#import "Url.h"

@interface TLAboutViewController ()

@property (nonatomic,strong) TLVersionParam *version;


@property (weak, nonatomic) IBOutlet UILabel *localAppVersion;


@property (weak, nonatomic) IBOutlet UIButton *versionbtn;

@end

@implementation TLAboutViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    

    [self.versionbtn.layer setMasksToBounds:YES];
    [self.versionbtn.layer setCornerRadius:3.0];
    self.versionbtn.backgroundColor = [UIColor getColor:@"72c6f7"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
     self.localAppVersion.text = app_Version;
    //[self loadata];
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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLFunctionViewController class]]) {
        TLFunctionViewController *funchtion = vc;
        funchtion.style = @"版权申明";
    }
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
