//
//  TLTabBarViewController.m
//  TL11
//
//  Created by liu on 15-4-20.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLTabBarViewController.h"
#import "TLCollectViewController.h"



@interface TLTabBarViewController ()

@end

@implementation TLTabBarViewController

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
//    TLCollectViewController *post = [[TLCollectViewController alloc]init];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:post];
//    [self addChildViewController:navi];
    
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

@end
