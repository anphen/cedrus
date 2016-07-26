//
//  NSMutableArray+TL.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-6.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "NSMutableArray+TL.h"

@implementation NSMutableArray (TL)

-(void)mutableArraydidWithArray:(NSArray *)array
{
    for (id model in array) {
        [self addObject:model];
    }
}

@end
