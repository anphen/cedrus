//
//  LTNavigationViewController.m
//  cedrus
//
//  Created by X Z on 16/7/22.
//  Copyright © 2016年 LT. All rights reserved.
//

#import "LTNavigationViewController.h"

@interface LTNavigationViewController ()

@end

@implementation LTNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.35 green:0.76 blue:0.98 alpha:1.00];
}

+ (void)initialize
{
//    UIImage *bg = [UIImage imageNamed:@""];
    
    UINavigationBar *bar = [UINavigationBar appearance];
        [bar setTintColor:[UIColor blackColor]];
//    [bar setBackgroundImage:bg forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [button setTitle:@"back_image" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.bounds = CGRectMake(0, 0, 70, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
