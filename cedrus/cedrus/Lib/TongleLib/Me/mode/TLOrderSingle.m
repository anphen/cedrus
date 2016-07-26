//
//  TLOrderSingle.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLOrderSingle.h"

@implementation TLOrderSingle

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.Icon = dict[@"Icon"];
        self.Name = dict[@"Name"];
        self.Size = dict[@"Size"];
        self.Price = [dict[@"Price"] intValue];
        self.Number = [dict[@"Number"] intValue];
    }
    return self;
}

+(instancetype)OrderWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
