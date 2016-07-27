//
//  AppDelegate.m
//  cedrus
//
//  Created by X Z on 16/7/6.
//  Copyright © 2016年 LT. All rights reserved.
//

#import "AppDelegate.h"
#import "LTMainViewController.h"
#import "LTUrlUtility.h"
#import "NSArray+CheckIndex.h"
#import "TLBaseTool.h"
#import "TLCommon.h"
#import "TLVersionParam.h"
#import "TLVersionRequest.h"
#import "Url.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <AlipaySDK/AlipaySDK.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <JLRoutes.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <YTKNetworkConfig.h>
#import "UserGuideController.h"
#import "GetVersion.h"

@interface AppDelegate () <WXApiDelegate, UIAlertViewDelegate, BMKLocationServiceDelegate>
{
    UIWindow *_splashWindow;
}

@property (nonatomic, copy) NSString *payResult;
@property (nonatomic, strong) TLVersionParam *version;
@property (nonatomic, strong) BMKLocationService *locService;

@end

@implementation AppDelegate

#pragma mark - life cycle
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setNetWorkConfig];
    [self configShareSDK];
    [self configRoutes];
    [self showMainView];
    [self checkFirstLanch];
    [[GetVersion sharedInstance]checkVersion];
    //    [ShareSDK registerApp:@"888f5d8355d8"];
    //    [self initializaPlat];

    //    BOOL isok = [WXApi registerApp:TL_WXAPPID withDescription:@"tongle"];

    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];


    //    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Tongle_Base" bundle:nil];
    //    if ([[NSUserDefaults standardUserDefaults] objectForKey:TLLEADKRY])
    //    {
    //        self.window.rootViewController =
    //        [storyBoard instantiateViewControllerWithIdentifier:@"firstnavi"];
    //    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

    // Restart any tasks that were paused (or not yet started) while the application was inactive.
    // If the application was previously in the background, optionally refresh the user interface.
    [self versionCheck];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //    return [ShareSDK handleOpenURL:url wxDelegate:self];
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{

    if ([sourceApplication isEqualToString:@"com.tencent.xin"])
    {
        //微信支付和微信分享返回
        //        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD
        //        bundle:nil];
        //        TLProdPurchaseViewController *prodPurchase = [storyboard
        //        instantiateViewControllerWithIdentifier:TL_PROD_PURCHASE];
        //        [self.navigationController pushViewController:prodPurchase animated:YES];
        return [WXApi handleOpenURL:url delegate:self];
        //    }else if ([sourceApplication isEqualToString:@"com.sina.weibo"]){
        //            //        微博分享返回
        //            //        return [ShareSDK handleOpenURL:url
        //            sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
        //                    return [WeiboSDK handleOpenURL:url delegate:self];
    }
    else if ([sourceApplication isEqualToString:@"com.sina.weibo"])
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    else
    { //支付宝法返回
        //   [self parse:url application:application];
        if ([url.host isEqualToString:@"safepay"])
        {
            //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                      standbyCallback:^(NSDictionary *resultDic){
                                                      }];
        }

        if ([url.host isEqualToString:@"platformapi"])
        {
            //支付宝钱包快登授权返回authCode
            [[AlipaySDK defaultService] processAuthResult:url
                                          standbyCallback:^(NSDictionary *resultDic){
                                          }];
        }

        return YES;
    }
    return YES;
}

#pragma mark - check launch & vesion
- (void)checkFirstLanch
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"]) {
        [self showGuideView];
    }
}

- (void)showGuideView
{
    if (!_splashWindow) {
        UserGuideController *guideViewController = [[UserGuideController alloc] init];
       _splashWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _splashWindow.userInteractionEnabled = YES;
        _splashWindow.rootViewController = guideViewController;
        [_splashWindow makeKeyAndVisible];
    }
}

- (void)dismissGuideView
{
    _splashWindow = nil;
}

- (void)showMainView
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[LTMainViewController alloc] init];
    [self.window makeKeyAndVisible];
}

#pragma mark - config & setup
- (void)configShareSDK
{

    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login
     * 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"888f5d8355d8"

        activePlatforms:@[
            @(SSDKPlatformTypeSinaWeibo),
            @(SSDKPlatformTypeWechat),
        ]
        onImport:^(SSDKPlatformType platformType) {
            switch (platformType)
            {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
            }
        }
        onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {

            switch (platformType)
            {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:TL_WBAPPID
                                          appSecret:TL_WBAPPSECRET
                                        redirectUri:@"http://www.baidu.com"
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:TL_WXAPPID appSecret:TL_WXAPPSECRET];
                break;
            default:
                break;
            }
        }];
}

- (void)setNetWorkConfig
{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = [LTUrlUtility baseUrl];
}

- (void)configRoutes
{
    
}

- (void)onResp:(BaseResp *)resp
{
    // NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;

    if ([resp isKindOfClass:[PayResp class]])
    {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];

        switch (resp.errCode)
        {
        case WXSuccess:
            self.payResult = @"订单支付完成";
            break;

        default:
            self.payResult = @"订单支付失败";
            break;
        }
    }
    else if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //支付分享返回结果，
        strTitle = [NSString stringWithFormat:@"微信分享结果"];

        switch (resp.errCode)
        {
        case WXSuccess:
            self.payResult = @"微信分享完成";
            break;

        default:
            self.payResult = @"微信分享失败";
            break;
        }
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:self.payResult
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([self.payResult isEqualToString:@"订单支付完成"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"payResult" object:nil];
    }
    if (([alertView.title isEqualToString:@"版本更新"] && alertView.numberOfButtons == 1 && buttonIndex == 0)
        || ([alertView.title isEqualToString:@"版本更新"] && alertView.numberOfButtons == 2 && buttonIndex == 1))
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_version.recently_version_link]];
    }
    else if (([alertView.title isEqualToString:@"版本更新"] && alertView.numberOfButtons == 2
              && buttonIndex == 0))
    {
        [[NSUserDefaults standardUserDefaults] setObject:_version.recently_version_no
                                                  forKey:TL_CANCEL_UP_NO];
    }
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSString *longitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
    NSString *vatitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
    [TLUserDefaults setObject:longitude forKey:TL_LONGITUDE];
    [TLUserDefaults setObject:vatitude forKey:TL_LATITUDE];
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    [TLUserDefaults setObject:@"" forKey:TL_LONGITUDE];
    [TLUserDefaults setObject:@"" forKey:TL_LATITUDE];
}

//版本更新检查
- (void)versionCheck
{

    NSString *url = [NSString stringWithFormat:@"%@%@", Url, version_check_Url];
    TLVersionRequest *versionRequest = [[TLVersionRequest alloc] init];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *app_Version_Number =
        [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];

    versionRequest.local_app_version = app_Version;

    NSArray *array_local_Version = [app_Version componentsSeparatedByString:@"."];

    [TLBaseTool postWithURL:url
        param:versionRequest
        success:^(id result) {
            TLVersionParam *version = result;
            _version = version;
            NSString *array_recently_Version_Number =
                [version.recently_version_no stringByReplacingOccurrencesOfString:@"."
                                                                       withString:@""];

            if ([array_recently_Version_Number integerValue] > [app_Version_Number integerValue])
            {
                NSArray *array_recently_Version =
                    [version.recently_version_no componentsSeparatedByString:@"."];

                if ((![array_recently_Version[0] isEqualToString:array_local_Version[0]])
                    || (![array_recently_Version[1] isEqualToString:array_local_Version[1]]))
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"版本更新"
                                                                            message:nil
                                                                           delegate:self
                                                                  cancelButtonTitle:nil
                                                                  otherButtonTitles:@"更新", nil];
                        [alertview show];
                    });
                }
                else if (![[array_recently_Version objectAtIndexCheck:2]
                             isEqualToString:[array_local_Version objectAtIndexCheck:2]])
                {
                    NSString *cancel_up_no =
                        [[NSUserDefaults standardUserDefaults] objectForKey:TL_CANCEL_UP_NO];

                    if (![cancel_up_no isEqualToString:version.recently_version_no])
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertView *alertview =
                                [[UIAlertView alloc] initWithTitle:@"版本更新"
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"更新", nil];
                            [alertview show];
                        });
                    }
                }
            }
        }
        failure:^(NSError *error) {
            error = nil;
        }
        resultClass:[TLVersionParam class]];
}

//-(void)initializaPlat
//{
//
//    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
//
//    [ShareSDK  connectSinaWeiboWithAppKey:TL_WBAPPID
//                                appSecret:TL_WBAPPSECRET
//                              redirectUri:@"http://www.baidu.com"
//                              weiboSDKCls:[WeiboSDK class]];
//
//    //添加微信应用  http://open.weixin.qq.com
//    [ShareSDK connectWeChatWithAppId:TL_WXAPPID
//                           appSecret:TL_WXAPPSECRET
//                           wechatCls:[WXApi class]];
//}


@end
