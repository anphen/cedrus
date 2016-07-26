//
//  TLMagicShop.h
//  TL11
//
//  Created by liu on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@protocol  TLMagicShop

@end

@interface TLMagicShop : JSONModel

@property (nonatomic,copy) NSString *mstore_id;
@property (nonatomic,copy) NSString *mstore_name;
@property (nonatomic,copy) NSString *mstore_pic_url;
@property (nonatomic,copy) NSString *mstore_favorited_by_me;

@end
