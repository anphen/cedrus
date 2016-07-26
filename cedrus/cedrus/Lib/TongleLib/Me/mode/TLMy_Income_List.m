//
//  TLMy_Income_List.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMy_Income_List.h"
#import "TLMyIncome_List.h"
#import "MJExtension.h"


@implementation TLMy_Income_List

MJCodingImplementation


-(NSDictionary *)objectClassInArray
{
    return @{@"income_list":[TLMyIncome_List class]};
}

@end
