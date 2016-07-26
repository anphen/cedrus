//
//  TLBaseTool.m
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLBaseTool.h"
#import "JSONModel.h"
#import "MJExtension.h"

@implementation TLBaseTool

+ (void)postWithURL:(NSString *)url param:(NSObject *)param success:(void (^)(id result))success failure:(HttpRequestFailure)failure resultClass:(Class)resultClass
{
    //拿到请求参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setDictionary:param.keyValues];
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        if (success == nil) return;
       // id result = [resultClass objectWithKeyValues:json[@"body"]];
        id result = [[resultClass alloc]initWithDictionary:json[@"body"] error:nil];
        success(result);
    } failure:failure];
    
}
+ (void)MJpostWithURL:(NSString *)url param:(NSObject *)param success:(void (^)(id result))success failure:(HttpRequestFailure)failure resultClass:(Class)resultClass
{
    //拿到请求参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setDictionary:param.keyValues];
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        if (success == nil) return;
        id result = [resultClass objectWithKeyValues:json[@"body"]];
        success(result);
    } failure:failure];
    
}

+ (void)postWithURL:(NSString *)url param:(NSObject *)param success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    //拿到请求参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setDictionary:param.keyValues];
    //发送请求
    [TLHttpTool postWithURL:url params:params success:^(id json) {
        if (success == nil) return;
        success(json);
    } failure:failure];
    
}


@end
