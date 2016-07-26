//
//  TLValidataTool.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-29.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLValidataTool.h"

@implementation TLValidataTool

+(BOOL)checkPhoneNumInput:(NSString *)tel
{
    //
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //移动
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //联通
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //电信
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //其他
    NSString * Other = @"^170([059])\\d{7}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestother = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Other];

    BOOL res1 = [regextestmobile evaluateWithObject:tel];
    BOOL res2 = [regextestcm evaluateWithObject:tel];
    BOOL res3 = [regextestcu evaluateWithObject:tel];
    BOOL res4 = [regextestct evaluateWithObject:tel];
    BOOL res5 = [regextestother evaluateWithObject:tel];

    
    if (res1 || res2 || res3 || res4 || res5 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (BOOL) isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    int len = (int)strlen(cvalue);
    if (len != 6) {
        return FALSE;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return FALSE;
        }
    }
    return TRUE;
}

@end
