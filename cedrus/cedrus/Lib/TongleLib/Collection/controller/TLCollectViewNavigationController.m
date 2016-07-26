//
//  TLCollectViewNavigationController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/1/21.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLCollectViewNavigationController.h"
#import "TLLandViewController.h"
#import "TLCommon.h"

@interface TLCollectViewNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation TLCollectViewNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    __weak TLCollectViewNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}



@end
