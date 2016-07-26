//
//  TLTabbarTouristController.m
//  tongle
//
//  Created by jixiaofei-mac on 16/1/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLTabbarTouristController.h"
#import "TLCommon.h"
#import "UIImage+TL.h"
#import "TLImageName.h"
#import "TLLandViewController.h"

@implementation TLTabbarTouristController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];

        UINavigationController *firstNav  = [storyBoard instantiateViewControllerWithIdentifier:@"firstnavigation"];
        
        UINavigationController *secondNav = [self creatNavigationControllerWithIdent:@"firstnavi" image:@"collect_normal" selectImage:TL_COLLECT_PRESS title:@"收藏"];
        
        UINavigationController *thirdNav  = [storyBoard instantiateViewControllerWithIdentifier:@"findnavigation"];
        
        UINavigationController *fourthNav = [self creatNavigationControllerWithIdent:@"firstnavi" image:@"shoppingCart_normal" selectImage:TL_SHOPPING_CART_PRESS title:@"购物车"];
        
        UINavigationController *fifthNav = [self creatNavigationControllerWithIdent:@"firstnavi" image:@"my_normal" selectImage:TL_ME_PRESS title:@"我的"];
        
        self.viewControllers = [NSArray arrayWithObjects:firstNav,secondNav,thirdNav,fourthNav,fifthNav, nil];
    }
    return self;
}

-(UINavigationController *)creatNavigationControllerWithIdent:(NSString *)Ident image:(NSString *)imageString selectImage:(NSString *)selectImage title:(NSString *)title
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
    
    UINavigationController *Navi  = [storyBoard instantiateViewControllerWithIdentifier:Ident];
    Navi.tabBarItem.image = [UIImage originalImageWithName:imageString];
    Navi.tabBarItem.selectedImage = [UIImage originalImageWithName:selectImage];
    Navi.tabBarItem.title = title;
    TLLandViewController *landController2 = (TLLandViewController *)Navi.topViewController;
    landController2.backType = TLNO;
    landController2.navigationItem.title = title;
    landController2.hide = @"隐藏";
    return Navi;
}


@end
