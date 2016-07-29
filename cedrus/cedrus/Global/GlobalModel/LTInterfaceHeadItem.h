//
//  LTInterfaceHeadItem.h
//  cedrus
//
//  Created by X Z on 16/7/29.
//  Copyright © 2016年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTBaseItem.h"

@interface LTInterfaceHeadItem :LTBaseItem

@property (nonatomic, copy) NSString *function_id;
@property (nonatomic, copy) NSString *return_flag;
@property (nonatomic, copy) NSString *return_message;

@end
