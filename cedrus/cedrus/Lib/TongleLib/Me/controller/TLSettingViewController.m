//
//  TLSettingViewController.m
//  tongle
//
//  Created by ruibin liu on 15/6/20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSettingViewController.h"
#import "TLsettingitem.h"
#import "TLMagicShopViewController.h"
#import "TLFieldViewController.h"
#import "TLFunctionViewController.h"
#import "TLImageName.h"
#import "TLCommon.h"



@interface TLSettingViewController ()

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,assign) BOOL isAutoLand;
@property (nonatomic,assign) BOOL rememPsw;

@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;

@property (weak, nonatomic) IBOutlet UIButton *quit;


- (IBAction)autoSwitch:(UISwitch *)sender;

- (IBAction)rememberSwitch:(UISwitch *)sender;


- (IBAction)quitBtn:(UIButton *)sender;



@end

@implementation TLSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self setSwitch];
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


-(void)setSwitch
{
    self.isAutoLand = [[NSUserDefaults standardUserDefaults] boolForKey:@"auto_login"];
    [self.autoSwitch setOn:self.isAutoLand];
    self.rememPsw = [[NSUserDefaults standardUserDefaults] boolForKey:@"rememPsw"];
    [self.rememberSwitch setOn:self.rememPsw];
    [self.quit.layer setMasksToBounds:YES];
    [self.quit.layer setCornerRadius:3.0];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[TLFieldViewController class]]) {
        TLFieldViewController *fieldViewController = vc;
        fieldViewController.sign = @"设置";
    }else if ([vc isKindOfClass:[TLFunctionViewController class]])
    {
        TLFunctionViewController *function = vc;
        function.style = @"功能介绍";
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)autoSwitch:(UISwitch *)sender {
    if ([sender isOn]) {
        [self.autoSwitch setOn:YES animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"auto_login"];
        
        [self.rememberSwitch setOn:YES animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"rememPsw"];
    }else
    {
        [self.autoSwitch setOn:NO animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"auto_login"];
    }
}

- (IBAction)rememberSwitch:(UISwitch *)sender {
    if ([sender isOn]) {
        [self.rememberSwitch setOn:YES animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"rememPsw"];
    }else
    {
        [self.rememberSwitch setOn:NO animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"rememPsw"];
        
        [self.autoSwitch setOn:NO animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"auto_login"];
    }

    
}

- (IBAction)quitBtn:(UIButton *)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ckfirstnavi"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isquit"];
    
}
@end
