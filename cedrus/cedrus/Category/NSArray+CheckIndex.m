//
//  NSArray+CheckIndex.m
//  cedrus
//
//  Created by X Z on 16/7/20.
//  Copyright © 2016年 LT. All rights reserved.
//

#import "NSArray+CheckIndex.h"

@implementation NSArray (CheckIndex)

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count])
    {
        return nil;
    }

    id value = [self objectAtIndex:index];
    if (value == [NSNull null])
    {
        return nil;
    }
    return value;
}

@end
