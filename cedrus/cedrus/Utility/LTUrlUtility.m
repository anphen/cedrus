//
//  LTUrlUtility.m
//  cedrus
//
//  Created by X Z on 16/7/22.
//  Copyright © 2016年 LT. All rights reserved.
//

#import "LTUrlUtility.h"
#import "TLPersonalMegTool.h"
#import "TLPersonalMeg.h"

@implementation LTUrlUtility

+ (NSString *)baseUrl
{
    return @"http://117.78.37.252/api/2.0/";
}

+ (NSDictionary *)getParametersWithDictionary:(NSDictionary *)paramDictionary loginState:(LoginStateType)type
{
    NSString *parametersString;
    NSMutableDictionary *parameDic = [NSMutableDictionary dictionaryWithDictionary:paramDictionary];
    switch (type) {
        case LTLoginStateNO:{
             NSDictionary *headDict = [NSDictionary dictionaryWithObjectsAndKeys:APP_INNER_NO,@"app_inner_no",@"",@"user_id",@"",@"user_token", nil];
            [parameDic setValue:headDict forKey:@"head"];
            
        }
            break;
        case LTLoginStateYes:{            
            NSDictionary *headDict = [NSDictionary dictionaryWithObjectsAndKeys:APP_INNER_NO,@"app_inner_no",[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",[TLPersonalMegTool currentPersonalMeg].token,@"user_token", nil];
            [parameDic setValue:headDict forKey:@"head"];
        }
            break;
            
        default:
            break;
    }
    
    parametersString = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:parameDic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    NSDictionary * parametersjson = @{@"parameters_json" : parametersString};
    
    return parametersjson;
}
@end
