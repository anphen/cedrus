//
//  TLMy_Income.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMy_Income.h"
#import "TLMy_Income_List.h"
#import "MJExtension.h"
@implementation TLMy_Income

-(NSDictionary *)objectClassInArray
{
    return @{@"my_income_list":[TLMy_Income_List class]};
}

MJCodingImplementation
@end
