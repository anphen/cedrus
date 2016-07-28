//
//  LTUrlUtility.h
//  cedrus
//
//  Created by X Z on 16/7/22.
//  Copyright © 2016年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LoginStateType) {
    LTLoginStateNO = 1,
    LTLoginStateYes
};

@interface LTUrlUtility : NSObject

+ (NSString *)baseUrl;

+ (NSDictionary *)getParametersWithDictionary:(NSDictionary *)paramDictionary loginState:(LoginStateType)type;

@end
