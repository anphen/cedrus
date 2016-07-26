//
//  TLProdParameters.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLProdParameters <NSObject>

@end

@interface TLProdParameters : JSONModel

@property (nonatomic,copy) NSString *item_name;
@property (nonatomic,copy) NSString *item_value;


@end
