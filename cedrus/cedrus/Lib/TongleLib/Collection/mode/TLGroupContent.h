//
//  TLGroupContentList.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLGroupContent <NSObject>


@end


@interface TLGroupContent : JSONModel

@property (nonatomic,copy)  NSString *item;


@property (nonatomic,copy)  NSString *qty;


@property (nonatomic,copy)  NSString *price;

@end
