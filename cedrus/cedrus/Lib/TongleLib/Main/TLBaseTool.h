//
//  TLBaseTool.h
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSError.h>
#import "TLHttpTool.h"

@interface TLBaseTool : NSObject

+ (void)postWithURL:(NSString *)url param:(NSObject *)param success:(void (^)(id result))success failure:(HttpRequestFailure)failure resultClass:(Class)resultClass;


+ (void)MJpostWithURL:(NSString *)url param:(NSObject *)param success:(void (^)(id result))success failure:(HttpRequestFailure)failure resultClass:(Class)resultClass;

+ (void)postWithURL:(NSString *)url param:(NSObject *)param success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

@end
