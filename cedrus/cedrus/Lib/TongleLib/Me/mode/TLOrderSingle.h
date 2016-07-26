//
//  TLOrderSingle.h
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLOrderSingle : NSObject

@property (nonatomic,copy) NSString *Icon;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,copy) NSString *Size;
@property (nonatomic,assign) double Price;
@property (nonatomic,assign) int Number;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)OrderWithDict:(NSDictionary *)dict;

@end
