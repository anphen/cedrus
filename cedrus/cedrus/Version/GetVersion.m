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

@interface GetVersion () <UIAlertViewDelegate>
{
    NSString * _currentVersion;
}
@property (nonatomic, strong) GetVersionApi *versionApi;
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
        LTLog(@"%@", json);
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        
        
        LTLog(@"fail");
    }];
//    [_versionApi startWithCompletionBlockWithSuccess:^(B5MBaseRequest *request) {
//        NSString * versonString = request.responseJSONObject[@"version"];
//        _currentVersion = request.responseJSONObject[@"version"];
//        switch ([request.responseJSONObject[@"is_new"] integerValue]) {
//            case 0: {
//                
//                [[NSUserDefaults standardUserDefaults] setObject:[self stringFromDate:[NSDate date]] forKey:@"firstTime"];
//                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"IgnoreVersion"] isEqualToString:_currentVersion]) {
//                    return ;
//                }
//                [self showNewVersionAlertWithMessage:[NSString stringWithFormat:@"最新版本:%@",versonString]];
//            }
//                break;
//                
//            default:
//                break;
//        }
//    } failure:^(B5MBaseRequest *request) {
//        
//    }];
}

#pragma mark Action

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:date];
    return oneDayStr;
}

- (void)gotoAppStoreToUpdate {
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/id1019035025?mt=8"];//bang5mai/
    
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
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",_currentVersion] forKey:@"IgnoreVersion"];
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
//    NSDictionary *dic = @{@"head":@{@"user_id":@"",
//                                    @"user_token":@"",
//                                    @"app_inner_no":@"01"
//                                    },
//                          @"local_app_version":@"1.3.0",
//                          @"mobile_os_no":@"1"
//                          };
//    
//   NSString *json_string = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
//    
//    return @{@"parameters_json": json_string};
    return [LTUrlUtility getParametersWithDictionary:@{@"local_app_version":@"1.3.0", @"mobile_os_no":@"1"} loginState:LTLoginStateNO];
}

//- (YTKRequestSerializerType)requestSerializerType
//{
//    return YTKRequestSerializerTypeJSON;
//}

@end