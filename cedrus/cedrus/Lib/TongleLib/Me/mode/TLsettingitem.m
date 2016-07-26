//
//  TLsettingitem.m
//  tongle
//
//  Created by ruibin liu on 15/6/20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLsettingitem.h"

@implementation TLsettingitem

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class) vcClass
{
    TLsettingitem *item = [[self alloc]init];
    
    item.icon = icon;
    item.title = title;
    item.vcClass = vcClass;
    
    return item;
}

@end
