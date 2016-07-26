//
//  TLHttpTool.m
//  tongle
//
//  Created by liu on 15-4-22.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLHttpTool.h"
#import <AFNetworking.h>
//#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "JSONKit.h"
#import "MJExtension.h"
#import "TLLandViewController.h"
#import "TLCommon.h"
#import "UIApplication+ActivityViewController.h"
#import "Url.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
//#import "CKLandViewController.h"

@implementation TLHttpTool

+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
{
    
    NSMutableDictionary *tempDict;
    
    if ([params objectForKey:@"user_id"]) {
        NSDictionary *headDict = [NSDictionary dictionaryWithObjectsAndKeys:APP_INNER_NO,@"app_inner_no",[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,@"user_token", nil];
        
        NSString *head_string = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:headDict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        tempDict = [NSMutableDictionary dictionaryWithDictionary:params];
        [tempDict setObject:head_string forKey:@"head"];
        
        [tempDict removeObjectForKey:@"user_id"];
        [tempDict removeObjectForKey:@"user_token"];
    }else
    {
         NSDictionary *headDict = [NSDictionary dictionaryWithObjectsAndKeys:APP_INNER_NO,@"app_inner_no",@"",@"user_id",@"",@"user_token", nil];
        
         NSString *head_string = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:headDict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        tempDict = [NSMutableDictionary dictionaryWithDictionary:params];
        [tempDict setObject:head_string forKey:@"head"];
    }


    
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:tempDict];
    
    //1、转换成json string
   // NSString *json_string = [params JSONString];
    NSString *json_string = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    //2、拼接接口
    
    NSDictionary *json = @{@"parameters_json":json_string};
    
        
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 20;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configuration];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:json success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //取出json
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //取出json的head
        NSDictionary *head = json[@"head"];
        //判断接口访问结果
        if ([head[@"return_flag"] intValue] == 1) {
            NSString *message = [NSString stringWithFormat:@"操作失败%@",head[@"return_message"]];
            //提示用户错误信息
            [MBProgressHUD showError:message];
        }else if ([head[@"return_flag"] intValue] == 2 ||[head[@"return_flag"] intValue] == 3)
        {
#pragma mark 需要修改登录
            if (![[[UIApplication sharedApplication] activityViewController] isKindOfClass:[TLLandViewController class]]) {
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
                TLLandViewController *landController = [storyBoard instantiateViewControllerWithIdentifier:@"land"];
                landController.backType = TLYES;
                landController.headtitle = @"登录";
                landController.hide = @"隐藏";
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"auto_login"];
                [[[UIApplication sharedApplication] activityViewController].navigationController pushViewController:landController animated:YES];
            }
        }
        else if(success)
        {
            //成功后返回json
            success(json);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        NSString *warning = @"网络失败，请检查网络...";
        //失败后提示错误原因
        [MBProgressHUD showError:warning];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        
    }];
    
    

//    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:url]];
//    
//    //设置提交的数据编码类型为json格式
//    // [client setParameterEncoding:AFJSONParameterEncoding];
//     //4、发送请求
//    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:url parameters:json];
//    [request setTimeoutInterval:20];
//    [client postPath:nil parameters:json success:^(AFHTTPRequestOperation*operation,id responseObject)
//     {
//         //取出json
//     id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//         //取出json的head
//         NSDictionary *head = json[@"head"];
//         //判断接口访问结果
//         if ([head[@"return_flag"] intValue] == 1) {
//             NSString *message = [NSString stringWithFormat:@"操作失败%@",head[@"return_message"]];
//             //提示用户错误信息
//             [MBProgressHUD showError:message];
//         }else if ([head[@"return_flag"] intValue] == 2 ||[head[@"return_flag"] intValue] == 3)
//         {
//#pragma mark 需要修改登录
//             if (![[[UIApplication sharedApplication] activityViewController] isKindOfClass:[CKLandViewController class]]) {
//                 UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                 CKLandViewController *landController = [storyBoard instantiateViewControllerWithIdentifier:@"ckland"];
//                 landController.backType = TLYES;
//                 landController.headtitle = @"登录";
//                 landController.hide = @"隐藏";
//                 [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"auto_login"];
//                 [[[UIApplication sharedApplication] activityViewController].navigationController pushViewController:landController animated:YES];
//             }
//         }
//         else if(success)
//         {
//             //成功后返回json
//             success(json);
//         }
//     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
//     {
//         if (failure) {
//             failure(error);
//         }
//         NSString *warning = @"网络失败，请检查网络...";
//         //失败后提示错误原因
//         [MBProgressHUD showError:warning];
//         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//             [MBProgressHUD hideHUD];
//         });
//     }];

}


+(NSURLRequest *)h5LoadWithUrl:(NSString *)h5Url footString:(NSString *)footString
{
    NSString *urlString = [NSString stringWithFormat:@"%@?user_id=%@&user_token=%@&app_inner_no=%@",h5Url,[TLPersonalMegTool currentPersonalMeg].user_id,[TLPersonalMegTool currentPersonalMeg].token,APP_INNER_NO];
    
    if (footString.length) {
        urlString = [NSString stringWithFormat:@"%@?user_id=%@&user_token=%@&app_inner_no=%@&%@",h5Url,[TLPersonalMegTool currentPersonalMeg].user_id,[TLPersonalMegTool currentPersonalMeg].token,APP_INNER_NO,footString];
    }
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    return request;
}





@end

