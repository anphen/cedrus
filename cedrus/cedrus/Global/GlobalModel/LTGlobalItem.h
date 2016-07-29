//
//  LTGlobalItem.h
//  cedrus
//
//  Created by X Z on 16/7/29.
//  Copyright © 2016年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTBaseItem.h"

@class LTInterfaceHeadItem;

@interface LTGlobalItem :NSObject

@property (nonatomic, strong) LTInterfaceHeadItem *headItem;
@property (nonatomic, strong) LTBaseItem *bodyItem;

- (instancetype)initWithItemClass:(NSString *)classString json:(NSDictionary *)jsonDic;

- (BOOL)handleHead;

@end
