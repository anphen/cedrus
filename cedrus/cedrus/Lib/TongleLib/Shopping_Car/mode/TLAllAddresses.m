//
//  TLAllAddresses.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLAllAddresses.h"
#import "TLAddress.h"
#import "MJExtension.h"

@implementation TLAllAddresses

-(NSDictionary *)objectClassInArray
{
    return @{@"my_address_list":[TLAddress class]};
}



MJCodingImplementation


@end
