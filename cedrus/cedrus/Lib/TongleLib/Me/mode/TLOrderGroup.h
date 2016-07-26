//
//  TLOrderGroup.h
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TLOrderGroup : NSObject

@property (nonatomic,copy)  NSString    *Order_No;
@property (nonatomic,assign) int        All_Number;
@property (nonatomic,assign) double     Freight;
@property (nonatomic,assign) double     All_Price;
@property (nonatomic,strong) NSArray    *OrderArray;
@property (nonatomic,assign) BOOL       IsCompleted;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)OrderWithDict:(NSDictionary *)dict;

@end
