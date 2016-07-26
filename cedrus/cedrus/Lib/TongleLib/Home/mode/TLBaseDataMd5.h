//
//  TLBaseDataMd5.h
//  tongle
//
//  Created by jixiaofei-mac on 15-11-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"


@protocol TLBaseDataMd5

@end


@interface TLBaseDataMd5 : JSONModel

@property (nonatomic,copy) NSString *base_data_type;
@property (nonatomic,copy) NSString *data_md5_value;

@end
