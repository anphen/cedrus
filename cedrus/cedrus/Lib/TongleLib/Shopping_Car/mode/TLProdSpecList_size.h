//
//  TLProdSpecList_size.h
//  tongle
//
//  Created by liu on 15-5-7.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol TLProdSpecList_size

@end

@interface TLProdSpecList_size : JSONModel

//规格ID
@property (nonatomic,copy) NSString *prod_spec_id;
//规格名称
@property (nonatomic,copy) NSString *prod_spec_name;
//规格尺寸
@property (nonatomic,copy) NSString *spec_detail_id;
//详细尺寸
@property (nonatomic,copy) NSString *spec_detail_name;


@end
