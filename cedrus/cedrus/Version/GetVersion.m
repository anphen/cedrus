//
//  GetVersion.m
//  korea
//
//  Created by y on 15/11/13.
//  Copyright © 2015年 b5m. All rights reserved.
//

#import "GetVersion.h"
#import "MJExtension.h"
#import "LTUrlUtility.h"
#import "LTVersionItem.h"

@interface GetVersion () <UIAlertViewDelegate>
{
    NSString * _currentVersion;
}
@property (nonatomic, strong) GetVersionApi *versionApi;
@property (nonatomic, strong) LTVersionItem *versionItem;

@end

@implementation GetVersion

+(instancetype)sharedInstance {
    static GetVersion *sharedGetVersion = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedGetVersion = [[self alloc] init];
    });
    return sharedGetVersion;
}

- (void)checkVersion {
    NSString *firstTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstTime"];
    NSString *curentDate = [self stringFromDate:[NSDate date]];
    BOOL isFirstTime = firstTime.length>0 ? ![firstTime isEqualToString:curentDate] : NO;
    if (firstTime.length == 0 || isFirstTime) {
        [self isNewVersion];
    }
}

- (void)isNewVersion {
    if (!_versionApi) {
        _versionApi = [[GetVersionApi alloc] init];
    }
    
    [_versionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        id json = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
        
        LTGlobalItem *item = [[LTGlobalItem alloc]initWithItemClass:@"LTVersionItem" json:json];
        if ([item handleHead]) {
            LTVersionItem *bodyItem = (LTVersionItem *)item.bodyItem;
            self.versionItem = bodyItem;
            if ([bodyItem.has_update integerValue] == 1 && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"IgnoreVersion"] isEqualToString:bodyItem.recently_version_no]) {
                 [[NSUserDefaults standardUserDefaults] setObject:[self stringFromDate:[NSDate date]] forKey:@"firstTime"];
                [self showNewVersionAlertWithMessage:[NSString stringWithFormat:@"最新版本:%@", bodyItem.recently_version_no]];
            }
        }

    } failure:^(__kindof YTKBaseRequest *request) {
        
        LTLog(@"fail");
    }];
}

#pragma mark Action

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:date];
    return oneDayStr;
}

- (void)gotoAppStoreToUpdate {
    NSURL *url = [NSURL URLWithString:self.versionItem.recently_version_link];
    
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark UIAlertView
- (void)showNewVersionAlertWithMessage:(NSString *)message {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"立刻更新",@"忽略此版本", nil];
    alert.tag = 20202;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 20202) {
        switch (buttonIndex) {
            case 1:
                [self gotoAppStoreToUpdate];
                break;
            case 2:
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.versionItem.recently_version_no] forKey:@"IgnoreVersion"];
                break;
            default:
                break;
        }
    }
}
@end

@implementation GetVersionApi

- (NSString *)requestUrl
{
    return @"/system/version_check";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return [LTUrlUtility getParametersWithDictionary:@{@"local_app_version":@"1.3.0", @"mobile_os_no":@"1"} loginState:LTLoginStateNO];
}

@end