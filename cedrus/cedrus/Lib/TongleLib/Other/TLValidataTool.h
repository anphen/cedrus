//
//  TLValidataTool.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-29.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLValidataTool : NSObject

+(BOOL)checkPhoneNumInput:(NSString *)tel;
+ (BOOL) isValidZipcode:(NSString*)value ;

@end
