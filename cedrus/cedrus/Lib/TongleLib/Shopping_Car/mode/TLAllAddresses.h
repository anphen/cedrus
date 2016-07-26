//
//  TLAllAddresses.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JSONModel.h"
#import "TLAddress.h"

@interface TLAllAddresses : NSObject<NSCoding>

@property (nonatomic,strong) NSMutableArray *my_address_list;
//@property (nonatomic,strong) NSArray<TLAddress,ConvertOnDemand> *my_address_list;

@end
