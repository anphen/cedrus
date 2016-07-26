//
//  TLOrderGroup.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLOrderGroup.h"
#import "TLOrderSingle.h"

@implementation TLOrderGroup

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in self.OrderArray) {
            TLOrderSingle *single = [TLOrderSingle OrderWithDict:dict];
            [temp addObject:single];
        }
        self.OrderArray = temp;
    }
    return self;
}

+(instancetype)OrderWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
