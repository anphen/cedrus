//
//  TLGroupStore.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/9.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLCommon.h"


@protocol TLGroupStore <NSObject>

@end


@interface TLGroupStore : JSONModel


@property (nonatomic,copy) NSString *code;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *address;

@property (nonatomic,copy) NSString *phone;


@end
