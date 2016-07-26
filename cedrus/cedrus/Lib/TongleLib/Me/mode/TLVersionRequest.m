//
//  TLVersionRequest.m
//  tongle
//
//  Created by liu on 15-4-29.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLVersionRequest.h"
#import <UIKit/UIKit.h>
#import "TLCommon.h"

@implementation TLVersionRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mobile_os_no = MOBILE_OS_NO_IPHONE;
        //_app_inner_no = @"";
    }
    return self;
}


@end
