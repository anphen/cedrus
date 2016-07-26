//
//  TLHttpTool.h
//  tongle
//
//  Created by liu on 15-4-22.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSError.h>

typedef void (^HttpRequestSuccess)(id json);
typedef void (^HttpRequestFailure)(NSError *error);


@interface TLHttpTool : NSObject
+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

+(NSURLRequest *)h5LoadWithUrl:(NSString *)h5Url footString:(NSString *)footString;

@end
