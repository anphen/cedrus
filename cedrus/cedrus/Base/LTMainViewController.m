//
//  LTMainViewController.m
//  cedrus
//
//  Created by X Z on 16/7/22.
//  Copyright © 2016年 LT. All rights reserved.
//

#import "LTMainViewController.h"
#import "LTHomeViewController.h"
#import "LTNavigationViewController.h"
#import "LTClassifyViewController.h"
#import "LTTabBar.h"

@interface LTMainViewController ()

@end

@implementation LTMainViewController

+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setValue:[[LTTabBar alloc] init] forKeyPath:@"tabBar"];
    
    [self setupChildViewControllers];
}

/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{

    LTHomeViewController *homeViewController = [[LTHomeViewController alloc]init];
    homeViewController.requestURL = @"https://www.baidu.com/";
    [self setupOneChildViewController:homeViewController title:@"Home" image:@"icon_home_nor" selectedImage:@"icon_home_check"];
    
    UIViewController *v2 = [[UIViewController alloc]init];
    v2.view.backgroundColor = [UIColor redColor];
    [self setupOneChildViewController:v2 title:@"Classify" image:@"icon_classify_nor" selectedImage:@"icon_classify_check"];
    
    UIViewController *v3 = [[UIViewController alloc]init];
    v3.view.backgroundColor = [UIColor yellowColor];
    [self setupOneChildViewController:v3 title:@"Cart" image:@"icon_cart_nor" selectedImage:@"icon_cart_check"];
    
    UIViewController *v4 = [[UIViewController alloc]init];
    v4.view.backgroundColor = [UIColor grayColor];
    [self setupOneChildViewController:v4 title:@"Account" image:@"icon_account_nor" selectedImage:@"icon_account_check"];
    
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    [vc.tabBarItem setTitleTextAttributes:@{[UIColor colorWithRed:0.35 green:0.76 blue:0.98 alpha:1.00]:NSForegroundColorAttributeName} forState:UIControlStateSelected];
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[LTNavigationViewController alloc] initWithRootViewController:vc]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
