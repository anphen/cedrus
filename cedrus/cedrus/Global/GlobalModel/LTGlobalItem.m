//
//  LTGlobalItem.m
//  cedrus
//
//  Created by X Z on 16/7/29.
//  Copyright © 2016年 LT. All rights reserved.
//

#import "LTGlobalItem.h"
#import "LTInterfaceHeadItem.h"
#import "MBProgressHUD+MJ.h"
#import "UIApplication+ActivityViewController.h"
#import "TLLandViewController.h"
#import <YYModel.h>

@implementation LTGlobalItem

- (instancetype)initWithItemClass:(NSString *)classString json:(NSDictionary *)jsonDic
{
    self = [super init];
    if (self) {
        if (!LTIsDictionary(jsonDic)) {
            return self;
        }
        if (LTIsDictionary(jsonDic[@"head"])) {
            self.headItem = [LTInterfaceHeadItem yy_modelWithJSON:jsonDic[@"head"]];
        }
        if (LTIsDictionary(jsonDic[@"body"])) {
            Class cls = NSClassFromString(classString);
            self.bodyItem = [cls yy_modelWithJSON:jsonDic[@"body"]];
        }
    }
    return self;
}

- (BOOL)handleHead
{
    if ([self.headItem.return_flag isEqualToString:@"1"])
    {
        NSString *message = [NSString stringWithFormat:@"操作失败%@", self.headItem.return_message];
        //提示用户错误信息
        [MBProgressHUD showError:message];
        return NO;
    }
    else if ([self.headItem.return_flag isEqualToString:@"2"] ||
             [self.headItem.return_flag isEqualToString:@"3"])
    {
#pragma mark 需要修改登录
        if (![[[UIApplication sharedApplication] activityViewController] isKindOfClass:[TLLandViewController class]])
        {
//            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
//            TLLandViewController *landController =
//                [storyBoard instantiateViewControllerWithIdentifier:@"land"];
//            landController.backType = TLYES;
//            landController.headtitle = @"登录";
//            landController.hide = @"隐藏";
//            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"auto_login"];
//            [[[UIApplication sharedApplication] activityViewController]
//                    .navigationController pushViewController:landController
//                                                    animated:YES];
            NSURL *url = [NSURL URLWithString:@"lt://m.lt.com/modal/TLLandViewController?hideBool=0&headtitle=登录&hide=hide"];
            [[UIApplication sharedApplication]openURL:url];
        }
        return NO;
    }
    return YES;
}

@end
